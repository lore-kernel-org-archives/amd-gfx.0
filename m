Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E85CC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEC561163
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DEC561163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C417C6E0C4;
	Tue, 24 Aug 2021 19:22:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA4B6E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T85C0f1q2ET/qlGhetNpcPDNWLe0LTfdLSZu7sdHtEvpwPqde5wrtIOQkaS/gdZc7hfr6xmX/KKl0kxc/6MaBy4fjZFLmsDpzQrUOr7ph7DeAINlPguc0Ey2XzeV49qjIU9+/vJKr+CU0q9W1sd0wutWwP3roDSmffEjeN4g+JNUfR8QP5bss/NS7et0Rl0cFWeZ64MF+B+4p0V2o88F5qDTo/j2ThKjYvbOICMDc2Pg/u1qiSiFrgTkJu6w939pBaIRjNPjPBkS/Gg4FCGQCVuHXJpPin4e/Gpa2mksTZdv1zjAcWStei8aTixSZ1Ut+Xv5zUjTp32mY3B19zwo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP47CcXidYShpmnGqVoOSd94XYlT+tBsm6YxEgCUloE=;
 b=F0W2iD6BblT2D88G/SjCL6VRfFiReI20avQJhpPjQowcaruUUVXw+Ik9rNUoB5okwxpnkSAgGajs7zyfAXzlJlRraVefigQzXGu8jYStYdOqiBo/e1l7D9OXY+PZBTbau1EXe6eCGqJUP0vBaM+WHdemkXIQ5cygmB0TKFP6PMEntEoblsbI3/GfamY1ufomF0LhqTFQJScr0b30gNHw4GF/G9nLU2l3Cmnnb+jeKHi6wTwMtK9RpYLPs8GNlYx1B7/vBmUkDsx9xU40tNY/bkKi+rwDizf52y4IlUYXQ71Bd2xzNki1DHLcN8WqdCKDKxagLZ+K8xkFi5r7AMHGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP47CcXidYShpmnGqVoOSd94XYlT+tBsm6YxEgCUloE=;
 b=E2leWvPoeJaa4nh6fewJ8amG589ZQr03wUgkfg328aBVbXDFTjlpEoUD3swK/zbGQWZAh6rGDPEOwOvaNWzkmFQRgGFMktDsXPLHqCZoXEMUoT0ONtu3KZ2pQZlnnCNfPDEtI0gZWwzmYvIHJm5hy6yQKrzZmLOCjKpVJO4wRjE=
Received: from DM6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:5:bc::40) by
 MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 19:07:34 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::52) by DM6PR13CA0027.outlook.office365.com
 (2603:10b6:5:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:34 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:31 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 03/18] drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs
