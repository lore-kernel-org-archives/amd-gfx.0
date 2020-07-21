Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A0BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 21:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C061320729
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x1ZOCmqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C061320729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9596E5A3;
	Tue, 21 Jul 2020 21:02:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8906E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 21:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MloK+lPN8qc+v8rugqAwgo95jwdsSR9vWTeRkYaGgByoJNwPkeGpeTVYYrLroEEPIT/Z1i1OJqTCn4qGLPIFR07roAtyFOmQAhsAQ24LoKH772Nh5m9NFvQ8t7YyCIHUlEkIQHlN4OjixcIG2yVIWLKXf57QbBtSVEzYVdEEugXyuiMJBWsWwY+ORLWRh7x6IbiNbwYql0FfZC5YkeQuP+1r4fgujOMS3buNmnWI2z+5ZRfCH4c9mZBPYdGdWe0z5HobkHfn8N2GWxNdwaSQ67qilX82ZqUmUI73p1HpqloIOdfLqzn08rtuowInEhqyNvod8cKMG+wyMF6hJ5n8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CGpLTtcCTzVINIQ5qeSp9CD7nZoPuXWNRuP8sVkcSg=;
 b=KF+7Oi0775FHs1WPykMZMY3WlaYPOc+X6lqbfSwi5ppkRNVzv+ir3pDLNU6rxfOzOLSKM0nGyblIGy+TclN3q9znD3pbmEAB7C7l4L6W+HLIPvtsm6wCxXsVuM5s9ds93EzMvh01Emkds3leRko76AHk6phn1S4jXqiz0HQ4rT7wHwbGO1UaXTFzB4j5g+mW66zJErlJ8A0iNxOTkdsAgrY3pRh1iIykgk4OAvJdz+mTSgJRaPwgTrI1uF3/91d2G1H2HfuxOyQu/NN793pDqtqY7e0mptIjEQsQAECWzFS+Jvd4DXMokbpOFBXCdKptOiXz8i+8FWaA7h9MUZWCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CGpLTtcCTzVINIQ5qeSp9CD7nZoPuXWNRuP8sVkcSg=;
 b=x1ZOCmqaokaJ75RRp1JQW/4rOU08h27BWW/FeiO7OvF885Y7MQVGHPvnTVwRk72/11Hw9S3uGHrk5qST16ykxCOPTayCmi4kBed2fpOHHhYznDaYwv2hoAMH3ZMADUPLzeghHJCJAV2HbXHcuDxxgWQh7yaNT2sXuq9SiWz4Adg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 by MN2PR12MB3984.namprd12.prod.outlook.com (2603:10b6:208:16f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 21:02:12 +0000
Received: from MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::b0b8:3c8c:a65d:4d63]) by MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::b0b8:3c8c:a65d:4d63%3]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 21:02:12 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add thermal throttling SMI event
Date: Tue, 21 Jul 2020 17:01:55 -0400
Message-Id: <20200721210155.27196-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To MN2PR12MB4272.namprd12.prod.outlook.com
 (2603:10b6:208:1de::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Tue, 21 Jul 2020 21:02:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e35e509b-eb61-4082-bf12-08d82db956a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39847E7082B53E986826FCEAEE780@MN2PR12MB3984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oO513Yj2LkqaKhDGj32P40+sUtFn+zZ61JhqadZkaiF+8iW2j++vVnvtllOXdl6EZiIw06eFsaJaEFY2gYNgasKQOTOi/SaXsCThA7uLhcOvKP1aTjnvDSn3G5rNPh/+3/Fxzq5A8Re+0dZElbcq+xWHxXMSyPvvAPf933X1MmKIrwFEPeJFrVkbfbpIGN3cZVgmAmxVLmR14jpN+3fpVkMX6aEaPuU7IUbStql7XarDtzm111wZ9Zn189ZVBPYBQPrBzlL1+/Vt9smNjRUHsi5eMwIzT63BOaKvRjTPDBPVY3ifZzDN0p796yfLIhZb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4272.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(26005)(956004)(6666004)(316002)(2616005)(8936002)(1076003)(86362001)(2906002)(5660300002)(4326008)(66556008)(7696005)(6486002)(478600001)(6916009)(36756003)(8676002)(186003)(16526019)(66946007)(83380400001)(66476007)(44832011)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jzNVNBZ3Ybu9E9INOA7G803pmiUhKpzlm1s686HSRu1Enye7ezd1pxv/wuha+XE2h2Cogu3bUpDdg5soTnGOsK7p6J/SIQnQLBuWLx9OQOsus0WLtOfEUE+ShhOlztX5f0nFPsVelDJ90cLE+2vt9Endhff3JJkaAKCw5MBOyUdPyGjdf3Bf44LYTgzzJViRRDz5DwjMpbaxRtUgcekdIDtiLIDwNXoBC9kNXOo1eo0NGAVchFzU2IjHbjri2SXt5hcsFX65QV7cnCvS8nmq7hmgQLWXkozi6ZAOsvYPkBIpBMSpleKmLJVVvhFCznLJeuqNRluHOMwa2FRbpv/lVjsUaDcLkMy1j32/lU92vPKywGC3YLJaSO/6LXKGJqI5M1agV4+RBxHYiL6BIrlv3IYYcke1159DUnl8k5NqT+6LVHlz808dQewwEGBP/YQnA4wL0N50ZIK2aVhJXLvNRaO7ppAwnbkOIzCt79/I9uk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35e509b-eb61-4082-bf12-08d82db956a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 21:02:11.9551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sFM8ojIXfVHJdpV0kIubuh+6qiNI2W8P5HJJPvF5EGgitQYSWfWL6myZ08ANP46Zk8ZO0BDu3UpaG7vOFu7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3984
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 70 ++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  2 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  6 ++
 include/uapi/linux/kfd_ioctl.h                |  1 +
 10 files changed, 77 insertions(+), 17 deletions(-)

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
index 7b348bf9df21..247538bccba2 100644
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
@@ -148,6 +149,56 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static int add_event_to_kfifo(struct kfd_dev *dev, long long smi_event,
+			      char *event_msg, int len)
+{
+	struct kfd_smi_client *client;
+	int ret = 0;
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
+		}
+		else
+			ret = -ENOSPC;
+		spin_unlock(&client->lock);
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+
+void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
+					     uint32_t throttle_bitmask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
+	/*
+	 * ThermalThrottle msg = gpu_id(4):thermal_interrupt_count(4):
+	 * 			 throttle_bitmask(4)
+	 * 16 bytes event + 1 byte space + 4 bytes gpu_id + 1 byte : +
+	 * 4 byte thermal_interupt_counter + 1 byte : +
+	 * 4 byte throttle_bitmask + 1 byte \n = 32
+	 */
+	char fifo_in[32];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, 32, "%x %d:%d:%x\n", KFD_SMI_EVENT_THERMAL,
+		dev->id, READ_ONCE(adev->smu.throttle_int_counter), throttle_bitmask);
+
+	if (add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL, fifo_in, len))
+		pr_debug("smi_event(throttle): no space left\n");
+}
+
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
@@ -156,7 +207,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
 	 */
 	char fifo_in[43];
