Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F68C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 02:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FB22072D
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 02:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ocKkMLbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FB22072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EBB6E216;
	Thu, 16 Apr 2020 02:01:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C656E216
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 02:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM2vFSwjiROWMU+tQZZSTZHQNqSWalRS5G7Y0C3EDU9sBILY9vttIYctTQUZUSI58YQs49MpveTyfCD7RKsyvvNnGQbCFqA3DsGboik3WzrH02MC+gMyaCAuZkbRU2H1t4F9iWuBH6F73S6UkHFhY81Trgoe5R05NSVXjtpYr3H8QTKBc/WbtDMQa2XLqj5LHN9458SXON/IscpV9kmUTZ4u3YjfVGKIUmm7W9/pu9rznibfkss1ZBRiJx43oEuWEHFj7RuDqLjhNPd/w2X57KzpE2hucjPMdtyObUJmJ77Wd0gxxD1SnBMNyyNE8HRkyZPJClfrhCOppPvGb2k2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NufTmXjIHXOko9Lgp7rKMyfs8paMvcH4H3/xnmmLpig=;
 b=DzfDMI0EKOJyPII2JUM/KB+hEL/shIIc5OViDBp9mkU34n8yNFB7C3Ie9GM2BoNQE20hI8GytygjJpDl6nsGZWlbelloaQs0vEXV5rIC8uVwMF6BY2i4NFPKRnMkQQWCTeoOxzfxrxpJgDjn0ijoR9JooQlkuKVbrKdgG1dI+Zw28YGVpj0svmaIn6oug5FgwxRcD6Em0E1K51ldCSdyD3JtR2EZcUj2OyDxfekW1tpRpqQWcXvluvilAN6BlGAW/RCm9D2f3kcUz36ZeRwoKZfnmo/w6CYga7CZ9cwU8Svd453ujcRRD0Y96POFqs/JqW2YSXnHqxGv0akmIJzDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NufTmXjIHXOko9Lgp7rKMyfs8paMvcH4H3/xnmmLpig=;
 b=ocKkMLbW+0NlzAZrMRiesQGMk/YvO3XrxDNLcXy2JAFvrgibnxYLK7Z8vObKfmQrc5JQgA/zNvEsSDotaZHuKONS5PxgsYA4+Tm5LaAhY7qP01OdXtLm/2zYJkaiM25CF3gktvYntENyDkyEMhoYX9qTFcCBDgvvmc7gNvJzCz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 by BN8PR12MB3121.namprd12.prod.outlook.com (2603:10b6:408:40::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 02:01:43 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::8c10:ae51:b8a7:4b97]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::8c10:ae51:b8a7:4b97%7]) with mapi id 15.20.2921.024; Thu, 16 Apr 2020
 02:01:43 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5] drm/amdkfd: Provide SMI events watch
