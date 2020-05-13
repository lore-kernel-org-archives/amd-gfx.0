Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9688C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 19:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D87520659
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 19:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r9QmFeUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D87520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04216EA3C;
	Wed, 13 May 2020 19:41:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412DD6EA3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 19:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neTSdUkrn4YYBvyiDLDesYNzUKfVhIle/tUFcAO/v4GqySeOPF4v3g04UHO1EQmWGTWTuKBIaCzh6RfYkV33gXJwBOIJd/V8m0bClb9jQok6XlcwbYmrZNituOKo45/8TVLuR/RdEEPLb/lgJIi4ICjUNxzKtsfVJfkfIDAXqoEuTdTcEsEGkblsnVAHmQm+PQlB6/rCF22hvX/nFU5ogdJbE1CzWkbjG+V1fXGGiya1Z3BM6/ieLiWaLsQzihAZuj3EzAMeEKLbA+anOR+ycLZOMqg6aBlfCAbM/t4CI/KpzUdvVLMiOQiXTgIH05HwN8AFykKb/ovI7cGrI9DguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdsqRB1pk9Z/mQZ/cLV1UhvJHfJF7bOgnl587G0UKoQ=;
 b=Z49ZRtmc5pl4vclvqWychwthPM5L5tvbkdKzTNRJvBieQh4phvMgB+3MWBdJucizhnbO5JQsq3a4+0Ps6l9y1OMJk3XyR4spHIEpSnYRCeUc4gw43qsT4apNgpbIA1/i+x2/XsH+HyjBnB3UVs+8MOnpQKiTWqTVuSXbbSmFma1bWdXciNIXGsnz4w0nqhuTbW/18iaHIZykhpq4T6P7qGrExBesUviU8rfA66pheff6N8odFlKtoJ+yAUHLqdH3ZREiLqMsQUnjeFbj9DOesBx51B3pnaKPXNv+KsI0TOUMKPy/hM8IWCZ01bgzbC+Mrn+k6EKXtdMFynBRtpL33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdsqRB1pk9Z/mQZ/cLV1UhvJHfJF7bOgnl587G0UKoQ=;
 b=r9QmFeUpqVg0iLGsGM63M/VU90qLzBMmp3Il9fdSNzD+XTrhtNA6CgXhv97Wq7dlxb4rdpQX9lSwxIGIgFikD5bPbhTQzXGUK8Dx7FLlOOppXYO1sGViAJsLhy+YAEjQcoolVNf5LqOK5zdDmg5mvQV9ZS5kziJuDFFUL18Pjsk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB2732.namprd12.prod.outlook.com (2603:10b6:5:4a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20; Wed, 13 May 2020 19:41:28 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d91c:2026:e88c:812d]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d91c:2026:e88c:812d%6]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 19:41:28 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Provide SMI events watch
