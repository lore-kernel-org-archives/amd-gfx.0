Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF61C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 20:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A072A20719
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 20:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IwcYBN5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A072A20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7076E16B;
	Thu,  2 Apr 2020 20:46:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B867E6E16B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 20:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVZF1cOn2uI8O9HnC57SjVLKWqjGSnu6s8MwAGU3A/RC8MK2rr0UWD/dRj90Aw+TkOxwykUDnyKSdolVCVM+Wjy9vLR/RVifoetNf2Ahc1T8Dqh+GHfp2hcNM8qVUthkI4cbQvcFnnP6jORLGTllnjz9dojSo/u/X61UwmX7mO5jE4gOsK+WfLmn4xOUvhHWoUASXYH9HjC9nJ3HqZDA0E3e+rfW5rDjJ8UlkzVNhWPGiuFb1lwyDocZIMlCHMKscM97eC4oaMP6Bo43X/yqGvbE3KI6FVB/sAZdkEvLOt+ufFJOKJEQGacqFT/dGxZzoMCQpLpV7WxufGkFelvgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWr/qZxzOYoiTymLlIJPvdmtVWeFf1xcM/e/mVg7yo8=;
 b=hkWwzM16SU2fyU9RWBedOyZuGhB/dvOLuR/B1FSdMtuVLxfqwdDRqSzlKRPjZrMGDqjEw28WRKl1z1zt+H47O5yMt5Bf5ck1L78uHqZpScZ5cAFSE6rhlDlWoZ6f3Uy1/Tdd4QmBP/QzWMXupvCwZKlYrhhsDDMcBxTMA5zo9dcZYgvDf2MxqrpuAH7GJL1qe/GaknkgdfVXfDvpZmVERgjwDwVOOStRtrB59C3O8tCYmJ+0KERglq/Uhls6hI6Srg4BhWq4rXF4MFVZ5hXjKci5lGczPkgAMoWDpsF//h2VRcAnnKQmoet5WxnDcEtp0pJeWQtfcXwAKdHHeSByEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWr/qZxzOYoiTymLlIJPvdmtVWeFf1xcM/e/mVg7yo8=;
 b=IwcYBN5JB0axa6KvfRiXHS8Yy7zfc7ghJ+vbJTEJ3GfqHzxHDyvNpcc6mq898PkjQsLS3EFiREnmWluEwVRVmQiUETIrbtRwzz/SAS6seLwzreBBDfR08GoWlvii2hdSQUgIq/2rbVbNZP9B6xAUzPJG5L7gpXydLhINhlrhSsI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 by BN8PR12MB3603.namprd12.prod.outlook.com (2603:10b6:408:4a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 20:46:34 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::a421:2af7:645a:a051]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::a421:2af7:645a:a051%6]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 20:46:34 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Provide SMI events watch
Date: Thu,  2 Apr 2020 16:46:19 -0400
Message-Id: <1585860379-460-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::33) To BN8PR12MB3041.namprd12.prod.outlook.com
 (2603:10b6:408:46::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YTOPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 20:46:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd67efc4-6c90-4a18-26f6-08d7d746ee3b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:|BN8PR12MB3603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3603A8A523A72F52FFFDC9D8E1C60@BN8PR12MB3603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3041.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(86362001)(8936002)(2906002)(6486002)(66946007)(81166006)(81156014)(8676002)(4326008)(5660300002)(66476007)(7696005)(36756003)(2616005)(478600001)(66556008)(316002)(186003)(956004)(6916009)(26005)(16526019)(30864003)(52116002)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++XO0zh4y9w7CJ8BSqvEyYcZ/ff5YxgowrqTG1Rmp9AYoF9Ax11paVkuOR/XutihD6Mzcnfvfj/sLW2KqFb7FiEj9WVzmQIjA6KHMe+CYF1neZq3kiR1mLVjIApb6dATIsHHyiOBlJkXZuAeAl4NzoZ0ytWh5cJFLxAmbtN9gDVzBfNEUhf3nuE2bXcJiwWdPM5sMJhMKw4/1/Cx79IPU/wPl+BDJdRPQ9mYCqma+/vh1TNEwokTqBW8lpKvDYJAD3R1UNra15HnMiC2Xbc82K7l2bhvqF3L4ZZQXN1QKoNBXYM80wC6gqyPBYi2h2fVjO3rHkls6jsL8YYYCO3yqlp4xvJ0MfGxNGCVZgyroEuQGNvhpDOWhxVxBJQk8GNAfBby8KSWuZEy6LQJvdL1JdMOu9F9YI2SKJH5G7dm/1KxfKxVcxe1LBK8jFIua4Ur
X-MS-Exchange-AntiSpam-MessageData: IZobaek3q41QBU5QWNavK4lwoREtwIy870g8lYqNM1Ab/VeYR+bMcG/EylPtLBv3HdsNKTmTJoX5XpHU1stQzApw9eHxv809RuMFgZT/GkgYrp2TJ+gznrAUOy+/AWoZkIkPlOFNKl1UPXy99trPYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd67efc4-6c90-4a18-26f6-08d7d746ee3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 20:46:34.2000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd34n4tl05b7H+F6+nf9TRSZSIglDEbs65V0PWpaTO6TPNSz3GREqR+zYD5lth6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
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
space to register events they are interested. After the event is
registered, the user can use annoymous file descriptor's poll function
with wait-time specified to wait for the event to happen. Once the event
happens, the user can use read() to retrieve information related to the
event.

VM fault event is done in this patch.

v2: - remove UNREGISTER and add event ENABLE/DISABLE
    - correct kfifo usage
    - move event message API to kfd_ioctl.h

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile              |   3 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  30 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  12 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 177 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  31 ++++
 include/uapi/linux/kfd_ioctl.h                   |  30 +++-
 9 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 6147462..cc98b4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,7 +53,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_dbgdev.o \
 		$(AMDKFD_PATH)/kfd_dbgmgr.o \
-		$(AMDKFD_PATH)/kfd_crat.o
+		$(AMDKFD_PATH)/kfd_crat.o \
+		$(AMDKFD_PATH)/kfd_smi_events.o
 
 ifneq ($(CONFIG_AMD_IOMMU_V2),)
 AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
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
index f8fa03a..591ac28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 +39,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1243,6 +1244,32 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 	return ret;
 }
 
