Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3917C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 16:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8896120781
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XqYtiGYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8896120781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3CB6E829;
	Wed, 22 Jul 2020 16:09:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1DE6E452
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 16:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwAXYgu+1Dk3i3AFXJ/bwAtPDGx2zhcLFHnhKQG0mBs4NzvSqxLfbRJVFt+rmAukyTTzk/dOr7nxJW3YgpHIZ4SrQKEE305YJP/JrVBitYwUF8qry1fNnPwMStKzgECoA+dbi86y05HFhSUEwiO5KgVT1cZ9cFIiMaAPpwTLiV19vWwb3GQUCn1QnWZoTgEnViGN0r0Vo8gNhn7IEC+05s5Z6wc1DUO3EqIW0WIEXU8E6hFI17+CAZUGqoo9/Ziz1ZIOQu0FUo3XQO+yEoYlPUf6BNWqTEC65FD7JdI8uGijdpicM6qlqAuX92eVUEgk0ZzZkkxmaYmgsA1sq/NWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzqszYTT+6fa5Mbr9b2xhw/33as9hD2eoAiAcuzThq4=;
 b=UCAwYLMKHZRDjRTRONSTxZyaUMDVkBarUqsYftgD3cmuN+VOlL7jiekOVVGC7qRUQSj2K6cqM5ii/tdc1ywusYYRqfp5yCisUXZL4AQfD7WfgcrXCa7cYm4509esrGKRHBpkG2Au4mI3UH3Rr/iQ+lbJLEWrWG1DBgPpCq0rK54V9/O2mxlbejGJgqhN7Wko5q25obpog9HyPchQJMZVozaTzsqG7aG3S8tHr80Kr379BXXMd2jizfAAz5eCzVVZJz7eNQQuH3qwnJQEdbh6m+MRzDk24yN1PbxXZiHTC79XHp7+HzGLN1t9tZzCO4+i8n4FnMsY2Xo1w5Ix8ip7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzqszYTT+6fa5Mbr9b2xhw/33as9hD2eoAiAcuzThq4=;
 b=XqYtiGYqlJNTHsPe26krdgV0srBlbPqNYnYrH7cvFD/kR5flR95RANhmcJeIp4aosDGkedYemhAxXSyEQArG8osI2D9lOgtSjonNcsm3niX4r0pVgJ4q3vvpzDe7b6s5gmY2fAfC0zLRWMPxBWl+yA8w3PqMj9JCeldp9Ql9RZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 by MN2PR12MB3806.namprd12.prod.outlook.com (2603:10b6:208:169::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 16:09:04 +0000
Received: from MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::b0b8:3c8c:a65d:4d63]) by MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::b0b8:3c8c:a65d:4d63%3]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 16:09:04 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Add thermal throttling SMI event
Date: Wed, 22 Jul 2020 12:08:51 -0400
Message-Id: <20200722160851.22437-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To MN2PR12MB4272.namprd12.prod.outlook.com
 (2603:10b6:208:1de::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 16:09:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1188abb0-3b55-4702-3621-08d82e598e08
X-MS-TrafficTypeDiagnostic: MN2PR12MB3806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3806F85B300BFE0AA0F14F3BEE790@MN2PR12MB3806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbNpgFuZ4n3eknMhHLgsbUWzwlW3Bdm+hoO8vJjvkf5gSAbQk/Ay9wjoM+MTzD+iVFszztMUCiDwHR/iOEj56cGy0rUcanu08IsA92YVuxn6ZOj8vprLYQaERd/1q9wfgbkM3KuLUS6KYXxui2xcZh84nsRMY+NTC7QLbyGk+zZjokqmSQBwJD7o8AXiBgZoAZ3RkNqdJW2Mudk2sZ+Xz5rT3/bAJOcWx5jtkMm2k/YjM+qcTUxf8biK59uZ+y/deC6keLWC11KzoCsW20PLd81eiV8QeNPn0/DIZTY6ZnXAS2VjOAibiHCclHBzSfI1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4272.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(83380400001)(4326008)(8676002)(36756003)(7696005)(52116002)(1076003)(5660300002)(8936002)(478600001)(316002)(86362001)(6916009)(6666004)(2906002)(6486002)(66476007)(66556008)(16526019)(956004)(2616005)(44832011)(186003)(26005)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DupWMLM6jz3330TngXF/VcXYAmzhDLlh8Fvn32kjuUwcbPRL5ZbW/4+1PlqfZHBTbsFy7od6ZLqRT1itX0gJ6XhKQC7/S57AdjTfVg+Z5A21v4p6NHrI0OgacLAgjoPyPfWL5IoRf4YvrI/ovLS6i+319sxY/iRgXjSUS9uTW2ZNJcrB0/kT2G1n/f92fGeQVuu+TzGo0x6c+DgG441bdA4plUeo9mO9JnZhXhz1IlxrCcDPmAe9Xdz1rb7E68SFPpdRLvaVmyRGMClxnWILPJFaIArk6mUeROLVo8ks4BC35Psr/CXorFYvHAorMPSWqL9iMbI0EZlg+JgHyX3WeqOXV5GU9SLLSvyTo7jc7AX1+vgu2pZA+YXAqLYCR/DKS0KHmHNEiOh3tQMGV2gJ9+lBfjAdQ4f4rFRR1QZL7viPl4FzQfuVVpcmB5nRi0DTidXJn7O7EQiAF2LZPulGwGu2s44hgxtBveRU/AwNOAC3sqrdERPvf9H56sOdrWsR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1188abb0-3b55-4702-3621-08d82e598e08
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 16:09:04.3830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHs5wvRxBZpFgzUXG/PF3XSXUIY2Z1//Q05JwRvXgUB0SDgeDZ+xTEoJnPDQdD5nCcZ6d25NeRe2vxe80TNSOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3806
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for reporting thermal throttling events through SMI.
Also, add a counter to count the number of throttling interrupts
observed and report the count in the SMI event message.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 68 ++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  2 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 ++
 include/uapi/linux/kfd_ioctl.h                |  3 +-
 10 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1b865fed74ca..19e4658756d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -755,4 +755,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
 {
 }
+
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+{
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3f2b695cf19e..e8b0258aae24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -269,5 +269,6 @@ int kgd2kfd_resume_mm(struct mm_struct *mm);
 int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 					       struct dma_fence *fence);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
 
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4bfedaab183f..d5e790f046b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -29,6 +29,7 @@
 #include "cwsr_trap_handler.h"
 #include "kfd_iommu.h"
 #include "amdgpu_amdkfd.h"
+#include "kfd_smi_events.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -1245,6 +1246,12 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
 	WARN_ONCE(count < 0, "Compute profile ref. count error");
 }
 
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+{
+	if (kfd)
+		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 7b348bf9df21..00c90b47155b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/anon_inodes.h>
 #include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "kfd_priv.h"
 #include "kfd_smi_events.h"
@@ -148,6 +149,55 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static void add_event_to_kfifo(struct kfd_dev *dev, unsigned long long smi_event,
+			      char *event_msg, int len)
+{
+	struct kfd_smi_client *client;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
+		if (!(READ_ONCE(client->events) & smi_event))
+			continue;
+		spin_lock(&client->lock);
+		if (kfifo_avail(&client->fifo) >= len) {
+			kfifo_in(&client->fifo, event_msg, len);
+			wake_up_all(&client->wait_queue);
+		} else {
+			pr_debug("smi_event(EventID: %llu): no space left\n",
+					smi_event);
+		}
+		spin_unlock(&client->lock);
+	}
+
+	rcu_read_unlock();
+}
+
+void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
+					     uint32_t throttle_bitmask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
+	/*
+	 * ThermalThrottle msg = gpu_id(4):throttle_bitmask(4):
+	 * 			 thermal_interrupt_count(8):
+	 * 16 bytes event + 1 byte space + 4 bytes gpu_id + 1 byte : +
+	 * 4 byte throttle_bitmask + 1 byte : +
+	 * 8 byte thermal_interupt_counter + 1 byte \n = 36
+	 */
+	char fifo_in[36];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, 36, "%x %x:%x:%llx\n",
+		       KFD_SMI_EVENT_THERMAL_THROTTLE,
+		       dev->id, throttle_bitmask,
+		       atomic64_read(&adev->smu.throttle_int_counter));
+
+	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
+}
+
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
@@ -156,7 +206,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
 	 */
 	char fifo_in[43];
