Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3511FC2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 21:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCDE20644
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qo7oKAUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCDE20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D176E591;
	Tue, 14 Apr 2020 21:30:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43276E591
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 21:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QebHDO/qqjUc/me9lDFlJK/jDEOgYK+gFnwGD1mkct1n6ndWMBAguI+nBytMvj6euhQ4Ub0oeeu1gk7RAUsHpWdHNDER0WxYiCbo8JUfW1QTTiijQ+QU/02//mH4OIB9d8vXxgOHDoy09xInCfJLN58Gfo0MiGcadByQgJIqtMtzMWoCee1kqkPawKMwODzhrcB/x90AQQeP5YPAy4Knv85zfQEbdmR/ulNRq2ph1L/kBouPjaH4f+9DMI8qgwksEvDq/X4CX2ASjnumAGxCwvU8um6aIBXkpMoL0nXySuq2Pbr/2mNPbPRkSYwGxaOZI2Qx9ughrjMF6eauysRL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1egUMlECx90g/WAeUbwho9iW1C/X0XdjhzZzbu2TpwU=;
 b=E19cVYM6zMFrsX1uhIDJ6utS0WQJ2LZeXIVUAt/S2+IQHfioQO9JmPDMoakVhOi/77uQHGW1gVL1o4fLD+iTgjUEyIJnCrqb4cUfXRkzv58jomIIIXMYsh093Z3Kqc9bOu2el8EbMPJU5LdeT4Wv5LhXfDGNhh5JbtPLYWI0QO5QvAZ0SWFoLgdRb3alSyTfrfXZUDdRjLW6RpjmFlu1NqJd53Znw82qt5Xprr1IvOE4ltwFYB0j9b7EKD9tJhv/ZcGaBhQYvakiEu4ejoAMF+RCJGMjVGgK/XRGVRTuQljuSDttBILRT1VzmRnwRqmJ/9AQG5fsoNK0NXGnjp2zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1egUMlECx90g/WAeUbwho9iW1C/X0XdjhzZzbu2TpwU=;
 b=Qo7oKAUSIM/4iWme3jzNjH47+VFX6hlnnDgZcxqMRNCIAsrwWoG8DAhhllTnXOIGwY2Fuvoao7fTIuMuLaOtgfdYaCNlI9BtEWu9DXiTx2jAx5YE4VTRyEyOmh0Anlfd4xqEjbspUsNZqg4uiv3ODv+IKcSKhjKFB02EHWOiQl0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 by BN8PR12MB3298.namprd12.prod.outlook.com (2603:10b6:408:69::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 21:30:52 +0000
Received: from BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::f92c:63b4:3640:a4c]) by BN8PR12MB3041.namprd12.prod.outlook.com
 ([fe80::f92c:63b4:3640:a4c%6]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 21:30:52 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4] drm/amdkfd: Provide SMI events watch
Date: Tue, 14 Apr 2020 17:30:42 -0400
Message-Id: <1586899842-28131-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To BN8PR12MB3041.namprd12.prod.outlook.com
 (2603:10b6:408:46::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 21:30:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90814cf5-a6ab-4cdd-1001-08d7e0bb1b52
X-MS-TrafficTypeDiagnostic: BN8PR12MB3298:|BN8PR12MB3298:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB32987367824DA5EAADA08DE2E1DA0@BN8PR12MB3298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3041.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39850400004)(8676002)(6486002)(81156014)(5660300002)(6666004)(2616005)(956004)(2906002)(4326008)(86362001)(30864003)(52116002)(36756003)(316002)(7696005)(16526019)(66556008)(478600001)(8936002)(66946007)(66476007)(6916009)(26005)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xr7Y1Y+WWPD65tUyFTEvj93sPFpkg++hntSHIMuT/c27IiKRBH7UVj7962596be6QJJkIjlPbUWEDIb42Rbt7moz5Pc+ypXmVaOXP2KeK645eC1CFFcULGzMkGOqaVeybWMNq0caw13g9P9CGatxXV5uuFlBaqrLaxPsr0JINTYFyAQuW8dhaTLoI1P85tWIT9ymJzbDcJuo2/WPa/KvvfJFLrghQVr8hJS7jaj9IF8xntUfBzbftqaMo5cbjALYxM1k9sHak55X7RxlBWJgFHC8rXz8h1G6S6IATVCZlhrSgbuK8yPauoSnWRCIJOI47BM8dxEC79I5yuuPkIqJu/geItEMGtf7t/AtDQwnVuVDW0QnAcXj8xmna5528SKwwzCMnbgeAjBc2Se3ZRNeajkvS+K83rLt8LmGyUbCw9wZsn308TQzWHMCTMmzB34R
X-MS-Exchange-AntiSpam-MessageData: XcyX9Nhb6kcmKwIFPSwuVOutDAOvFTg9CeuBR/EwMkq3ugnwXIj4G1acVJVp0LEEaYHewGrlLrab7TxDeKssv2SIR1zLku9VNcSDA2y/P+HkogAPWAvQfVdQZQgh51X0pA/I3zyKZR1u0zlw0GENTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90814cf5-a6ab-4cdd-1001-08d7e0bb1b52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 21:30:52.0032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Kgy5B7VC9AI43nst1KqOoarP/2xT4bvoqt3Mi+LRTat9pauhx63i8rZLkSWPjWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3298
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

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile              |   1 +
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  43 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_module.c          |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 235 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  33 ++++
 include/uapi/linux/kfd_ioctl.h                   |  35 +++-
 9 files changed, 354 insertions(+), 1 deletion(-)
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
index f8fa03a..f13fde59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 +39,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1732,6 +1733,45 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return r;
 }
 