Date: Wed, 15 Apr 2020 22:01:26 -0400
Message-Id: <1587002486-15559-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To BN8PR12MB3041.namprd12.prod.outlook.com
 (2603:10b6:408:46::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 02:01:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b3f823f-4f9e-40dc-3698-08d7e1aa1c3e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3121:|BN8PR12MB3121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB312119638BDA51E9729099B0E1D80@BN8PR12MB3121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3041.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(186003)(6486002)(4326008)(5660300002)(86362001)(6666004)(66476007)(26005)(6916009)(36756003)(66556008)(8676002)(8936002)(478600001)(30864003)(81156014)(956004)(7696005)(316002)(52116002)(2616005)(66946007)(16526019)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QztM0nQdu45SB5cWYMP2zvb7RFZP5kJcwIhAO6yhHUWr7VGtkvdo7klF8hltai6pMko7LKhxwRncZ7CThKpxQGCmOIUnYrTXtWIGA6avG/Z37LkG5eFjyUUMfuCdPyHRAKWpeJBLYZ0/7NqSSw3aEescYifH7gSBWsK7Hfq8ZjdDh0/8asPXpqut/C4d17qUpr4XFKHYnsGUPPMomkHBI6qTfboVQQlG/yEydqjrJ15oyMBYTCgMLirG1eW/5sRaMDU+XHaeNXKu1GmGmlVTbicfGWZ7o71WeBu1kPp4vubtEPaKzEAO/uT7TEbRczd0HnG7uxkhpynl+6II5YfnPheM16enWj6fTjT/cB1Oz1npGhICBFd2rIbYg7qvnRGDcxvH08+5Vcl4hYu27+ES+9gXfJc0LxhM99yVbSi/OGh4CLSPk5yhOon5Nt6K4uBI
X-MS-Exchange-AntiSpam-MessageData: Hxb56i28cO1V0h82FQy9gV5eDxq+40EexdcLuDlfUJR+Yx64IG3DTwtXUX5AZtfVO9Nk5O5FsLf4K7fu3Npapc4njl8XjIw3L0umrQtheISGroY+g5nAnRlVxHRQXX6bO3ikgphjT+KRKJQMLvpWJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3f823f-4f9e-40dc-3698-08d7e1aa1c3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 02:01:43.3891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eVkBS4tsm7XBj1E+mZkFAmK/oNsjK3ehuohB58hx342BF4anm2NS0NW+v9Oj8iH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3121
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
Cc: Amber Lin <Amber.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the compute is malfunctioning or performance drops, the system admin
will use SMI (System Management Interface) tool to monitor/diagnostic what
went wrong. This patch provides an event watch interface for the user
space to register devices and subscribe events they are interested. After
registered, the user can use annoymous file descriptor's poll function
with wait-time specified and wait for events to happen. Once an event
happens, the user can use read() to retrieve information related to the
event.

VM fault event is done in this patch.

v2: - remove UNREGISTER and add event ENABLE/DISABLE
    - correct kfifo usage
    - move event message API to kfd_ioctl.h
v3: send the event msg in text than in binary
v4: support multiple clients
v5: move events enablement from ioctl to fd write

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile              |   1 +
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  18 +++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 191 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  29 ++++
 include/uapi/linux/kfd_ioctl.h                   |  16 +-
 9 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 6147462..e1e4115 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,6 +53,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_dbgdev.o \
 		$(AMDKFD_PATH)/kfd_dbgmgr.o \
+		$(AMDKFD_PATH)/kfd_smi_events.o \
 		$(AMDKFD_PATH)/kfd_crat.o
 
 ifneq ($(CONFIG_AMD_IOMMU_V2),)
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 9f59ba9..24b4717 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -24,6 +24,7 @@
 #include "kfd_events.h"
 #include "cik_int.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -107,6 +108,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
 		struct kfd_vm_fault_info info;
 
+		kfd_smi_event_update_vmfault(dev, pasid);
 		kfd_process_vm_fault(dev->dqm, pasid);
 
 		memset(&info, 0, sizeof(info));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a..2baaaec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 +39,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1732,6 +1733,20 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return r;
 }
 
+/* Handle requests for watching SMI events */
+static int kfd_ioctl_smi_events(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_smi_events_args *args = data;
+	struct kfd_dev *dev;
+
+	dev = kfd_device_by_id(args->gpuid);
+	if (!dev)
+		return -EINVAL;
+
+	return kfd_smi_event_open(dev, &args->anon_fd);
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -1827,6 +1842,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
+			kfd_ioctl_smi_events, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0491ab2..2c030c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -586,6 +586,11 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 	return ret;
 }
 
+static void kfd_smi_init(struct kfd_dev *dev) {
+	INIT_LIST_HEAD(&dev->smi_clients);
+	spin_lock_init(&dev->smi_lock);
+}
+
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
@@ -700,6 +705,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto kfd_topology_add_device_error;
 	}
 
+	kfd_smi_init(kfd);
+
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->pdev->vendor,
 		 kfd->pdev->device);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e05d75e..151e83e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -24,6 +24,7 @@
 #include "kfd_events.h"
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
+#include "kfd_smi_events.h"
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -117,6 +118,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_read  = ring_id & 0x10;
 		info.prot_write = ring_id & 0x20;
 