-	struct kfd_smi_client *client;
 	int len;
 
 	if (list_empty(&dev->smi_clients))
@@ -171,22 +220,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
 		task_info.pid, task_info.task_name);
 
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
-		if (!(READ_ONCE(client->events) & KFD_SMI_EVENT_VMFAULT))
-			continue;
-		spin_lock(&client->lock);
-		if (kfifo_avail(&client->fifo) >= len) {
-			kfifo_in(&client->fifo, fifo_in, len);
-			wake_up_all(&client->wait_queue);
-		}
-		else
-			pr_debug("smi_event(vmfault): no space left\n");
-		spin_unlock(&client->lock);
-	}
-
-	rcu_read_unlock();
+	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index a9cb218fef96..15537b2cccb5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -25,5 +25,7 @@
 
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
+void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
+					     uint32_t throttle_bitmask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b197dcaed064..52b52cbb90e2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -639,6 +639,7 @@ static int smu_sw_init(void *handle)
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
+	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 9b68760dd35b..eb3a57593f69 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2251,6 +2251,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 
 	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 			log_buf);
+	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 896b443f1ce8..18ba421c59bd 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -446,6 +446,7 @@ struct smu_context
 	bool dc_controlled_by_gpio;
 
 	struct work_struct throttling_logging_work;
+	atomic64_t throttle_int_counter;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index fd82402065e6..a9453ec01619 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1311,6 +1311,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
 				break;
 			case 0x7:
+				/*
+				 * Increment the throttle interrupt counter
+				 */
+				atomic64_inc(&smu->throttle_int_counter);
+
 				if (!atomic_read(&adev->throttling_logging_enabled))
 					return 0;
 
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f738c3b53f4e..df6c7a43aadc 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -450,7 +450,8 @@ struct kfd_ioctl_import_dmabuf_args {
  * KFD SMI(System Management Interface) events
  */
 /* Event type (defined by bitmask) */
-#define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
+#define KFD_SMI_EVENT_VMFAULT			0x0000000000000001
+#define KFD_SMI_EVENT_THERMAL_THROTTLE		0x0000000000000002
 
 struct kfd_ioctl_smi_events_args {
 	__u32 gpuid;	/* to KFD */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
