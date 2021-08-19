Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE1DC4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7C2610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F7C2610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69FE6E94A;
	Thu, 19 Aug 2021 13:37:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D681A6E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkahBEVJG6aWcr9WObb/DyPcIR95NrTaaJ+XKLxutfLqxn9I05E+PHwXeDVNbyGP4UZSPp1PHomMIJqjFtrU6lJhm0qg5/hIpOA4FB4K66SGQI9dMsr7ftmSnm8RrWNVaeyy23qWQnIIfg9GDlhAQCIZj8q+NjQv+uwDbHJny1iq+9Hvj74BshnEYqzkj79bhn5kMdUaBan6L2JlIVmoVkylI7T8Wreo5Hgx41k73qcg9UCSbVbsXfaiOtOn9Fv1AQMd/uA5AY4WuLR/CPoAd/OWQPATk2kNX5qi1W7iL+mhGIBl9a4KZQq3VhF1roddDhTq33hYoHUZGnQJe9fKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBtJ2utBhAm22dbxqmqFVqBcp6RkFsCEskUsrVIESmk=;
 b=nJIwZEY8qcrc/kBJ7xLPJRfcRkiuC2QKhvoC6U8DLN9GimAomUF3toufCjV3H4BqsI7h7Rv4IIfO9TRUTSDiXh/Z8WKAontbHruUso7tG11vL0b1cTjTAjr3Wg2Dzq0ExxoJ+rP5uYWZxMbHpKvFIzq7+FF2GX3GRL/+CJOaxqVCyBSAVQgX5z8a1e3qCWeRgPHVOmR0w2iZvWl4wtuLCgkyizZisvhzSQhhph/mRrHGsszGgNs1HHkgB6S2OlkgSSCSUw7mdVf/6SZUP6l/YsuoJcNxTs7E+CMVs1Fhh+e97CxNBwEXXi7eSg3s5FTWq0/7W0ZmCykCNXUrOrkHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBtJ2utBhAm22dbxqmqFVqBcp6RkFsCEskUsrVIESmk=;
 b=b8sjwkyAtA4z3aM08Xz/TX9X/ve2z4s/oNShjuz3wbzEagxskP5mfeS9WErOeIdJSywvNBgsyxp8mkTGeRLRtdSaza96jaz83EBGEiJ0lvz0GK7UEt3Oppag9b8GGu90D0EJuhXx6PdGzP2ZnAoKohdqiUw1KHpZKcpuamWi5aQ=
Received: from MWHPR2201CA0058.namprd22.prod.outlook.com
 (2603:10b6:301:16::32) by MW2PR12MB2540.namprd12.prod.outlook.com
 (2603:10b6:907:7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Thu, 19 Aug
 2021 13:37:48 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::97) by MWHPR2201CA0058.outlook.office365.com
 (2603:10b6:301:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:48 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:47 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 03/18] drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs
