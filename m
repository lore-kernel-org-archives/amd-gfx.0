Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FADC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 20:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CC32078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 20:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qy5mvMvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CC32078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96946EAC8;
	Wed, 26 Aug 2020 20:01:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38FF6EACA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 20:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXCf8GmxDrW07kl1tqM3yaGIhZZrvda2TFYJ9Fe4fAPGWMgQhBVOk45PfYTxlskIv9hU1WnxSEhA1JzPqdnggDpZEXryViyL8q1T8xYwaPbRPf4EF0JGbIOPIm/vzC16lgPyFTwhjLxS+YlfG9z3lDnSW/+SnKD52GjAgx8/Q17GdxSDlinpcDt378Q6yJCj16I1pp5cVkWvse3kcWs9cKyL/V4rVBh3OUMhLgJIfTQY4hdZyMueBfhMdjcIvh+sFLHyd19oLkKz33hRrmJf6pRlNm0QZ4rAj49fz9I0tufKdv7S6DL3+g97Lqta0oyJjOMdrgssXdQCOg6WHJeqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbjI4fQwR9Ay25iKQrIz9/oT3vrWz3y9/V8T8pRtabM=;
 b=RlG/9picxxZZylhoSQm9a/ozlAqgxTl5wnDDPgAg9zcRtVl4N5bJD5TAA08t3dvUwRDuY/OJsh66G0iN/rZZtXSVFId5HXJcu3fTjkmcT0AMd266zAKSSQuGLCyDqm7cM2Kz0otWtPFEaOoZpS6Y/Y7JDDc1VmJnBXhZkGjza+lgrNDrdkgxM5ieI6qfV5gIah0rXaMBZlF4QQO97fGzJUKA48HRMGtLlIf+v2ixixI70m7mK0s368FeN+KdDaujWssIY0dahEQg2CuB4JCma1Wd9/qC/pCFzdjhNEy1f1QJH2aUWgNffsOwpUCnlHYZx8qhIiGkVoo+CsTjeT21XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbjI4fQwR9Ay25iKQrIz9/oT3vrWz3y9/V8T8pRtabM=;
 b=Qy5mvMvobvK1Wrpox7obcosiaIf0OW7METzPLgWU/xM81fSJr0o9hYcjssAunA53zDaMmXTACUBSGna3NpgrbKSencW11c5UJtOTtuogF47DAa4IDRsQtjhMwi6e4RIcua8EhDKRW8PXLgz5kPWSW7Vtm9nV0ZG+3pt1z2WtBB4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Wed, 26 Aug 2020 20:01:44 +0000
Received: from DM6PR12MB2746.namprd12.prod.outlook.com
 ([fe80::c177:e166:96f:3d57]) by DM6PR12MB2746.namprd12.prod.outlook.com
 ([fe80::c177:e166:96f:3d57%3]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 20:01:44 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Add GPU reset SMI event
Date: Wed, 26 Aug 2020 16:01:31 -0400
Message-Id: <20200826200131.31180-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To DM6PR12MB2746.namprd12.prod.outlook.com
 (2603:10b6:5:41::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 20:01:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 535048f2-a8d2-4dd0-bc9c-08d849fadb37
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325969E3A33A9EB8E95F018DEE540@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yv29UyEjhbc6rxr6dJBKiPlxeYkZvjYZkeTI6tE9dI2ACc6xObKYuMbx8jqdexihWDFG1nyh/z+TZvaF5SBgVToDayhhMYbw2vse6IA8HX0pOzh8vTVJ+qe9q3++bW5t6a4Q0WzJZMCNCr1dT6cv8SOAZfmkZ+pbEZ/vpyF6QZKfh3y9cSAMYdNKfHokiSoJZnp9ucrmiAQ+LCZd49giXnEsdqXlot9ytzrE4C/PYGqKQnNQnWzHAAXc/NVMhmXWo788C2EKYcqoB/vTox6i98J4q6+mapA4ZzJRUPATc7bQC4Y5vUhY1G2d9IzpPpPZ0U1K0WfdwTGZvXhDE+0NmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2746.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(86362001)(1076003)(2906002)(83380400001)(6486002)(36756003)(8936002)(26005)(186003)(8676002)(6916009)(4326008)(956004)(5660300002)(2616005)(52116002)(316002)(16576012)(478600001)(66476007)(66556008)(6666004)(44832011)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Z1EGd2ZQQKVDh4ftE8CRi8NG3AMu5CaLvR0R2ixRYpAymhbqU/TY71Wdq4y5iBexLQvS1c3/YyGA1+U/B2fK55waMJg3NUrqgLEa4+cAZTbtESue5ZQ5q7AeTL5q8AHPMFbGkdvBnbG1YKsMPIX+Gjdpjqt0370x2a0+n9hXTBTLYsrKGhoXGyoxLoljCX9+D71GFSGC/sOmrvgWWNskpaI2O0w9Pk74yXI/3K5dddP3ahxHnMurxwThmyctaH/60VrrheILIcW5XVYp9amVr8oIel24XDeheQogk8JJvyIt3QTeYg7Hb94oZagZaf7lHLWpBiKqxrqvu6rQSyYP7WJTn4yPpH/7q3XWn+V/vkxtJEB4MzBRVTF22YtCE+Bopt2VRSJkCQqZTF3QGm2jo82dxyRGbPw7lSRDbQF8iBSXwGMXHXbqZF8hwDA4wls0Rg+HrQctMxw0wwSIXV5uPbVVkRSVCAGnJF+UPgyLpF3qiSrmVMi/Lb5t48L1sLnm/zlcOPrrY9VPAgRZsDzqf3g+z/GM6g2GsbJ1yW35fpsgOeoVLRoa0CM6SpvkSWkvgNRtJALcjMYFBWg7RcnTpad4jgmmPM8i+LhclhTjyZ0Q6wSHxU4joHUP4ovZWRn6k+VEfho1AEjzBsNrUmLbug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535048f2-a8d2-4dd0-bc9c-08d849fadb37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2746.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 20:01:44.3708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czglAMZz9W/rNcOzXyhjPHGfI5C2Xw2/mqWKdfBt4WkIhiWjy3PtGhvI/22eGrNQkp8JMQQu9muqtDwU2XNy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
index 4d4b6e3ab697..4f0590bcb1a3 100644
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
+	len = snprintf(fifo_in, 20, "%x %llx\n", event, dev->reset_seq_num);
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
