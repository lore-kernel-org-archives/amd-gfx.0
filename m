Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C70C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B153D20776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b+Vz3jFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B153D20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC8F6E500;
	Fri, 28 Aug 2020 17:53:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4C96E500
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 17:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGT0iecMlIa6rpGRyjNNqBoq+Mc4LxmwfwrOO2uH/MfC+kFl1XxjVyRxqTm9b4MObUC8OV7Nc17r6XKzJTnGGlMGjsmJekNxMgtQYLHDy8H6xGVv660+LBJ9gamkuocUEgEea87Dio10y1i4JpudEuZ/eW9uN8ktK0o4DKy0OB+xPX27C2eKVE/OtIwI9rz8yXrYuL9KiRL+XfD7gJBW56IlSg6jQP3W1s5bEhw0OQAazM1y0D89m25ST4U8QqNbK2O4JprrkYB9UNHOzoYxc6TjroKVB71FFBm67VSB6l6NtzhuSS8049v2TRu6Nij3LtEr1ehfXXjD1gOWKO/X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAOePl2eJJ4GVKwNBZg9NrUeV/1mzom0kCr0Spzd9+A=;
 b=RlMmaRsxChkF4ojE67h+46qumljSSjdZeLVwoAvMmbrDEodwn1wxyWEYZNzRgVP9q1h68fpZ17uLroqOdp1QCK0vO0asaK5Vdk+f+mq+RjxjDE0lKDtjLB/pRefQRtH+ct89DEs2hlPP4f865EQHXixtodDYhwJxr9H763H8s+fIjU1UYwQxXKT2s1vDZfQEfYZdhMKBGL88o667blNteaBmcfI5BYWM/YqzwlzKvUSfs4Mc63p5hid6Odi7m33hG5EQ6CP/YLAe0jKR2nkBG4GLVXsZFy4gMlxC+qfux1BUa6qOi9iavOYezb1OfJo4BYS+EV7/irYGSWRjqJl5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAOePl2eJJ4GVKwNBZg9NrUeV/1mzom0kCr0Spzd9+A=;
 b=b+Vz3jFnoztgR1xkC1EqfN+FVnYG+i87yQ0aSfMjXG18A4+qJYG9yUy0TuLKF43Y0T95pDnHLCe9+djlJ3GRYtbjcWyYwwZarvEqhJCTw5YG5iSVkEW79s9UVvC54MW2xh+l00LmhWke/m195uh5YU4jTzAzpTnqKK5JEPARH0Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 17:53:45 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 17:53:45 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: Add GPU reset SMI event
Date: Fri, 28 Aug 2020 13:53:19 -0400
Message-Id: <20200828175319.12125-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 17:53:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3023063-9742-4d89-1f59-08d84b7b4ec6
X-MS-TrafficTypeDiagnostic: BN7PR12MB2833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2833E8C28817B0F14394FEE4EE520@BN7PR12MB2833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eg+GkuXFNXLa4Y+LlzMCiIpWyguSkMSZSNs528XrcURRFQLfhbTKW4m7UemNpTI7xbgxOXDsah/jebRg74K5n7GV4SFWITxh5ybfDHqtBcwv/tTudRbFLo8YhvPzm5Pb2KKduC3r9p7mEqrJYazvIXFLT3vsAwzxq7tBmEy6h4rm1NgPE2NVY/8hGTFLMhn28TJUmMv9mDk54jwoA48KPMxDZIAJMtKPGVHZv2c4KMF4tl10IHveNM6IKZNTstXbYOf2hLd+2QqAD4rukFEeNE6ZsUrLoYKb5Zff4yKq82FIuDRmzgko1+jfelD0zf0UiLgmAswVNn1G/pDAO9xSNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(6486002)(4326008)(66556008)(1076003)(66476007)(186003)(5660300002)(26005)(36756003)(6916009)(6666004)(86362001)(478600001)(66946007)(44832011)(2906002)(52116002)(83380400001)(956004)(2616005)(316002)(8676002)(16576012)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: s+2UepvFLf7Y57ro6hdsahkOn1z0IjSlHvXdBwvhsvdqIHULS3bqax5KGq85Pkbc9wFblGYg0MLCEXKMI49wvog3jprwkU9FrCc5T/6JcgrEIrWz76Q/e6ahn0Xw9QG08z3rAJHa8DOQuLPguBCx6XWnq9XAh80Z4Hzk7Gp8uLKRypI3kdXb0HqndYZevMS7VonO8rNMPeFK/Uf82WNZgK+DnlDVymum1K4sgatuvJQVAH6iL2R+Yu8h6NrDxytmoB01fjBOpZC5SInS3zZCmpxFVzeRAYB+Ga04mHc/kOtTM/peRnSee+zz/gh7MEIOWMflJpnl6rrzeBsVclTAx5jeTCi+YRtmUGUIJf5vWP9Q77XQwc+3469uVoUzdXpBmA3LABI1NMBc34CduZQufDLP2Ryw5SAGPTJ4odXCXsjvY3gR/lDIU7ItlsPs2Bamvt6mq+ZcyQWJDXmTw/gP9tnBmgKDlQXlqwilt6XFvJ/CB/nkWsfcAnpOdgfLAWJR6X6t4CrzFXnb0UPp/vydxzMAaFqcynBcuKa3zX75KYK5TqX6XSYzrrEh5Hs2DaoBpQu1HYRCsvvYtHI6P37tFyv1a4OTZBzGgOUuhUAxbqnRZAnO5hbUM+PLSqGEbd3sgXN5rlrtoobPOLZtaqHldA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3023063-9742-4d89-1f59-08d84b7b4ec6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 17:53:45.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CbqfiP5JMRVEttNIosPPldVdE4i7DcX0ZkLrmAlJskurjN8kDCXiP7ZuNghm2FjEGa8NQuyEsNRLKW1uHGOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2833
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