Date: Wed, 13 May 2020 15:41:17 -0400
Message-Id: <1589398877-28344-1-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.20 via Frontend
 Transport; Wed, 13 May 2020 19:41:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed7864d7-fe77-49c8-f2b8-08d7f775a0b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2732:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2732DA239A5F7072C73DB943E1BF0@DM6PR12MB2732.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZg1NBxsTH0GV+GDAnn9F2QFwZA0eRFeZDPJG5nJ6gTuwofE3mFMbkUv9Xwox0XU91YUv2SV6SGxH+uYRGnfDm5g6rWQO8ccqA7/bq96fRaqyLcjf1GjIyDpWiHifjzpTYqxsGZ7XHeJPCyKCLGQ4aslFLSDRq9oT0+HEQdEbuwrrwsRrv5UK5rgl1x2GnJClnJcM1tXQtAuTRadmOvA+Ckg1RRekPGPHO0i0l66yu+yyMDbSjVLYzaEiRxzHvwEbTPkY/2VceYXrJYAk2SZ3pCoZyvhZhRWj/tZLzem0XcEkag8XQECLirqGNeZBvRLs2xYG3rTPUTHp7Q8rqdncY3Q8CQ+eYJwoyndBHII8qqW2jkA68YBcWb5uMkgTey0TjGqgIFFDQHgkFuPu/mP3JbyiX4c2ZWT5zYd7WV6GWrk6suNdiqvx3p7xpjc+OMPUa7yKtgM643DSoZBw9+EQ8CQwCnZtMZ9IaF0qt7OfeSYT1vl+GqI2RQ/JxfJC6tonQM1udENu2RDeQTJowkM9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(33430700001)(16526019)(26005)(2616005)(4326008)(36756003)(5660300002)(316002)(478600001)(8676002)(66556008)(6916009)(30864003)(6486002)(956004)(66946007)(66476007)(6666004)(2906002)(86362001)(186003)(7696005)(33440700001)(8936002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EQ9/+MjtQWe6L0cuOeOIPoq4glGfaRg0IYkaHjLti3yXzfjJl5kSSWOKWZFwq2IFGLnQc1eaxYmbrKdpDKE/kCjlFGrVIEBxNOcOGMH0pgctoGjAzVyXPdEw0sV+7QziwMMP6P5QYv633ewHSk9L22Q81EnzLdhUkc5+sHS0CtENsVnVfvCzbIxiYzZs3ywY4PXHI+xV6fV+3QZXsUw95U26Nj1HxwUItyQSHa5eYoD1/d09CL4F9pX5b0ummCjAsexTJr/UvTr7P9r3TowkKAesXJGnjmQ9Fb8Hz+Y0U5c5ZGpqtD9HZKAKTN0k6WbPdN197fkU/JJjwLZ4KsPsPNAkj5HY7wqiK0xCQFEonlNXJ/2Tm+lNw+H3eVdauaWY/QMht1brfu2SQmW0+oPyqmC8PXD/Jb5XFvt0qLUDkyhEdtEd5LlPmfhn5D7RkLj5hPnt/15SfuBJ4sF0PkPBOD2SuaErbCPVrzzrn4HcOoYNS9b3buznEyU7c2xm4g7/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7864d7-fe77-49c8-f2b8-08d7f775a0b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 19:41:28.0790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yahpjc1WlrTqdsRIq5GGDEPpPrEDBRNHj6XULa35dXi0HCZUmL6e1avcTQ7vhnI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         |  18 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c      | 214 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h      |  29 +++
 include/uapi/linux/kfd_ioctl.h                   |  16 +-
 9 files changed, 292 insertions(+), 1 deletion(-)
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
index cf0017f..e9b96ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,6 +39,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_dbgmgr.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1740,6 +1741,20 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
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
@@ -1835,6 +1850,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
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
index cde5e4c..f70f789 100644
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
index 0000000..f5fd18e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -0,0 +1,214 @@
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
+	spinlock_t lock;
+};
+
+#define MAX_KFIFO_SIZE	1024
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
+	spin_lock(&client->lock);
+	mask = kfifo_is_empty(&client->fifo) ? 0 : POLLIN | POLLRDNORM;
+	spin_unlock(&client->lock);
+
+	return mask;
+}
+
+static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
+			       size_t size, loff_t *offset)
+{
+	int ret;
+	size_t to_copy;
+	struct kfd_smi_client *client = filep->private_data;
+	unsigned char buf[MAX_KFIFO_SIZE];
+
+	BUILD_BUG_ON(MAX_KFIFO_SIZE > 1024);
+
+	/* kfifo_to_user can sleep so we can't use spinlock protection around
+	 * it. Instead, we kfifo out as spinlocked then copy them to the user.
+	 */
+	spin_lock(&client->lock);
+	to_copy = kfifo_len(&client->fifo);
+	if (!to_copy) {
+		spin_unlock(&client->lock);
+		return -EAGAIN;
+	}
+	to_copy = min3(size, sizeof(buf), to_copy);
+	ret = kfifo_out(&client->fifo, buf, to_copy);
+	spin_unlock(&client->lock);
+	if (ret <= 0)
+		return -EAGAIN;
+
+	ret = copy_to_user(user, buf, to_copy);
+	if (ret)
+		return -EFAULT;
+
+	return to_copy;
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
+	WRITE_ONCE(client->events, events);
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
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+	amdgpu_vm_get_task_info(adev, pasid, &task_info);
+	/* Report VM faults from user applications, not retry from kernel */
+	if (!task_info.pid)
+		return;
+
+	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
+		task_info.pid, task_info.task_name);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
+		if (!(READ_ONCE(client->events) & KFD_SMI_EVENT_VMFAULT))
+			continue;
+		spin_lock(&client->lock);
+		if (kfifo_avail(&client->fifo) >= len) {
+			kfifo_in(&client->fifo, fifo_in, len);
+			wake_up_all(&client->wait_queue);
+		}
+		else
+			pr_debug("smi_event(vmfault): no space left\n");
+		spin_unlock(&client->lock);
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
+	ret = kfifo_alloc(&client->fifo, MAX_KFIFO_SIZE, GFP_KERNEL);
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
+		return ret;
+	}
+	*fd = ret;
+
+	init_waitqueue_head(&client->wait_queue);
+	spin_lock_init(&client->lock);
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
index b6be623..733c183 100644
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