Date: Tue, 24 Aug 2021 15:06:24 -0400
Message-ID: <20210824190639.6288-4-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3077ce96-2627-48de-2448-08d967326e08
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4552C6B3E37599E8F88B507C95C59@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lklA7G+HfTz9/xebwidL6XZ9FFm6+uO810o0BzxHJICaPqHsV6QBBhNGjzyuKtsCw1UoCPOwde1dmFHaXmAbPV25ArETmNEvmb1Z6X4jH8x6sjpx/w5+PN9ZK4mddmfeJFzUaI05eltu58ba/4dPbJ0UwBnKYssC116L8fSpZwhLazk6LDSf9q7AfrS0aSXEjIZmiMipUzicSIHQrBmZk9qVibus4YbRr7vu8lhnfNea2F4Q2BJ6WrlIWcyl3tBqBNzaiY2gztvioTJrT7kIorPD05h7HXb3MAJgtsqeeMw/fBYMpW/ITe8BLxzm3pCrC+uo6oRio1T+G0r02rRjbhVfSnW3LctiEVfN/e9lilq+3c0wQSAV18G6LeQ4hTYiDNETwlTerelV1d2KB/rxPdV0cs+0ngbecbj69zYZ7UkHYEHmJbzzglpiZlRGmfAD/Gg7+HPGWOUlqFkyKdQoAow7PhlwgtyhE3ihl4GVkyyGkBOHgjpkIcBueJjO9pIF7UyJC8pWGY+DZKN58GeMpwQiG/PqzatxzbmpdtPSgYt9J3Un4csWpdWUlOyAZPf1BHnSwzmrFl8oThakwR1kO+RiAN8+McWGuy6ro+JDkj10IFs7cGn/F2FZrMmwROOIFB6NEItNoYbdYlcFmL50+oefIM3AVWA8/m+DYSxQObJQKhAoacTiKHzdtU2fXMu7Ua/rf8O5J6RFKENRa5fpZRcyCm6MDgpU75EyWq0yBs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(7696005)(8936002)(1076003)(4326008)(316002)(36860700001)(2616005)(8676002)(2906002)(30864003)(5660300002)(70586007)(70206006)(81166007)(82310400003)(478600001)(47076005)(82740400003)(6916009)(86362001)(356005)(83380400001)(26005)(54906003)(6666004)(336012)(16526019)(186003)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:34.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3077ce96-2627-48de-2448-08d967326e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  70 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  69 +++++++
 include/uapi/linux/kfd_ioctl.h           | 221 ++++++++++++++++++++++-
 3 files changed, 358 insertions(+), 2 deletions(-)

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
index 3cb5b5dd9f77..206cad72329f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -467,6 +467,210 @@ struct kfd_ioctl_smi_events_args {
 	__u32 anon_fd;	/* from KFD */
 };
 
