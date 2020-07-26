Return-Path: <SRS0=z8aj=BF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9654EC433E1
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jul 2020 21:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1D42065F
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jul 2020 21:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oJ9mEiq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1D42065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF8F6E101;
	Sun, 26 Jul 2020 21:25:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5045A6E101
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jul 2020 21:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdSo9bKKhqT4zEQjy1XqjHhKGd3hot+BbTGiOQoPvQxKSVC91MQKUz88rNlxCm3XwOOGUI3Qe6fY9NsbgVgDXzHPMBQZODjms6ugtI9yuZNJ1FnSGpOm1IN9dISVdqlZPdacfNxoKCS1hCnwHlrCrGqX9alN/UINRMmGSVcLhjbfc50TA+vjCenmBw+fES5xyAZwffewcm00P2uPFLvkciuLcEUq83QzsksUPjhf6kdM3sHNWZYwdReXqElKRT+Axhro5uzzB6g8E1bXtffU2ta0OoQDNxgTkepZ22B258fAKWtjkPqFuJmvgYy+lnPN7D7yva80sq5yWW9IjJDeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70S0mYhG2hqYZZuKahZipMywKZ3N+20b3UUKvV4xGD4=;
 b=F9Mowek5uWDYDfYPiLWsGwdUQPtgBQS5VsFr7rpXGR2tx5MoVEBkSh+svGjGLClSm6BCCjBJbDT4w41FHB7uKzK4zvl0jwmkDbdGXLCxo+d0ReBWREVsqjQ1LLYWkj0S9LE5xfRQkl1hrE/qN63orUz3wJcbpV0hCvJLCDfEvVpENn2i2dF2X62txZK6IYCrZaMhB2LYQNTNn7K2ca9u2XVreusRIROpmai+yNWMyzuvHz314syBipDAfaJNBvYXqGuNZ2yXLGozC8PK2Z/IeanuO8TXS31bvxG6wp/jo/wNFb43UWpRwS75bbuRXIlWF5DP8ILJPegpgwWR401tbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70S0mYhG2hqYZZuKahZipMywKZ3N+20b3UUKvV4xGD4=;
 b=oJ9mEiq94lAxFRnVleT586nBXSt3IsYnSVhs56VyNPImt/JuP3d/Tj4E+RQeOrk2DWmn1bk4+iE9X4m8uhAsQSkyqVSHmRYvQ5sh9UPYv6EetMFF4cd0QvL9QR4ppVO640GcjrTj2VFRq7hJFisrwcaztuArq6SAZHZJECToPYk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Sun, 26 Jul
 2020 21:25:09 +0000
Received: from MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::d0b0:991f:89a3:2a06]) by MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::d0b0:991f:89a3:2a06%3]) with mapi id 15.20.3216.033; Sun, 26 Jul 2020
 21:25:09 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Replace bitmask with event idx in SMI event msg
