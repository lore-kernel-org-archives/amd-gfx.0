Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A1C1975A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 17:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5919B20738
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HT9EZzwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5919B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213F16E248;
	Tue, 17 Mar 2020 17:57:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DC96E248
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 17:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYMEbRaURtkYYBYbXwJXyVb/+CNibRk+os8U6OE6S9OnggWXBIr9Ye48HyG98xLxJuIPZCjSSp6Lu0YK3X36kNN8GTnW2zU9ICC5bgXRzwSyWmDYlraMdAzjp6WxjN3OKlx6Iqccj8cu/XJ0Rxzz549HwtFlpqXaRr5sc0IEuZ5leo8Q49tg4shxJ2rThnxZIuOLGFOKw8/rgUGahzzq4bjGBHCfdhVHNm+NG/HDNq0DM3UQTTew3TsqkEji2TmnJveQxEyrOKAWdN8vjkmANW6pvilNazoOnEzRncq2IRt0mBbaki66REbX7KaP3+wRqbjHegtcwfUWJ1kLpcl1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/QMu0aQsDktK5P5SNnm1bCERulP3wZbmfbbBcCwISQ=;
 b=aymp8AHi0FCotYfR9sWsdM0DrFaDMCYplaP3d4ovN7GLdBfUr1aJg4Y845P/nvEuri3uo2GwPM3GQMiUKOlDtfIx+lq0zO0dix1Ha82ooqWzPjZgrPE5VzSmiJGb1A3kWr5R4tjpY/6JP/ySHICRfS2/TRgn0xKEJEM4zjTE96z81+ATYCnoLXLfULi9wRsh6UZ2qxm29ZIlRj5it1CnrUxhzWVmyN4es0SEYQiYJoxzEw7j1cMAMbgtItS26PKXeOuld5B9I+1va9Nz3hmUmS9MoGAs9uiPAx0J9Zy+b/1ep6Rh3Uc69uPsb55u8wnduRUyjugXx5ak1fGEBFVE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/QMu0aQsDktK5P5SNnm1bCERulP3wZbmfbbBcCwISQ=;
 b=HT9EZzwBQktF1rjrAhOjpssEYm2EE+6F58th/KHoPe+jrwXBsXXNXr8DDiSHop1v6v3ebkd1cmvAlW6axNIRQTPZNqjfuoBAj0YS6kSrT2U6mFx/E+ULyZYj+f5aFFXbSOMS/Nz7pRxq1hRzDydBGPzvCz6+guUdKxw3ohmRj8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Tue, 17 Mar
 2020 17:57:16 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::a421:2af7:645a:a051]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::a421:2af7:645a:a051%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 17:57:16 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Provide SMI events watch