Add support for reporting GPU reset events through SMI. KFD
would report both pre and post GPU reset events.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  5 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h       |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 35 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h              |  2 ++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e1cd6599529f..f5e1b3aaa10c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -812,6 +812,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	kfd_smi_event_update_gpu_reset(kfd, false);
+
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
 	kgd2kfd_suspend(kfd, false);
@@ -833,6 +835,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+
 	ret = kfd_resume(kfd);
 	if (ret)
 		return ret;
@@ -840,6 +843,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
+	kfd_smi_event_update_gpu_reset(kfd, true);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 18bc711f97ae..7e8767934748 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -312,6 +312,8 @@ struct kfd_dev {
 	/* Clients watching SMI events */
 	struct list_head smi_clients;
 	spinlock_t smi_lock;
+
+	uint32_t reset_seq_num;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 4d4b6e3ab697..001cacb09467 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -174,6 +174,37 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
 	rcu_read_unlock();
 }
 
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
+{
+	/*
+	 * GpuReset msg = Reset seq number (incremented for
+	 * every reset message sent before GPU reset).
+	 * 1 byte event + 1 byte space + 8 bytes seq num +
+	 * 1 byte \n + 1 byte \0 = 12
+	 */
+	char fifo_in[12];
+	int len;
+	unsigned int event;
+
+	if (list_empty(&dev->smi_clients)) {
+		return;
+	}
+
+	memset(fifo_in, 0x0, sizeof(fifo_in));
+
+	if (post_reset) {
+		event = KFD_SMI_EVENT_GPU_POST_RESET;
+	} else {
+		event = KFD_SMI_EVENT_GPU_PRE_RESET;
+		++(dev->reset_seq_num);
+	}
+
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
+						dev->reset_seq_num);
+
+	add_event_to_kfifo(dev, event, fifo_in, len);
+}
+
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint32_t throttle_bitmask)
 {
@@ -191,7 +222,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	len = snprintf(fifo_in, 29, "%x %x:%llx\n",
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%llx\n",
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       atomic64_read(&adev->smu.throttle_int_counter));
 
@@ -218,7 +249,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	if (!task_info.pid)
 		return;
 
-	len = snprintf(fifo_in, 29, "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
 		task_info.pid, task_info.task_name);
 
 	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 15537b2cccb5..b9b0438202e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -27,5 +27,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint32_t throttle_bitmask);
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
 
 #endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index cb1f963a84e0..8b7368bfbd84 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -453,6 +453,8 @@ enum kfd_smi_event {
         KFD_SMI_EVENT_NONE = 0, /* not used */
         KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
         KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
+	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
+	KFD_SMI_EVENT_GPU_POST_RESET = 4,
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