+		kfd_smi_event_update_vmfault(dev, pasid);
 		kfd_process_vm_fault(dev->dqm, pasid);
 		kfd_signal_vm_fault_event(dev, pasid, &info);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b..dc873b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -309,6 +309,10 @@ struct kfd_dev {
 
 	/* Global GWS resource shared b/t processes*/
 	void *gws;
+
+	/* Clients watching SMI events */
+	struct list_head smi_clients;
+	spinlock_t smi_lock;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
new file mode 100644
index 0000000..39818e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <linux/anon_inodes.h>
+#include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu_vm.h"
+#include "kfd_priv.h"
+#include "kfd_smi_events.h"
+
+struct kfd_smi_client {
+	struct list_head list;
+	struct kfifo fifo;
+	wait_queue_head_t wait_queue;
+	/* events enabled */
+	uint64_t events;
+	struct kfd_dev *dev;
+};
+
+static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
+static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
+static ssize_t kfd_smi_ev_write(struct file *, const char __user *, size_t,
+				loff_t *);
+static int kfd_smi_ev_release(struct inode *, struct file *);
+
+static const char kfd_smi_name[] = "kfd_smi_ev";
+
+static const struct file_operations kfd_smi_ev_fops = {
+	.owner = THIS_MODULE,
+	.poll = kfd_smi_ev_poll,
+	.read = kfd_smi_ev_read,
+	.write = kfd_smi_ev_write,
+	.release = kfd_smi_ev_release
+};
+
+static __poll_t kfd_smi_ev_poll(struct file *filep,
+				struct poll_table_struct *wait)
+{
+	__poll_t mask;
+	struct kfd_smi_client *client = filep->private_data;
+
+	poll_wait(filep, &client->wait_queue, wait);
+
+	rcu_read_lock();
+	mask = kfifo_is_empty(&client->fifo) ? 0: POLLIN | POLLRDNORM;
+	rcu_read_unlock();
+
+	return mask;
+}
+
+static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
+			       size_t size, loff_t *offset)
+{
+	int ret, copied = 0;
+	struct kfd_smi_client *client = filep->private_data;
+
+	rcu_read_lock();
+	ret = kfifo_to_user(&client->fifo, user, size, &copied);
+	rcu_read_unlock();
+
+	if (ret || !copied) {
+		pr_debug("smi-events: fail to send msg (%i) (%i)\n",
+			ret, copied);
+		return ret ? ret : -EAGAIN;
+	}
+
+	return copied;
+}
+
+static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
+				size_t size, loff_t *offset)
+{
+	struct kfd_smi_client *client = filep->private_data;
+	uint64_t events;
+
+	if (!access_ok(user, size) || size < sizeof(events))
+		return -EFAULT;
+	if (copy_from_user(&events, user, sizeof(events)))
+		return -EFAULT;
+
+	client->events = events;
+
+	return sizeof(events);
+}
+
+static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
+{
+	struct kfd_smi_client *client = filep->private_data;
+	struct kfd_dev *dev = client->dev;
+
+	spin_lock(&dev->smi_lock);
+	list_del_rcu(&client->list);
+	spin_unlock(&dev->smi_lock);
+
+	synchronize_rcu();
+	kfifo_free(&client->fifo);
+	kfree(client);
+
+	return 0;
+}
+
+void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
+	struct amdgpu_task_info task_info;
+	/* VmFault msg = (hex)uint32_pid(8) + :(1) + task name(16) = 25 */
+	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
+	 */
+	char fifo_in[43];
+	struct kfd_smi_client *client;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	amdgpu_vm_get_task_info(adev, pasid, &task_info);
+	snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
+		task_info.pid, task_info.task_name);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
+		if (!(client->events & KFD_SMI_EVENT_VMFAULT))
+			continue;
+		if (kfifo_avail(&client->fifo) < 43) {
+			pr_err("smi_event(vmfault): no space left\n");
+			rcu_read_unlock();
+			return;
+		}
+		kfifo_in(&client->fifo, fifo_in, sizeof(fifo_in));
+		wake_up_all(&client->wait_queue);
+	}
+
+	rcu_read_unlock();
+}
+
+int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
+{
+	struct kfd_smi_client *client;
+	int ret;
+
+	client = kzalloc(sizeof(struct kfd_smi_client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&client->list);
+
+	ret = kfifo_alloc(&client->fifo, 1024, GFP_KERNEL);
+	if (ret) {
+		kfree(client);
+		return ret;
+	}
+
+	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
+			       O_RDWR);
+	if (ret < 0) {
+		kfifo_free(&client->fifo);
+		kfree(client);
+		*fd = 0;
+		return ret;
+	}
+	*fd = ret;
+
+	init_waitqueue_head(&client->wait_queue);
+	client->events = 0;
+	client->dev = dev;
+
+	spin_lock(&dev->smi_lock);
+	list_add_rcu(&client->list, &dev->smi_clients);
+	spin_unlock(&dev->smi_lock);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
new file mode 100644
index 0000000..a9cb218
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef KFD_SMI_EVENTS_H_INCLUDED
+#define KFD_SMI_EVENTS_H_INCLUDED
+
+int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
+void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
+
+#endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..ad33c18 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 +442,17 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
+/*
+ * KFD SMI(System Management Interface) events
+ */
+/* Event type (defined by bitmask) */
+#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
+
+struct kfd_ioctl_smi_events_args {
+	__u32 gpuid;	/* to KFD */
+	__u32 anon_fd;	/* from KFD */
+};
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 +557,10 @@ enum kfd_mmio_remap {
 #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
 		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
 
+#define AMDKFD_IOC_SMI_EVENTS			\
+		AMDKFD_IOWR(0x1F, struct kfd_ioctl_smi_events_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x1F
+#define AMDKFD_COMMAND_END		0x20
 
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
