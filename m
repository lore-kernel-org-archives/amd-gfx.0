Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FBC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 19:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D932074D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 19:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JME//DJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D932074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC086E220;
	Tue, 25 Aug 2020 19:12:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6538F6E220
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 19:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY3vmvXodG8JY8H1CLgt5qFt4QTj64QU/lQ7Lx35KsZUWQN4SUgTYJBPCb0OFuKcF7KgJTA3HrPsMI8Y61FdHX1Jm0owiQc0+VKp0mVgzALiEUnkuiNFx+Ftuq/qHFwzQFLcIbYoPZmymHKbuEIvoOT0kIeOOguoH6kepoeUpclEV7fzpcLLjTAwQNhvV1iJLT6EzPxNEGnI80VLI2EKGcN64NtQ41thPN5vLihk7Uf6toqtMHdcm34oMiDe5WEj/09XN5XmpXpx3xekzrStOxGMNbAFDhuL+Fsnx53gcqX/67w6tapBzDRtCaBrPL3P17Ee1iHCXttulSt1+vErOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okpm1o2RmyA3wGv2Dd5unfiQYTSNqF4ZpFCCjrnPFQQ=;
 b=AXtcUVfbrE76X4M77SdB6ee482PkECQfImRA3w+FVKuIWoT5W3lS1gS9KFK4IvMS8PQnUTCNpr0av3at2McEVlm/2kfzm0pehEY2tzR3OeV5d9Mo6xpaMoU7BVTB8zSK97ObNpox0jSr3qAwO8R0QYnBofrJCI/Y7CxRKe6UtO8c7kB18zIUWyhlDYTiGHPp6SIbYt6njpVIYMLs3uko9AGdnvysZFOmjne1whTnWM1yeHkHe45/v6woCk6qWTNCJ5ckowcvyXGmUnPOMqjI1hQeLxvK1NBtKJG9PsxTpwoG9F/wiaLNL3nlZR/tsDeAVIOOLnx9kYZbLybrd/oSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okpm1o2RmyA3wGv2Dd5unfiQYTSNqF4ZpFCCjrnPFQQ=;
 b=JME//DJ5jIB0vA9O2O/uj83dljbe7uqav+SHx2A/qKSL+SaIQK78sStWUypKAKvDa+P5aI5g9XowFehqXaEUsp53kKFzwX8pa1rsqr6g+ky8Zi/JGGnI/sI5qiUzeD7aqoX+Mr1fYxJGaTtxiAiqe9u0yWdaz9u4sRWSHtLeL+I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 19:12:40 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 19:12:40 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add GPU reset SMI event
Date: Tue, 25 Aug 2020 15:12:23 -0400
Message-Id: <20200825191223.7795-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::21) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 19:12:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a04e675c-51c8-44c6-6c31-08d8492ad5b8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB33631CFB4678A5FBB4AC71ABEE570@BN8PR12MB3363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlB4s5BePIlH5YYIqj2rQMrezndmYeDEzA2iI4AUgolDRSII2V09qHp2AUqQ4o1nilGwGhvlrHz+5JOTdE23W2ISBoD/4wEQd49XHcoTmv39HK389m+1czQYggJeQCp8YC+o3ui10q1CdCFUlgISCEW8kvgJQi6fuVtefpGrYWujUUJYk1gnq8LMGcgwYKKshOqKA6RfV9DCtX9nQmsilF90oMuUjMa58WFiz0uOIaL/l16vv6XrvQJJ1r/f2AL/gJvfjkq6lWDRldjhwBf1c0PiUdNj0f7e2UBvDb6AaRiBqujFxq2ecpjgdB1rnBEcE4TAVhbMv+sq5C/tYjJ8XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(44832011)(86362001)(2616005)(956004)(2906002)(52116002)(36756003)(83380400001)(6916009)(4326008)(8936002)(186003)(316002)(16576012)(478600001)(66476007)(66946007)(1076003)(66556008)(6486002)(6666004)(26005)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3h5F2X9rGkMoWdLVVUAgBPAklb5kmp2D2f2vlGg1kzXVi9zJ0ZLJxK0NKKKDIE0AyxozRfEMYL57XshN089IAeQBVF3s30hIP1VfIA6mE3dElBbZS1RbZ/KigcfNFrLtqpETAgxkvjvGPfP3cYBOQhVWsk3ZBA/X2BkVmr9Z+JosNPwlJYUBRimrUJ3n0fmyFLb72jSotXjnigWMftAeuOrWBlxv50cyPJxi5HDu1vAGo/3QdU/PS1MQOilhqwWwZUjK6fB83Q9/0qmNmBloLWxhF3MRj1MW3YRSnYwja+LBiwYulZX3eAa3megzdnUAA2e+CscEUJqfaGhCQql4MVnxHByhfk5ZB61i0j930DXZUVy5CgFNb6MZpTQ+xrC81+J2j8dpdjCmi3cMLG5IPw9JpDQWqdza9+Hfyyk+3Ekb7gq8NRgLCQIPmT6BFELojO/jBu6DSQggZhFQe+6VWUOcVlRTtM6peE4N2xJxQhRvh38hQiaKF1kHZPEhaQ1sCGg9mfkrbUy919oILcZOfTM8fAvulNgt9raW+1P0c8RTsIvor6eKzoAFt4XmGVUMc+EpxUX0FgqeUkCDcPh3ydlX7Z+27VwGX6D+KoJ6J9m3nfcFAJWnvXeqRcVJs9Rc3oY0ZT++wwUPNoSS8W0L2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e675c-51c8-44c6-6c31-08d8492ad5b8
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 19:12:40.0080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qv/3qYZ5XiPSLu3T0m8PmLskPCGP4JHRLZqPd9XGSjmCGuZpHAQRvN8E2WyYQupvgh4zA0g+z17fGAxPS5CCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
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
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h       |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 30 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h              |  2 ++
 5 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e1cd6599529f..aad1ecfa1239 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -812,6 +812,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	kfd_smi_event_update_gpu_reset(kfd, false);
+
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
 	kgd2kfd_suspend(kfd, false);
@@ -833,6 +835,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	kfd_smi_event_update_gpu_reset(kfd, true);
+
 	ret = kfd_resume(kfd);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 18bc711f97ae..b1a2979e086f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -312,6 +312,8 @@ struct kfd_dev {
 	/* Clients watching SMI events */
 	struct list_head smi_clients;
 	spinlock_t smi_lock;
+
+	uint64_t reset_seq_num;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 4d4b6e3ab697..448abfdde230 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -174,6 +174,36 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
 	rcu_read_unlock();
 }
 
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
+{
+	/*
+	 * GpuReset msg = Reset seq number (incremented for
+	 * every reset message sent before GPU reset).
+	 * 1 byte event + 1 byte space + 16 bytes seq num +
+	 * 1 byte \n + 1 byte \0 = 20
+	 */
+	char fifo_in[20];
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
+	len = snprintf(fifo_in, 4, "%x %llx\n", event, dev->reset_seq_num);
+
+	add_event_to_kfifo(dev, event, fifo_in, len);
+}
+
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint32_t throttle_bitmask)
 {
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