Date: Sun, 26 Jul 2020 17:24:53 -0400
Message-Id: <20200726212453.24106-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To MN2PR12MB4272.namprd12.prod.outlook.com
 (2603:10b6:208:1de::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Sun, 26 Jul 2020 21:25:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22cdcf99-81ed-4564-af9f-08d831aa5f69
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42691BD35C9C56C65775B549EE750@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3t6A7hdrHKvA0MHSUBO1YOH2kv+TeVLGGq/mdaZVfna+sSmfw51ahAVSs38w4WGv9zmehoWRGExk8EKrBHDUGfyEqObxJHQujVcAKty6Dtiz0hwU4lj2//lMpN+2ghDzc6/69YXw/0CYQ60Fs6rQc1ZtliwUsARIihhXv+e+V5tUH6vbNj2eAUDKFSEXs6WCoah6xhUaTK75452ohW7wKnNYYuyw93Y9af6mWA2i+2eeg00a1U+wJe7fraelqvkJ2AB89Q8fnaEMLppJFBaRVYoRlcMymYf6weQFGbTGLyb2kxFk4ADkTYWM3Fh3aTER2lz1MrrlZBU0AwRdDNosw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4272.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(86362001)(52116002)(7696005)(8676002)(44832011)(83380400001)(956004)(36756003)(2616005)(6916009)(6486002)(8936002)(4326008)(26005)(66476007)(16526019)(2906002)(478600001)(186003)(66946007)(316002)(5660300002)(1076003)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PIswbWIEw0wCo4zYisWbn0lWWKE/DXRqqTf8Q65OAQHKA2FPq8IE+xBENX9NQK5xvz/FS+3o1PV9Y4jBypfzmpd22A0qExZ0uoTimlAFdJibyK+50C2DjgWVmlhLc6z4Yq+t8NwF3mskzb4NVEWNpfFjpGNmyQBK5JOuywjctlslbfO475qQcRpydyoj588Os7qVrz9ZnQZOIi9ElCgIWD/vDUN1g+o+xr6TJE7wG8bwq6grxjxf++7DLC/H0SKggYzHJONUTiDtZ3LpVcJQXUbGQfCpqOcY+D+n4sURxXxGHJ9pKGdK9kUOaUx+DaaTOeQ82Yw1AKOBwtuMhrX/RW03u0dS2dncppxb/Lt5YWzrfC/JyBMGF/PC6SYr/TL7zqa9B/0XGmu3ih9aryQUCSm4kt90PNVsLUEmoS2S4ueqlO5a4grV2k6E87CXPo+sxG5sK08ai/CMlIpGgUl8iw5q0sFzGhXrnpK2DXKtA4EbM8J8wi/wHYsN+/urxNww
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cdcf99-81ed-4564-af9f-08d831aa5f69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2020 21:25:09.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtZQZDYhL3jm49omUAsyuwOBmEM9y0rs6M2l8p+EuhrrMu8UY+HuR0zhtfZgzZeaXAItjt8p8FKJPGRcFeXH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

Event bitmask is a 64-bit mask with only 1 bit set. Sending this
event bitmask in KFD SMI event message is both wasteful of memory
and potentially limiting to only 64 events. Instead send event
index in SMI event message.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 24 +++++++++++----------
 include/uapi/linux/kfd_ioctl.h              | 10 ++++++---
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 86c2c3e97944..4d4b6e3ab697 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -149,7 +149,7 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static void add_event_to_kfifo(struct kfd_dev *dev, unsigned long long smi_event,
+static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
 			      char *event_msg, int len)
 {
 	struct kfd_smi_client *client;
@@ -157,14 +157,15 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned long long smi_event
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
-		if (!(READ_ONCE(client->events) & smi_event))
+		if (!(READ_ONCE(client->events) &
+				KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event)))
 			continue;
 		spin_lock(&client->lock);
 		if (kfifo_avail(&client->fifo) >= len) {
 			kfifo_in(&client->fifo, event_msg, len);
 			wake_up_all(&client->wait_queue);
 		} else {
-			pr_debug("smi_event(EventID: %llu): no space left\n",
+			pr_debug("smi_event(EventID: %u): no space left\n",
 					smi_event);
 		}
 		spin_unlock(&client->lock);
@@ -180,21 +181,21 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 	/*
 	 * ThermalThrottle msg = throttle_bitmask(8):
 	 * 			 thermal_interrupt_count(16):
-	 * 16 bytes event + 1 byte space + 8 byte throttle_bitmask +
+	 * 1 byte event + 1 byte space + 8 byte throttle_bitmask +
 	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
-	 * 1 byte \0 = 44
+	 * 1 byte \0 = 29
 	 */
-	char fifo_in[44];
+	char fifo_in[29];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	len = snprintf(fifo_in, 44, "%x %x:%llx\n",
+	len = snprintf(fifo_in, 29, "%x %x:%llx\n",
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       atomic64_read(&adev->smu.throttle_int_counter));
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
+	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
@@ -202,9 +203,10 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
 	struct amdgpu_task_info task_info;
 	/* VmFault msg = (hex)uint32_pid(8) + :(1) + task name(16) = 25 */
-	/* 16 bytes event + 1 byte space + 25 bytes msg + 1 byte \n = 43
+	/* 1 byte event + 1 byte space + 25 bytes msg + 1 byte \n +
+	 * 1 byte \0 = 29
 	 */
-	char fifo_in[43];
+	char fifo_in[29];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
@@ -216,7 +218,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	if (!task_info.pid)
 		return;
 
-	len = snprintf(fifo_in, 43, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
+	len = snprintf(fifo_in, 29, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
 		task_info.pid, task_info.task_name);
 
 	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index df6c7a43aadc..796f836ba773 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -449,9 +449,13 @@ struct kfd_ioctl_import_dmabuf_args {
 /*
  * KFD SMI(System Management Interface) events
  */
-/* Event type (defined by bitmask) */
-#define KFD_SMI_EVENT_VMFAULT			0x0000000000000001
-#define KFD_SMI_EVENT_THERMAL_THROTTLE		0x0000000000000002
+enum kfd_smi_event {
+        KFD_SMI_EVENT_NONE = 0, /* not used */
+        KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
+        KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
+};
+
+#define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << (i - 1))
 
 struct kfd_ioctl_smi_events_args {
 	__u32 gpuid;	/* to KFD */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