+/**************************************************************************************************
+ * CRIU IOCTLs (Checkpoint Restore In Userspace)
+ *
+ * When checkpointing a process, the userspace application will perform:
+ * 1. CRIU_PAUSE (pause = 1) ioctl to make sure all queues are evicted
+ * 2. CRIU_PROCESS_INFO ioctl to determine current process information
+ * 3. CRIU_DUMPER ioctl for each type of objects
+ * 4. CRIU_PAUSE (pause = 0) ioctl to un-evict all the queues
+ *
+ * When restoring a process, the CRIU userspace application will perform:
+ * 1. CRIU_RESTORE ioctl for each type of objects
+ * 2. CRIU_RESUME ioctl to start the process
+ *
+ * Objects can be of type:
+ * * PROCESS: Contains process specific information
+ * * DEVICE: Contains per-GPU information for each GPU used by the process
+ * * BO: Buffer Object, BO metadata and memory contents
+ * * QUEUE: Queues information for all queues used by current process (e.g CP and SDMA)
+ * * EVENT: Events information (e.g interrupts or HW exceptions)
+ * * SVM_RANGE: HMM memory mappings information
+ *
+ * Before performing a CRIU_DUMPER ioctl for each type of object, the caller needs to allocate
+ * sufficient memory for:
+ * * size of bucket structure * Number of objects
+ *    The public structures for each type of object.
+ * * private data
+ *    The opaque private structures for each type of object.
+ *
+ * These values are obtained from the CRIU_PROCESS_INFO ioctl.
+ */
+
+/**
+ * kfd_ioctl_criu_process_info_args - Arguments to get process information
+ *
+ * @process_priv_data_size:       [out] Total size of private data for object type PROCESS
+ * @bos_priv_data_size:           [out] Total size of private data for object type BO
+ * @devices_priv_data_size:       [out] Total size of private data for object type DEVICE
+ * @queues_priv_data_size:        [out] Total size of private data for object type QUEUE
+ * @events_priv_data_size:        [out] Total size of private data for object type EVENTS
+ * @svm_ranges_priv_data_size:    [out] Total size of private data for object type SVM_RANGE (HMM)
+ * @total_bos:                    [out] Number of BOs used by the process
+ * @total_svm_ranges:             [out] Number of SVM_RANGEs used by the process (HMM)
+ * @total_devices:                [out] Number of GPUs used by the process
+ * @total_queues:                 [out] Number of queues used by the process
+ * @total_events:                 [out] Number of events used by the process
+ * @task_pid:                     [out] PID of the process being checkpointed
+ *
+ * Context: Expects process to be in paused state, see CRIU_PAUSE. Takes and releases process lock
+ *
+ * Return: 0 on success, -errno on failure
+ */
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
+	__u64 restored_offset;    /* During restore, updated offset for BO */
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
+enum kfd_criu_object_type {
+	KFD_CRIU_OBJECT_TYPE_PROCESS	= 0,
+	KFD_CRIU_OBJECT_TYPE_DEVICE	= 1,
+	KFD_CRIU_OBJECT_TYPE_BO		= 2,
+	KFD_CRIU_OBJECT_TYPE_QUEUE	= 3,
+	KFD_CRIU_OBJECT_TYPE_EVENT	= 4,
+	KFD_CRIU_OBJECT_TYPE_SVM_RANGE	= 5,
+};
+
+
+/**
+ * kfd_ioctl_criu_dumper_args - Arguments for dumping objects
+ *
+ * @num_objects:         [in] Number of objects to be dumped
+ * @objects:             [out] User pointer to memory location to store object information
+ * @objects_size:        [in/out] Size of memory allocated in @objects
+ * @objects_index_start: [in] When doing partial dumps, this is the index of the first object to
+ *                            be dumped. [Not currently supported]
+ * @type:		 [in] Type of object to be dumped
+ *
+ * Before performing dump ioctl, user application needs to allocate at least:
+ * (num_objects * sizeof(kfd_criu_[type]_bucket)) + [type]_priv_data_size
+ *
+ * When ioctl returns, kernel drivers will fill @objects pointer with information that needs to be
+ * stored.
+ *
+ * Context: Expects process to be in paused state, see CRIU_PAUSE. Takes and releases process lock.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+struct kfd_ioctl_criu_dumper_args {
+	__u64 num_objects;
+	__u64 objects;
+	__u64 objects_size;
+	__u64 objects_index_start;
+	__u32 type; /* enum kfd_criu_object_type */
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_criu_restorer_args - Arguments for restoring objects
+ *
+ * @num_objects:           [in] Number of objects to be restored
+ * @objects:               [in/out] User pointer to memory location to store object information.
+ * @objects_size:          [in] Size of memory allocated in @objects
+ * @objects_index_start:   [in] When doing partial restores, this is the index of the first object
+ *                              to be dumped. [Not currently supported]
+ * @type:                  [in] Type of object to be restored
+ *
+ * Before performing restore ioctl, user application needs to fill @objects pointer with data
+ * returned during dump ioctl.
+ *
+ * Context: Takes and releases process lock.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+struct kfd_ioctl_criu_restorer_args {
+	__u64 num_objects;
+	__u64 objects;
+	__u64 objects_size;
+	__u64 objects_index_start;
+	__u32 type; /* enum kfd_criu_object_type */
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_criu_pause_args - Pause process
+ * @pause:              [in] Set to non-zero to pause all queues currently used by this process
+ *
+ *
+ * Process needs to be paused before process is dumped and un-paused once all objects have been
+ * dumped.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+struct kfd_ioctl_criu_pause_args {
+	__u32 pause;
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_criu_resume_args - Resume process
+ * @pid:                [in] Process ID of the task to be resumed
+ *
+ * Used during stage-4 of CRIU restore. This ioctl is called once all memory mappings, queues and
+ * events have been fully restored and the process is ready to run.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+struct kfd_ioctl_criu_resume_args {
+	__u32 pid;
+	__u32 pad;
+};
+
+/* CRIU IOCTLs - END */
+/**************************************************************************************************/
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -740,7 +944,22 @@ struct kfd_ioctl_set_xnack_mode_args {
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