Date: Tue, 17 Mar 2020 13:57:03 -0400
Message-Id: <1584467823-31170-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To BN8PR12MB3041.namprd12.prod.outlook.com
 (2603:10b6:408:46::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.18 via Frontend
 Transport; Tue, 17 Mar 2020 17:57:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5db225ac-77f5-4c6f-67fe-08d7ca9ca0d5
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:|BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073D7A95F453F2C9DDD3118E1F60@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(7696005)(52116002)(316002)(6666004)(5660300002)(2906002)(30864003)(478600001)(16526019)(186003)(956004)(26005)(86362001)(2616005)(6916009)(36756003)(81156014)(66946007)(81166006)(8676002)(66476007)(6486002)(4326008)(66556008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3073;
 H:BN8PR12MB3041.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSP+JnQAKdZ1uaErYrB9Hmo/TKRtA2Kx7go8TFjHffXQEvYPpVAdsHNRmVrR2UgLC6JBBeQmqUNWfEKoDI9/Q2Eu0Ul3ogfX5mg1zFMp/Xp4c4SWrV5SC0sKA/rSXdNENJCFpNxZnbJM1uwu4UdDrICaY3jd6QoWkCynHEaVGZoK39L1ttUaKkGYqdpae1w9XJikBbNxkH6ogDsFT7JfVyJzPAP2Rg7ObSFXEC9iDCpf1NxhB3lznp6Tr6P0IQPGZEkAynNJEBaz9LXxSljroig+MMC6YAaL4zlFJ1DSUrZEbTRj0pbf8aaCi6Pn8hpj0GI4bX+BASieFCXY3omD6u21jP8VGwJ9jOPLYj5RUUV+2QXI5DLbC/z+S7nIgfDhE5jrsGZsASp5G1f+kmQE4q4TVtrKkq/7ZTV44lnKa/vTppb4YqQk2eHWXPobimmo
X-MS-Exchange-AntiSpam-MessageData: D750z0i1ApLczMTS4w24bbqZ5hXUkMYxCBmyZ6031qDtBXoULc98mCLxNPASOx3QjCUwUuH358Zemf29XR6cU6/Vy5vyeNuxTH6nXe01EqyMn8baHGcSEmiEZskJglBBlToxVzvc6DgZ5PzVWKyGuQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db225ac-77f5-4c6f-67fe-08d7ca9ca0d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 17:57:16.0222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddRRS2rVMlqEBDmyavscpKxZBMYq/CE80G1FfZPsRegRhD3XxI3MC+jqASEmHKOZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
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
registered, the user can use annoymous file descriptor's pull function
with wait-time specified to wait for the event to happen. Once the event
happens, the user can use read() to retrieve information related to the
event.

VM fault event is done in this patch.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile              |   3 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  38 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  10 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 143 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  41 +++++++
 include/uapi/linux/kfd_ioctl.h                   |  27 ++++-
 9 files changed, 265 insertions(+), 2 deletions(-)
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
index f8fa03a..8e92956 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 +39,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1243,6 +1244,40 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 	return ret;
 }
 
+/* Handle requests for watching SMI events */
+static int kfd_ioctl_smi_events(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_smi_events_args *args = data;
+	struct kfd_dev *dev;
+	int ret = 0;
+
+	dev = kfd_device_by_id(args->gpu_id);
+	if (!dev)
+		return -EINVAL;
+
+	switch (args->op) {
+	case KFD_SMI_EVENTS_REGISTER:
+		ret = kfd_smi_event_register(dev, args->events);
+		if (ret >= 0) {
+			/* When the registration is successful, it returns the
+			 * annoymous inode. Pass it to the user in data1
+			 */
+			args->data1 = ret;
+			ret = 0;
+		}
+		break;
+	case KFD_SMI_EVENTS_UNREGISTER:
+		kfd_smi_event_unregister(dev, args->events);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 {
 	struct kfd_local_mem_info mem_info;
@@ -1827,6 +1862,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
+			kfd_ioctl_smi_events, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7866cd06..450368c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -532,6 +532,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	kfd->device_info = device_info;
 	kfd->pdev = pdev;
 	kfd->init_complete = false;
+	kfd->smi_events.events = 0;
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
index 43b888b..fdb51de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -223,6 +223,13 @@ struct kfd_vmid_info {
 	uint32_t vmid_num_kfd;
 };
 
+struct kfd_smi_events {
+	uint64_t events;
+	struct kfifo fifo;
+	wait_queue_head_t wait_queue;
+	uint32_t max_events;
+};
+
 struct kfd_dev {
 	struct kgd_dev *kgd;
 
@@ -309,6 +316,9 @@ struct kfd_dev {
 
 	/* Global GWS resource shared b/t processes*/
 	void *gws;
+
+	/* if this device is in SMI events watch */
+	struct kfd_smi_events smi_events;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
new file mode 100644
index 0000000..ba9d036
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -0,0 +1,143 @@
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
+
+struct mutex *kfd_get_smi_mutex(void)
+{
+	return &kfd_smi_mutex;
+}
+
+static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
+static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
+static int kfd_smi_ev_release(struct inode *, struct file *);
+
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
+	struct kfd_dev *dev = filep->private_data;
+	struct kfd_smi_events *ev = &dev->smi_events;
+
+	__poll_t mask = 0;
+
+	poll_wait(filep, &ev->wait_queue, wait);
+	mask |= !kfifo_is_empty(&ev->fifo) ? POLLIN | POLLRDNORM : mask;
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
+	ret = kfifo_to_user(&dev->smi_events.fifo, user, size, &copied);
+	if (ret || !copied) {
+		pr_debug("kfd smi-events: Fail to read fd (%i) (%i)\n",
+				ret, copied);
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
+	kfifo_free(&dev->smi_events.fifo);
+	return 0;
+}
+
+void kfd_smi_event_update_vmfault(struct kfd_dev *kdev, uint16_t pasid)
+{
+	struct kfd_smi_vmfault_fifo fifo_out;
+	struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
+	struct amdgpu_task_info task_info;
+
+	if (!kdev->smi_events.events)
+		return;
+
+	if (!(kdev->smi_events.events & KFD_SMI_EV_VMFAULT))
+		return;
+
+	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+	amdgpu_vm_get_task_info(adev, pasid, &task_info);
+
+	fifo_out.group = 0;
+	fifo_out.event = KFD_SMI_EV_VMFAULT;
+	fifo_out.gpu_id = kdev->id;
+	fifo_out.pid = task_info.pid;
+	strcpy(fifo_out.task_name, task_info.task_name);
+	kfifo_in(&kdev->smi_events.fifo, &fifo_out, sizeof(fifo_out));
+	wake_up_all(&kdev->smi_events.wait_queue);
+}
+
+void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events)
+{
+	mutex_lock(kfd_get_smi_mutex());
+	dev->smi_events.events &= ~events;
+	mutex_unlock(kfd_get_smi_mutex());
+}
+
+int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events)
+{
+	int ret;
+
+	mutex_lock(kfd_get_smi_mutex());
+	dev->smi_events.events |= events;
+	mutex_unlock(kfd_get_smi_mutex());
+
+	/* We use the lower 32 bits for now. Each bit represents one event. If
+	 * featured events are increased to more than 32, we'll use the upper
+	 * bits as groups so the total number of events can be up to 32*32.
+	 */
+	dev->smi_events.max_events = 32;
+	ret = kfifo_alloc(&dev->smi_events.fifo, dev->smi_events.max_events,
+			 GFP_KERNEL);
+	if (ret) {
+		pr_err("fail to allocate kfifo\n");
+		return ret;
+	}
+	init_waitqueue_head(&dev->smi_events.wait_queue);
+
+	return anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops,
+				(void *)dev, 0);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
new file mode 100644
index 0000000..2e320d3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -0,0 +1,41 @@
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
+int kfd_smi_event_register(struct kfd_dev *dev, uint64_t events);
+void kfd_smi_event_unregister(struct kfd_dev *dev, uint64_t events);
+void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
+
+/* All FIFO must start with "uint32_t group" and "uint32_t event" so the user
+ * can read the first 8 bytes to determine the next read length.
+ */
+struct kfd_smi_vmfault_fifo {
+	uint32_t group;
+	uint32_t event;
+	unsigned int gpu_id;
+	pid_t pid;
+	char task_name[TASK_COMM_LEN];
+};
+
+#endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..6ce7c69 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 +442,28 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
+/*
+ * KFD SMI(System Management Interface) events
+ */
+enum kfd_smi_events_op {
+	KFD_SMI_EVENTS_REGISTER = 1,
+	KFD_SMI_EVENTS_UNREGISTER
+};
+
+/* Event ID (mask) */
+#define KFD_SMI_EV_VMFAULT     0x00000001
+
+struct kfd_ioctl_smi_events_args {
+	__u32 op;       /* to KFD */
+	/* upper 32 bits: group. lower 32 bits: event IDs */
+	__u64 events;   /* to KFD */
+	__u32 gpu_id;   /* to KFD */
+	pid_t pid;      /* to KFD */
+	__u32 data1;    /* from KFD */
+	__u32 data2;
+	__u32 data3;
+};
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 +568,10 @@ enum kfd_mmio_remap {
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