-	struct kfd_smi_client *client;
 	int len;
 
 	if (list_empty(&dev->smi_clients))
@@ -171,22 +221,8 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
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
+	if (add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len))
+		pr_debug("smi_event(vmfault): no space left\n");
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
index b197dcaed064..26f4f28848c9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -639,6 +639,7 @@ static int smu_sw_init(void *handle)
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
+	smu->throttle_int_counter = 0;
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
index 896b443f1ce8..0d8c70eca39d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -446,6 +446,7 @@ struct smu_context
 	bool dc_controlled_by_gpio;
 
 	struct work_struct throttling_logging_work;
+	uint32_t throttle_int_counter; // Throttle interrupt counter
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index fd82402065e6..67653dd7862d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1311,6 +1311,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
 				break;
 			case 0x7:
+				/*
+				 * Increment the throttle interrupt counter
+				 */
+				WRITE_ONCE(smu->throttle_int_counter,
+					   smu->throttle_int_counter+1);
+
 				if (!atomic_read(&adev->throttling_logging_enabled))
 					return 0;
 
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f738c3b53f4e..1e083e20c23d 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -451,6 +451,7 @@ struct kfd_ioctl_import_dmabuf_args {
  */
 /* Event type (defined by bitmask) */
 #define KFD_SMI_EVENT_VMFAULT     0x0000000000000001
+#define KFD_SMI_EVENT_THERMAL     0x0000000000000002
 
 struct kfd_ioctl_smi_events_args {
 	__u32 gpuid;	/* to KFD */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