Date: Thu, 19 Aug 2021 09:36:58 -0400
Message-ID: <20210819133713.4168-4-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 153bd125-56df-46fe-4984-08d9631688d1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25408757D883B90FDC193CE895C09@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BghcajL9tTsQo5emV6IkRVPiwMZCGm9xxtl/UJpcn6snBN1qgvg5AAEDu3oaWFO+m8y+u8ahqphYtxgZ/29PMB4H9DmOJDbBRHShP09Cyf24lWR/P4++gjTCQSR7mUBYJ3T/eUNkkeZLNsnpYBv+hpoRQqqIZhgphZtmsNOX/iQYlJxTcl8Qmj60Bedsdkp8PalRqWycCKY97vI0ShsCl1ueJ7F6YugKaLnO/YQpVrfa+gV6NRnTaUea3qDbfdTyvJhscAtcRcyQgs8NB5f5F6kTbJ1BLdDnb3X6JOqAwCPKwuRClNEyQ9HDhWRAX46SOFkt7QN7LJ3mJvHHI4j/F+b0mvPV184G5jLCFJm5PBYSGjc0wfT08B6m80zkMiyEnN3RSRlo8iqhqWHN7w3pGSEJAXjweQk66xox826nMH4W4tHHeILXGYB3KTnbxuC8AWWO4KNiRzqqfKn0LUIVxiVOm4wtZY05mndXW/T+Tw9wiPjHi56mmhCF3Q3nRBPiN+R+/pMwl/Sa1Id4ZmKJZmW3m7E05z6k6ZSleXLdBN6Vy76fofK0fd3/hPX8y/qmxKTndH65IMX7OILiXYaeKHzWqkt50lnF2bIjzJK+V7a06SOBEeinWLvgRniyCnwI9d2gGylfPuO2Kej9FBezTFMLBtgxvGNiqynmKu9M2ObEC52UAvGVWl69ISTC5dDwFG1nQ+ehvheKngw2tAkARd8kcn7lCnI6oPMhIpyboy9QdkTQSURG0nXL8K8A6jZSWqykEqCSZ25iAlfpCsxIOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(30864003)(4326008)(478600001)(82740400003)(36756003)(26005)(36860700001)(356005)(1076003)(82310400003)(34020700004)(7696005)(2906002)(2616005)(5660300002)(8936002)(6666004)(16526019)(316002)(8676002)(186003)(81166007)(47076005)(86362001)(336012)(54906003)(83380400001)(426003)(70206006)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:48.3904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153bd125-56df-46fe-4984-08d9631688d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Checkpoint-Restore in userspace (CRIU) is a powerful tool that can
snapshot a running process and later restore it on same or a remote
machine but expects the processes that have a device file (e.g. GPU)
associated with them, provide necessary driver support to assist CRIU
and its extensible plugin interface. Thus, In order to support the
Checkpoint-Restore of any ROCm process, the AMD Radeon Open Compute
Kernel driver, needs to provide a set of new APIs that provide
necessary VRAM metadata and its contents to a userspace component
(CRIU plugin) that can store it in form of image files.

This introduces some new ioctls which will be used to checkpoint-Restore
any KFD bound user process. KFD doesn't allow any arbitrary ioctl call
unless it is called by the group leader process. Since these ioctls are
expected to be called from a KFD criu plugin which has elevated ptrace
attached privileges and CAP_SYS_ADMIN capabilities attached with the file
descriptors so modify KFD to allow such calls.

(API redesign suggested by Felix Kuehling and implemented by David Yat
Sin)

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
(cherry picked from commit 72f4907135aed9c037b9f442a6055b51733b518a)
(cherry picked from commit 33ff4953c5352f51d57a77ba8ae6614b7993e70d)
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  70 ++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  69 ++++++++++++++
 include/uapi/linux/kfd_ioctl.h           | 110 ++++++++++++++++++++++-
 3 files changed, 247 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 059c3f1ca27d..a1b60d29aae1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -33,6 +33,7 @@
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/ptrace.h>
 #include <linux/dma-buf.h>
 #include <asm/processor.h>
 #include "kfd_priv.h"
@@ -1802,6 +1803,44 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return -EPERM;
 }
 #endif
+static int kfd_ioctl_criu_dumper(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	pr_debug("Inside %s\n", __func__);
+
+	return 0;
+}
+
+static int kfd_ioctl_criu_restorer(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	pr_debug("Inside %s\n", __func__);
+
+	return 0;
+}
+
+static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void *data)
+{
+	pr_debug("Inside %s\n", __func__);
+
+	return 0;
+}
+
+static int kfd_ioctl_criu_resume(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	pr_debug("Inside %s\n", __func__);
+
+	return 0;
+}
+
+static int kfd_ioctl_criu_process_info(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	pr_debug("Inside %s\n", __func__);
+
+	return 0;
+}
 
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
@@ -1906,6 +1945,21 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
 			kfd_ioctl_set_xnack_mode, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_DUMPER,
+			 kfd_ioctl_criu_dumper, KFD_IOC_FLAG_PTRACE_ATTACHED),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_RESTORER,
+			 kfd_ioctl_criu_restorer, KFD_IOC_FLAG_ROOT_ONLY),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_PROCESS_INFO,
+			 kfd_ioctl_criu_process_info, KFD_IOC_FLAG_PTRACE_ATTACHED),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_RESUME,
+			 kfd_ioctl_criu_resume, KFD_IOC_FLAG_ROOT_ONLY),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_PAUSE,
+			 kfd_ioctl_criu_pause, KFD_IOC_FLAG_PTRACE_ATTACHED),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
@@ -1920,6 +1974,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	char *kdata = NULL;
 	unsigned int usize, asize;
 	int retcode = -EINVAL;