+/* Handle requests for watching SMI events */
+static int kfd_ioctl_smi_events(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_smi_events_args *args = data;
+	struct kfd_dev *dev;
+
+	dev = kfd_device_by_id(args->gpu_id);
+	if (!dev)
+		return -EINVAL;
+
+	switch (args->op) {
+	case KFD_SMI_EVENTS_REGISTER:
+		/* register the device */
+		return kfd_smi_event_register(dev, &args->data);
+	case KFD_SMI_EVENTS_ENABLE:
+		/* subscribe events to the device */
+		return kfd_smi_event_enable(dev, args->events);
+	case KFD_SMI_EVENTS_DISABLE:
+		/* unsubscribe events */
+		return kfd_smi_event_disable(dev, args->events);
+	}
+
+	return -EINVAL;
+}
+
 bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 {
 	struct kfd_local_mem_info mem_info;
@@ -1827,6 +1854,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
+			kfd_ioctl_smi_events, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0491ab2..6ac6f31 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -532,6 +532,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	kfd->device_info = device_info;
 	kfd->pdev = pdev;
 	kfd->init_complete = false;
+	kfd->smi_events.registered = false;
 	kfd->kfd2kgd = f2g;
 	atomic_set(&kfd->compute_profile, 0);
 
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
index 43b888b..b10b665 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -223,6 +223,15 @@ struct kfd_vmid_info {
 	uint32_t vmid_num_kfd;
 };
 
+struct kfd_smi_events {
+	/* device is registered to watch events */
+	bool registered;
+	/* events enabled */
+	uint32_t events;
+	DECLARE_KFIFO_PTR(fifo, uint32_t);
+	wait_queue_head_t wait_queue;
+};
+
 struct kfd_dev {
 	struct kgd_dev *kgd;
 
@@ -309,6 +318,9 @@ struct kfd_dev {
 
 	/* Global GWS resource shared b/t processes*/
 	void *gws;
+
+	/* if this device is in SMI events watch */
+	struct kfd_smi_events smi_events;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
new file mode 100644
index 0000000..aab4dac
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -0,0 +1,177 @@
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
+static DEFINE_MUTEX(kfd_smi_mutex);
+struct mutex *kfd_get_smi_mutex(void)
+{
+	return &kfd_smi_mutex;
+}
+
+static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
+static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
+static int kfd_smi_ev_release(struct inode *, struct file *);
+
+static uint32_t smi_fifo_len;
+static const char kfd_smi_name[] = "kfd_smi_ev";
+
+static const struct file_operations kfd_smi_ev_fops = {
+	.owner = THIS_MODULE,
+	.poll = kfd_smi_ev_poll,
+	.read = kfd_smi_ev_read,
+	.release = kfd_smi_ev_release
+};
+
+static __poll_t kfd_smi_ev_poll(struct file *filep,
+				struct poll_table_struct *wait)
+{
+	__poll_t mask;
+	struct kfd_dev *dev = filep->private_data;
+
+	poll_wait(filep, &dev->smi_events.wait_queue, wait);
+	mask = kfifo_is_empty(&dev->smi_events.fifo) ? 0: POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
+			       size_t size, loff_t *offset)
+{
+	int ret, copied = 0;
+	struct kfd_dev *dev = filep->private_data;
+
+	mutex_lock(kfd_get_smi_mutex());
+	ret = kfifo_to_user(&dev->smi_events.fifo, user, size, &copied);
+	mutex_unlock(kfd_get_smi_mutex());
+	if (ret || !copied) {
+		pr_debug("smi-events: fail to send msg (%i) (%i)\n",
+			ret, copied);
+		return ret ? ret : -EAGAIN;
+	}
+
+	return copied;
+}
+
+static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
+{
+	struct kfd_dev *dev = filep->private_data;
+
+	dev->smi_events.events = 0;
+	kfifo_free(&dev->smi_events.fifo);
+
+	return 0;
+}
+
+void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
+	struct amdgpu_task_info task_info;
+	struct kfd_smi_msg_vmfault msg;
+	uint32_t *fifo_in = (uint32_t *)&msg;
+	uint32_t fifo_in_len = sizeof(msg) / sizeof(uint32_t);
+
+	if (!(dev->smi_events.events & KFD_SMI_EVENT_VMFAULT))
+		return;
+
+	amdgpu_vm_get_task_info(adev, pasid, &task_info);
+	msg.pid = task_info.pid;
+	strncpy(msg.task_name, task_info.task_name, 16);
+
+	mutex_lock(kfd_get_smi_mutex());
+	if ((fifo_in_len + 1) >
+			(smi_fifo_len - kfifo_len(&dev->smi_events.fifo))) {
+		pr_err("smi_event: no space left for vmfault event\n");
+		mutex_unlock(kfd_get_smi_mutex());
+		return;
+	}
+	/* Always send the event type first to function as a header */
+	kfifo_put(&dev->smi_events.fifo, KFD_SMI_EVENT_VMFAULT);
+	/* Then the msg as the payload. Event type reveals the payload size. */
+	kfifo_in(&dev->smi_events.fifo, fifo_in, fifo_in_len);
+	mutex_unlock(kfd_get_smi_mutex());
+
+	wake_up_all(&dev->smi_events.wait_queue);
+}
+
+int kfd_smi_event_disable(struct kfd_dev *dev, uint64_t events)
+{
+	mutex_lock(kfd_get_smi_mutex());
+	dev->smi_events.events &= ~events;
+	mutex_unlock(kfd_get_smi_mutex());
+
+	return 0;
+}
+
+int kfd_smi_event_enable(struct kfd_dev *dev, uint64_t events)
+{
+	/* If the user didn't register SMI events for this device, kfifo is not
+	 * created to report events.
+	 */
+	if (!dev->smi_events.registered)
+		return -EINVAL;
+
+	mutex_lock(kfd_get_smi_mutex());
+	dev->smi_events.events |= events;
+	mutex_unlock(kfd_get_smi_mutex());
+
+	return 0;
+}
+
+static void assign_fifo_len(void)
+{
+	/* When a new event is added into support and this new event msg uses
+	 * more memory, replace the msg struct here.
+	 */
+	uint32_t max_msg = sizeof(struct kfd_smi_msg_vmfault)/sizeof(uint32_t);
+	/* +1 for the event type in front of event message. up to 32 entries */
+	smi_fifo_len = (++max_msg) * 32;
+}
+
+int kfd_smi_event_register(struct kfd_dev *dev, int *fd)
+{
+	int ret = 0;
+
+	if (!smi_fifo_len)
+		assign_fifo_len();
+
+	ret = kfifo_alloc(&dev->smi_events.fifo, smi_fifo_len, GFP_KERNEL);
+	if (ret) {
+		pr_err("smi_event: fail to allocate kfifo\n");
+		return ret;
+	}
+	init_waitqueue_head(&dev->smi_events.wait_queue);
+	dev->smi_events.events = 0;
+	dev->smi_events.registered = true;
+
+	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops,
+				(void *)dev, 0);
+	*fd = ret;
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
new file mode 100644
index 0000000..e10bb5d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -0,0 +1,31 @@
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
+int kfd_smi_event_register(struct kfd_dev *dev, int *fd);
+int kfd_smi_event_enable(struct kfd_dev *dev, uint64_t events);
+int kfd_smi_event_disable(struct kfd_dev *dev, uint64_t events);
+void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
+
+#endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..dc9309e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 +442,31 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
+/*
+ * KFD SMI(System Management Interface) events
+ */
+enum kfd_smi_events_op {
+	KFD_SMI_EVENTS_REGISTER = 1,
+	KFD_SMI_EVENTS_ENABLE,
+	KFD_SMI_EVENTS_DISABLE
+};
+
+/* Event type (defined by bitmask) */
+#define KFD_SMI_EVENT_VMFAULT     0x00000001
+
+struct kfd_ioctl_smi_events_args {
+	__u32 op;       /* to KFD */
+	__u32 events;   /* to KFD */
+	__u32 gpu_id;   /* to KFD */
+	__u32 data;    /* from KFD */
+};
+
+/* Message to user space for each event */
+struct kfd_smi_msg_vmfault {
+	uint32_t pid;
+	char task_name[16];
+};
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 +571,10 @@ enum kfd_mmio_remap {
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