+/* Handle requests for watching SMI events */
+static int kfd_ioctl_smi_events(struct file *filep,
+				struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_smi_events_args *args = data;
+	uint32_t *ids_array;
+	int ret = 0;
+
+	switch (args->op) {
+	case KFD_SMI_EVENTS_REGISTER:
+		ids_array = kmalloc_array(args->num_gpuids, sizeof(uint32_t),
+					  GFP_KERNEL);
+		if (!ids_array)
+			return -ENOMEM;
+		if (copy_from_user(ids_array,
+				  (void __user *)args->gpuids_array_ptr,
+				  args->num_gpuids * sizeof(uint32_t))) {
+			kfree(ids_array);
+			return -EFAULT;
+		}
+
+		ret = kfd_smi_event_register(args->num_gpuids, ids_array,
+					     &args->anon_fd, &args->client_id);
+		if (ret)
+			kfree(ids_array);
+
+		return ret;
+
+	case KFD_SMI_EVENTS_ENABLE:
+		/* subscribe events */
+		return kfd_smi_event_enable(args->client_id, args->events);
+	case KFD_SMI_EVENTS_DISABLE:
+		/* unsubscribe events */
+		return kfd_smi_event_disable(args->client_id, args->events);
+	}
+
+	return -EINVAL;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -1827,6 +1867,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
+			kfd_ioctl_smi_events, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index f4b7f7e..1aa96a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -62,6 +62,7 @@ static int kfd_init(void)
 	kfd_procfs_init();
 
 	kfd_debugfs_init();
+	kfd_smi_event_init();
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b..3cdff5d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1087,4 +1087,7 @@ static inline void kfd_debugfs_fini(void) {}
 
 #endif
 
+/* SMI events */
+void kfd_smi_event_init(void);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
new file mode 100644
index 0000000..3e94f94
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -0,0 +1,235 @@
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
+	uint32_t id;
+	struct list_head list;
+	struct kfifo fifo;
+	wait_queue_head_t wait_queue;
+	/* events enabled */
+	uint64_t enabled;
+	/* devices in watching */
+	uint32_t num_devs;
+	uint32_t *dev_ids;
+};
+static LIST_HEAD(clients);
+static spinlock_t clients_lock;
+static uint32_t client_id;
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
+	ret = kfifo_to_user(&client->fifo, user, size, &copied);
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
+	struct kfd_smi_client *client = filep->private_data;
+
+	spin_lock(&clients_lock);
+	list_del_rcu(&client->list);
+	spin_unlock(&clients_lock);
+
+	synchronize_rcu();
+	kfifo_free(&client->fifo);
+	kfree(client->dev_ids);
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
+	/* 16 bytes event + 1 byte space + 8 bytes gpuid + 1 byte space +
+	 * 25 bytes msg + 1 byte \n = 52
+	 */
+	char fifo_in[52];
+	struct kfd_smi_client *client;
+	int i;
+
+	if (list_empty(&clients))
+		return;
+
+	amdgpu_vm_get_task_info(adev, pasid, &task_info);
+	snprintf(fifo_in, 52, "%x %x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
+		dev->id, task_info.pid,task_info.task_name);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(client, &clients, list) {
+		if (!(client->enabled & KFD_SMI_EVENT_VMFAULT))
+			continue;
+		for (i = 0; i < client->num_devs; i++) {
+			if (client->dev_ids[i] != dev->id)
+				continue;
+			if (kfifo_avail(&client->fifo) < 52) {
+				pr_err("smi_event(vmfault): no space left\n");
+				rcu_read_unlock();
+				return;
+			}
+			kfifo_in(&client->fifo, fifo_in, sizeof(fifo_in));
+			wake_up_all(&client->wait_queue);
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+static struct kfd_smi_client *get_client_by_id(uint32_t id)
+{
+	struct kfd_smi_client *client;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(client, &clients, list) {
+		if (client->id == id) {
+			rcu_read_unlock();
+			return client;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+static int kfd_smi_event_update_events(uint32_t id, uint64_t events,
+				       bool is_enable)
+{
+	struct kfd_smi_client *client = get_client_by_id(id);
+
+	if (!client)
+		return -EINVAL;
+
+	if (is_enable)
+		client->enabled |= events;
+	else
+		client->enabled &= ~events;
+
+	return 0;
+}
+
+int kfd_smi_event_enable(uint32_t id, uint64_t events)
+{
+	return kfd_smi_event_update_events(id, events, true);
+}
+
+int kfd_smi_event_disable(uint32_t id, uint64_t events)
+{
+	return kfd_smi_event_update_events(id, events, false);
+}
+
+int kfd_smi_event_register(uint32_t num_devs, uint32_t *dev_ids, uint32_t *fd,
+			   uint32_t *id)
+{
+	struct kfd_smi_client *client;
+	int ret;
+
+	client = kzalloc(sizeof(struct kfd_smi_client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&client->list);
+
+	ret = kfifo_alloc(&client->fifo, KFD_SMI_MAX_EVENT_MSG * 16,
+			 GFP_KERNEL);
+	if (ret) {
+		kfree(client);
+		return ret;
+	}
+
+	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
+			       0);
+	if (ret < 0) {
+		kfifo_free(&client->fifo);
+		kfree(client);
+		*fd = 0;
+		return ret;
+	}
+	*fd = ret;
+
+	init_waitqueue_head(&client->wait_queue);
+	client->enabled = 0;
+	client->num_devs = num_devs;
+	client->dev_ids = dev_ids;
+	/* client id is used to identify the client in enable/disable_events */
+	*id = client->id = ++client_id;
+
+	spin_lock(&clients_lock);
+	list_add_rcu(&client->list, &clients);
+	spin_unlock(&clients_lock);
+
+	return 0;
+}
+
+void kfd_smi_event_init(void)
+{
+	INIT_LIST_HEAD(&clients);
+	spin_lock_init(&clients_lock);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
new file mode 100644
index 0000000..a4f9e92
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -0,0 +1,33 @@
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
+void kfd_smi_event_init(void);
+int kfd_smi_event_register(uint32_t num_devs, uint32_t *dev_ids, uint32_t *fd,
+			   uint32_t *id);
+int kfd_smi_event_enable(uint32_t id, uint64_t events);
+int kfd_smi_event_disable(uint32_t id, uint64_t events);
+void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
+
+#endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..8146437 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 +442,36 @@ struct kfd_ioctl_import_dmabuf_args {
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
+#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
+
+struct kfd_ioctl_smi_events_args {
+	__u32 op;		/* to KFD */
+	__u64 events;		/* to KFD */
+	__u64 gpuids_array_ptr;	/* to KFD */
+	__u32 num_gpuids;	/* to KFD */
+	__u32 anon_fd;		/* from KFD */
+	__u32 client_id;	/* to/from KFD */
+};
+
+/* 1. All messages must start with (hex)uint64_event(16) + space(1) +
+ *    (hex)gpuid(8) + space(1) =  26 bytes
+ * 2. VmFault msg = (hex)uint32_pid(8) + space(1) + task name(16) = 25
+ *    When a new event msg uses more memory, change the calculation here.
+ * 3. End with \n(1)
+ * 26 + 25 + 1 = 52
+ */
+#define KFD_SMI_MAX_EVENT_MSG 52
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 +576,10 @@ enum kfd_mmio_remap {
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
