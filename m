Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B663FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 03:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565A420714
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 03:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2mnBzqfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565A420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C2E6E428;
	Fri, 24 Jul 2020 03:21:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154B36E428
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 03:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoj9EbTNxYhFhbwMqzlbiQK2cfsNkyJ4GAl0vlt6ESUUwE3Wmr+IdMYFJhySvCHGTWHETEsqHDh3/D3Zt1ZMBhIfCaMqct+MNMJHQb6aVW1yaOWZ+ZunrA5TE+h5S6X9nDvqxVnla2/YIPTyxnz9vwMOiC6Bn6UNMtf09LRbyACOyEMNNCMmjd9wHMMRRKsgHcFzUb3xacZYN2utB0/8DhDDap1Sewk8eq7rXSPJiF+G6xCkvUT3iuUx2WObqwZBfyduz4nr0/kstn3llb1MIDSxoaPf3x5/rmDKeLV8p9tLwiGSIGkGkoIqOIIhaql7LRkZrpeqoJo/uYenOEUQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWVz3jHmeS46Hfsvq6tOSneFTpr40r5k3sls4pxHNTA=;
 b=YxmxoWFH5WriKkodE6SudK/bb9YFl2LhvNhD/Lfo3nRGtj3jYwpHMCDR5/vPlWoaYEBrAas3AH4JtNGPp9aFPPVs7BNb6jVLjU5Gp1du97v3rMGBcPpbnqSuK8pvKNkZXUTx4rNlpmvorLFs1LSiZkHTqXvHvhdK1Tn/iYxyCd0DLkIAZx02Qzs2cvMq7OKto/cmyrT43Jv7WGDYpW9T0A5AFbOIbFkpGLEvD57E1fMwRJdvgE7TCua70wWc++vswE6mPU2yP07LF1VzQNwgwY6QNIuMnjyDMQzL9zt56SLFllb4MBqDvSAtbrCSuPX8Z6MMIcSDwIobTJDcUYaSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWVz3jHmeS46Hfsvq6tOSneFTpr40r5k3sls4pxHNTA=;
 b=2mnBzqfhrq8fOU/UA0LXhBhJsqU0/mIvZ1u9ZBV8hU5/bHkB8khGK2Y9CEAbofxaLL7qInjE9z6o/UsIEw5Rib+ZW7+yUiVE4CFaMRU5IutcjUhDw0IPmQGp8kTGIH29JVtO4C+hjfpEkrvN78DyWKznZ79qeY9lVxcYAoPd5R8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 03:21:08 +0000
Received: from CH2PR12MB4264.namprd12.prod.outlook.com
 ([fe80::d5db:81e4:c1c3:841f]) by CH2PR12MB4264.namprd12.prod.outlook.com
 ([fe80::d5db:81e4:c1c3:841f%6]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 03:21:07 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: Add thermal throttling SMI event
Date: Thu, 23 Jul 2020 23:20:54 -0400
Message-Id: <20200724032054.31115-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To CH2PR12MB4264.namprd12.prod.outlook.com
 (2603:10b6:610:a4::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Fri, 24 Jul 2020 03:21:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4ab96d7-7a3a-4378-751a-08d82f809b11
X-MS-TrafficTypeDiagnostic: CH2PR12MB4326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4326B14AD3A2DD91009B0BC0EE770@CH2PR12MB4326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mgn090bcGD99Rxfh8NQG/ZvlaFEH2htu7sM8TQ0ltV5NDK6GGe9+aTxSrxE/FEAoMP+n30KpPW64JejkF6mXDYgVZyus9GU5xu3LGLwCA3Lwo+WK4q+/IW2YAusO/5tq0GeOP65dirBY63reOJ2A1KQaCWiClmKJ2LlHYYJRjOYDKyTEiYUYKOY5JBkeb2HnrdoepgK+jz2GpmYpPkkevMRQxIBZ2LjvjiEinHwmRF6NCRZ9E/hAmLSKugICkkCJ7yJsPhL6FZ6YaiByqdvqq4gqydvjmR+vv+gm+qAd/AdEegAtIvThl6wzO66X2aRy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(66476007)(66556008)(5660300002)(66946007)(478600001)(83380400001)(6666004)(52116002)(7696005)(1076003)(86362001)(6916009)(6486002)(186003)(16526019)(8676002)(8936002)(316002)(2616005)(2906002)(36756003)(956004)(44832011)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wfv9Ik1NcXtMLJwUEF0a+G7MbtUochRBX92bb7NWSKQIZ2kCqvJtkTHCMY5g68bAsTwfltgfZ/k7hcKhTN3Wu2kVK3cY87/ry09lNC2aaQsLtmooUzTvvTEsi4+O/xAFShRXYHEZlrWF5MRJ18eVEM8R/pzundGAu+DptOX71pzTwQ/8FaLYCH4eg7fh0Z/CpveZlwCxkXWwO7E5aHQR9vGWWNj/fbBOGm1VJWGhZDl9lIZcu7UtNsq1Ig4nN3KERBPk4U/0fvigvR997stHtcoalf0RUVJTChXroJx2xRs8MjyaJRl2gQiPoaJDK4ePIynJCrE+cU3bAJ5HRr8e9f9p9MiThQnVaKggqTzcq6qbgBDLeol5AKj/nct2VzScHbt7NNA5jelpdNX+47cgUusxMSdtXRvlqh9DcsorlEI1NUF5v+zbE/Gs+CUdyjM9jQOZ62zFb03ZdHvFIRrny8NTxvR/lAYMZsgrcHikoMsevuq7GQqLv0+iHMiN3Hrp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab96d7-7a3a-4378-751a-08d82f809b11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 03:21:07.8629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiglqQM2fKYfzmvPNndcBCBtAM4ZxJajWBrcPcmwhEKT/YHiZT22t5YRXgdI6w7yfv/HHWADdytXlxg61nt/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 67 ++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  2 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 ++
 include/uapi/linux/kfd_ioctl.h                |  3 +-
 10 files changed, 74 insertions(+), 18 deletions(-)

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
index 7b348bf9df21..86c2c3e97944 100644
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
@@ -148,6 +149,54 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
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
+	 * ThermalThrottle msg = throttle_bitmask(8):
+	 * 			 thermal_interrupt_count(16):
+	 * 16 bytes event + 1 byte space + 8 byte throttle_bitmask +
+	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
+	 * 1 byte \0 = 44
+	 */
+	char fifo_in[44];
+	int len;
+
+	if (list_empty(&dev->smi_clients))
+		return;
+
+	len = snprintf(fifo_in, 44, "%x %x:%llx\n",
+		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
+		       atomic64_read(&adev->smu.throttle_int_counter));
+
+	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
+}
+
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
@@ -156,7 +205,6 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
 	 */
 	char fifo_in[43];
-	struct kfd_smi_client *client;
 	int len;
 
 	if (list_empty(&dev->smi_clients))
@@ -171,22 +219,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
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
index 727cb9fd4aee..23a830d267e2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -640,6 +640,7 @@ static int smu_sw_init(void *handle)
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
+	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 3b9182c8c53f..f13979687b9e 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2251,6 +2251,7 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 
 	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 			log_buf);
+	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 28312d6dc187..b57b10406390 100644
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