+	bool ptrace_attached = false;
 
 	if (nr >= AMDKFD_CORE_IOCTL_COUNT)
 		goto err_i1;
@@ -1945,7 +2000,15 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	 * processes need to create their own KFD device context.
 	 */
 	process = filep->private_data;
-	if (process->lead_thread != current->group_leader) {
+
+	rcu_read_lock();
+	if ((ioctl->flags & KFD_IOC_FLAG_PTRACE_ATTACHED) &&
+	    ptrace_parent(process->lead_thread) == current)
+		ptrace_attached = true;
+	rcu_read_unlock();
+
+	if (process->lead_thread != current->group_leader
+	    && !ptrace_attached) {
 		dev_dbg(kfd_device, "Using KFD FD in wrong process\n");
 		retcode = -EBADF;
 		goto err_i1;
@@ -1960,6 +2023,11 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		goto err_i1;
 	}
 
+	/* KFD_IOC_FLAG_ROOT_ONLY is only for CAP_SYS_ADMIN */
+	if (unlikely((ioctl->flags & KFD_IOC_FLAG_ROOT_ONLY) &&
+		     !capable(CAP_SYS_ADMIN)))
+		return -EACCES;
+
 	if (cmd & (IOC_IN | IOC_OUT)) {
 		if (asize <= sizeof(stack_kdata)) {
 			kdata = stack_kdata;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 64552f6b8ba4..768cc3fe95d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -121,7 +121,35 @@
  */
 #define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
 
+/**
+ * enum kfd_ioctl_flags - KFD ioctl flags
+ * Various flags that can be set in &amdkfd_ioctl_desc.flags to control how
+ * userspace can use a given ioctl.
+ */
+enum kfd_ioctl_flags {
+	/**
+	 * @KFD_IOC_FLAG_ROOT_ONLY:
+	 * Certain KFD ioctls such as AMDKFD_IOC_CRIU_RESTORER can potentially
+	 * perform privileged operations and load arbitrary data into MQDs and
+	 * eventually HQD registers when the queue is mapped by HWS. In order to
+	 * prevent this we should perform additional security checks. In other
+	 * cases, certain ioctls such as AMDKFD_IOC_CRIU_RESUME might be called
+	 * by an external process e.g. CRIU restore process, for each resuming
+	 * tasks and thus require elevated privileges.
+	 *
+	 * This is equivalent to callers with the SYSADMIN capability.
+	 */
+	KFD_IOC_FLAG_ROOT_ONLY = BIT(0),
+	/**
+	 * @KFD_IOC_FLAG_PTRACE_ATTACHED:
+	 * Certain KFD ioctls such as AMDKFD_IOC_CRIU_HELPER and
+	 * AMDKFD_IOC_CRIU_DUMPER are expected to be called during a Checkpoint
+	 * operation triggered by CRIU. Since, these are expected to be called
+	 * from a PTRACE attached context, we must authenticate these.
+	 */
+	KFD_IOC_FLAG_PTRACE_ATTACHED = BIT(1),
 
+};
 /*
  * Kernel module parameter to specify maximum number of supported queues per
  * device
@@ -977,6 +1005,47 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tba_addr,
 				  uint64_t tma_addr);
 
+/* CRIU */
+/*
+ * Need to increment KFD_CRIU_PRIV_VERSION each time a change is made to any of the CRIU private
+ * structures:
+ * kfd_criu_process_priv_data
+ * kfd_criu_device_priv_data
+ * kfd_criu_bo_priv_data
+ * kfd_criu_queue_priv_data
+ * kfd_criu_event_priv_data
+ * kfd_criu_svm_range_priv_data
+ */
+
+#define KFD_CRIU_PRIV_VERSION 1
+
+struct kfd_criu_process_priv_data {
+	uint32_t version;
+};
+
+struct kfd_criu_device_priv_data {
+	/* For future use */
+	uint64_t reserved;
+};
+
+struct kfd_criu_bo_priv_data {
+	uint64_t reserved;
+};
+
+struct kfd_criu_svm_range_priv_data {
+	uint64_t reserved;
+};
+
+struct kfd_criu_queue_priv_data {
+	uint64_t reserved;
+};
+
+struct kfd_criu_event_priv_data {
+	uint64_t reserved;
+};
+
+/* CRIU - End */
+
 /* Queue Context Management */
 int init_queue(struct queue **q, const struct queue_properties *properties);
 void uninit_queue(struct queue *q);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 3cb5b5dd9f77..19489e2ca58e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -467,6 +467,99 @@ struct kfd_ioctl_smi_events_args {
 	__u32 anon_fd;	/* from KFD */
 };
 
+struct kfd_criu_process_bucket {
+	__u64 priv_data_offset;
+	__u64 priv_data_size;
+};
+
+struct kfd_criu_device_bucket {
+	__u64 priv_data_offset;
+	__u64 priv_data_size;
+	__u32 user_gpu_id;
+	__u32 actual_gpu_id;
+	__u32 drm_fd;
+	__u32 pad;
+};
+
+struct kfd_criu_bo_bucket {
+	__u64 priv_data_offset;
+	__u64 priv_data_size;
+	__u64 addr;
+	__u64 size;
+	__u64 offset;
+	__u64 restored_offset;
+	__u32 gpu_id;
+	__u32 alloc_flags;
+	__u32 dmabuf_fd;
+	__u32 pad;
+};
+
+struct kfd_criu_queue_bucket {
+	__u64 priv_data_offset;
+	__u64 priv_data_size;
+	__u32 gpu_id;
+	__u32 pad;
+};
+
+struct kfd_criu_event_bucket {
+	__u64 priv_data_offset;
+	__u64 priv_data_size;
+	__u32 gpu_id;
+	__u32 pad;
+};
+
+struct kfd_ioctl_criu_process_info_args {
+	__u64 process_priv_data_size;
+	__u64 bos_priv_data_size;
+	__u64 devices_priv_data_size;
+	__u64 queues_priv_data_size;
+	__u64 events_priv_data_size;
+	__u64 svm_ranges_priv_data_size;
+	__u64 total_bos;
+	__u64 total_svm_ranges;
+	__u32 total_devices;
+	__u32 total_queues;
+	__u32 total_events;
+	__u32 task_pid;
+};
+
+struct kfd_ioctl_criu_pause_args {
+	__u32 pause;
+	__u32 pad;
+};
+
+enum kfd_criu_object_type {
+	KFD_CRIU_OBJECT_TYPE_PROCESS	= 0,
+	KFD_CRIU_OBJECT_TYPE_DEVICE	= 1,
+	KFD_CRIU_OBJECT_TYPE_BO		= 2,
+	KFD_CRIU_OBJECT_TYPE_QUEUE	= 3,
+	KFD_CRIU_OBJECT_TYPE_EVENT	= 4,
+	KFD_CRIU_OBJECT_TYPE_SVM_RANGE	= 5,
+};
+
+struct kfd_ioctl_criu_dumper_args {
+	__u64 num_objects;
+	__u64 objects;
+	__u64 objects_size;
+	__u64 objects_index_start;
+	__u32 type; /* enum kfd_criu_object_type */
+	__u32 pad;
+};
+
+struct kfd_ioctl_criu_restorer_args {
+	__u64 num_objects;
+	__u64 objects;
+	__u64 objects_size;
+	__u64 objects_index_start;
+	__u32 type; /* enum kfd_criu_object_type */
+	__u32 pad;
+};
+
+struct kfd_ioctl_criu_resume_args {
+	__u32 pid;	/* to KFD */
+	__u32 pad;
+};
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -740,7 +833,22 @@ struct kfd_ioctl_set_xnack_mode_args {
 #define AMDKFD_IOC_SET_XNACK_MODE		\
 		AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_args)
 
+#define AMDKFD_IOC_CRIU_DUMPER			\
+		AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_dumper_args)
+
+#define AMDKFD_IOC_CRIU_RESTORER		\
+		AMDKFD_IOWR(0x23, struct kfd_ioctl_criu_restorer_args)
+
+#define AMDKFD_IOC_CRIU_PROCESS_INFO		\
+		AMDKFD_IOWR(0x24, struct kfd_ioctl_criu_process_info_args)
+
+#define AMDKFD_IOC_CRIU_RESUME			\
+		AMDKFD_IOWR(0x25, struct kfd_ioctl_criu_resume_args)
+
+#define AMDKFD_IOC_CRIU_PAUSE			\
+		AMDKFD_IOWR(0x26, struct kfd_ioctl_criu_pause_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x22
+#define AMDKFD_COMMAND_END		0x27
 
 #endif
-- 
2.17.1

