Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD94AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 23:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7D02076E
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 23:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="raDfYE9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7D02076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7AF6E4F4;
	Fri, 26 Jun 2020 23:40:30 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72346E4F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 23:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Y1wmQvm+Ts7WifhZHou+1rxgm6qCeRtDTZN/VlVBpdK4P4X1zWOM0HtkgIb8CjohOtjMPTholEV5hIpfPKzIrfsxffcQHunMWJhY7TvolSQEpz0nGWdLde+vSZqgaYBjOw5UYuC/8kWuly/hcFyYWXMSMbKLNXrvns6gk65tSNxuW/fLiTupK2PyjY9Us5pRz71irnY//PG6qhxVzImyLgYZSQBtrTFzateBY+GZ8csWf2R8cpCguGy5ypyB8keLTB6IB5aD8Z6IBPDkxE0Snvq6iRcyTK/ojtv2Ii574qCnrkAZ6bO5+7bSuiXEfW2w/W+peGsQ2fP0ymk0KTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8F5oHGJDCyArZXfKJCnJuOocWbh9eUKG1PMzOHOXh0=;
 b=L3WSCvYAnupnXoGtiZB0cvk3NOIk7i38LhVNVkUe1x3if9/Ti94132orgTCPTr49JIpo6YLcAyoyCmVL0TVltX9hb6BP+3YEzQDSDuiOrZmBS+GNw7oupK8hJdcftXJdWV0mut9KidgAAELPi6Eew0WDx7HcMQWMF289BemZWcSOrDZ7cCbN31ZpGy7JRxFBcjBNP0tsP0rIkvKcvTGys4zZSSDkEXbBtjGUdozF0fwUCkRPMkHO/iizh6ILoUmHiw96rs7/SsUxJiU+rMSKynITN/i2wP+EwZ8ZwyvZl026YXMcaqjsPrIJMgDBoT0EKWgOOYon7PyXYIyeqSyFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8F5oHGJDCyArZXfKJCnJuOocWbh9eUKG1PMzOHOXh0=;
 b=raDfYE9oBAnsbH3KIbmnZkYq9RyLm4oHvgo0MRA6a9Xoslt/tFHN/sTZ+AGO8xyTIpMjucuPunhqlAk6meTrnIFc4SH5rxwWgsC8ThEChI12oJsz71I/30F6jwr1353aVfS9cZM8FvlNbqqUTc/YL1lG4/vD/YtrYl/GIVcDnI4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2783.namprd12.prod.outlook.com (2603:10b6:805:78::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 23:40:27 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 23:40:27 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org,
	amber.lin@amd.com
Subject: [PATCH 1/1] drm/amdkfd: sparse: fix incorrect type in assignment
Date: Fri, 26 Jun 2020 19:39:51 -0400
Message-Id: <20200626233951.11724-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 23:40:26 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fef4c406-123c-4a95-2a83-08d81a2a4dc7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2783962390C15AB7074CED7492930@SN6PR12MB2783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8ndl1Womi5TD9qNNkkGErxWPcea+VHV7U875+RBYe7HiRcSdiK6cykmUgLZRGZxjoLTQ/HT/5Rr8d/IklO+L4Rc4ZSHy6nBXwycPSuAQyaHZ6+6xgFqBmsAddB3dGZYHIfAvLQVdc8z91J4RsFcoHSGYuPvxRH68yyD6X6aod09u/JE6i5MqnHDvzwtdsEiWHODDxpiJcH5XGB7vbvGo08gV+BOx9l2RKxk1L00c+pczaRmPpYAEHLQVcxEFtmP2NogFnAOMlODFc39T3jDy2py66S1zu+VI9YdyDPVSF949dZcx1wwVPlnVCyP9dHKHmuQ17rI+oQPOTYzvp2/Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(316002)(478600001)(186003)(6666004)(26005)(16526019)(83380400001)(8676002)(66556008)(6636002)(1076003)(5660300002)(8936002)(66476007)(66946007)(6486002)(7696005)(86362001)(36756003)(956004)(52116002)(2906002)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ozwwZGw14zNgnc7Q4QRpaqWetkdNia24NR3NWtoPD7TPU5A62Kems70nc7uAkgj8y7t15o3tIWoSedTc34/EqNnCngZtvZYgw5vDf+9x6jNonE4wMW+nIHo+e6cxdNdaGxkSCuoNs8TuRaqyKgThZEreVUKMtxBipPDW6l++vkYKmkIDY5rtLVUX3qS5l7Eq00FdUwsMdN1zCgWDU7pMCVyyZ6IkClbNmLtJXqpDcxzEuT9UfWaxO/oNtK7FGnbc1HtYEBM/Q8pSsoMpg0vCVV02BUU0eq2LTDGSyI17HEHcl/4j+GIUYM1R/MBO4gGZHUe7UzWdin0SOWZKzFYO/gOoOIEkWFX06ajHW+XMgsgMbRMPva483dYvnFq8+bmCbeQgqybjWJ3nQP8x6AwqsVFE+fwjaQIqQi2T0lpBVzD/OdgorqSzvPkd583zCouhZ/01aPSflBOji9MsVyP0Nhrz2p9ZdSDeU11nQSjuB/dChQIMw0FkemjNSetu2YmA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef4c406-123c-4a95-2a83-08d81a2a4dc7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 23:40:27.0251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QoWPg+KLf6oz1g461VvaI8jPcUteXXV+znllJm07f/8cgMQ52HRDLqAch5T5DFnbShiiiO4prsMaKHX8/EXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The correct way to implement the fops->poll callback uses EPOLL* macros.

For reference see also:
commit a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")
commit 7a163b2195cd ("unify {de,}mangle_poll(), get rid of kernel-side POLL...")

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 73b753a11ae9 ("drm/amdkfd: Provide SMI events watch")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index f3782627407f..7b348bf9df21 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -59,13 +59,14 @@ static const struct file_operations kfd_smi_ev_fops = {
 static __poll_t kfd_smi_ev_poll(struct file *filep,
 				struct poll_table_struct *wait)
 {
-	__poll_t mask;
 	struct kfd_smi_client *client = filep->private_data;
+	__poll_t mask = 0;
 
 	poll_wait(filep, &client->wait_queue, wait);
 
 	spin_lock(&client->lock);
-	mask = kfifo_is_empty(&client->fifo) ? 0 : POLLIN | POLLRDNORM;
+	if (!kfifo_is_empty(&client->fifo))
+		mask = EPOLLIN | EPOLLRDNORM;
 	spin_unlock(&client->lock);
 
 	return mask;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
