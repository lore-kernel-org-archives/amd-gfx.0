Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10ED2083E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mKBgxw6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10ED2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA0C6FA3D;
	Thu, 30 Jan 2020 22:29:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770083.outbound.protection.outlook.com [40.107.77.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD1C6FA3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijMc9H/wK9d6J7QTZYacIpOe5LcLO6ChTtJ3ZCw0lOeTVgO9Aa2xRuYmqyknwhhGHTBayBJEMZ6oW15XIm3vn/7Kz8SQfLQIOe8pbOSm2H9qe81ZcavfQhI55+W3a0BkLIpWYFKtGMlRrsYPXQI/q0ytlNicK846m46yUos8WI3YrSUaPS9MnUxDec7ZXlrdM+cTxMPBFmw5ZKtgbitj517f/z6Fgsv4T3yXOq4dF6rp/wQsvyw136WNe932W4GJg05YXcMjpYZN5oUipUInmDV/8BgAnRzebR8xCB3lt++iwD28A04GTvgToePG6Mme5xg+3F/3TIPLElql9TzdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvIztgMwYd8tIiUr/ZaGNr1pJTVavzgN/JUDOLyyxek=;
 b=SdNpkjm9kD4VSAG/oOHU/c7i7CK4Xt8eC5VYRLahm3yp1HVEBftIzBAis+kofMq5Pm0II355Izx8rqRk0QkgMlh8EoFhZbt6+idP8FzBAnPdI3QtqHZMlcKHNpfcpkmMOda5d75Twfp7XgSe/yMsz9nokFCrp0BnY/89EKOJGsxAhb9PuQ2pD6IU/NQCuLy9ys0byQlNB+zuT8gCHHyFS8wU+6heZ8zbnnwnxT0sjkGjXmKQ0ZDrNzJWbRsDWDmrDsYsI4EEhlgTEjSAUMxDQ/PzZUU7sZKpmVKJU5Mc33+g7k0NJ97iFMW5f8uagfurrT85KfHX515Fr8HDq3cmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvIztgMwYd8tIiUr/ZaGNr1pJTVavzgN/JUDOLyyxek=;
 b=mKBgxw6SKlaY50hL/OzP/puNTO7PeoU/EXk8ypU/6gVkr1IUlYY6cUF7BA60qpt3gy7d/1ZNOqT7w+iVVuXra6xjE5e2FPpMRNufLUtWy2QYwgekX8kurNiy9VjIrBjYBuZHspI4TiClNCWaHj+CcxKE52OeOTHeh5PK4YBHrSQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 22:29:23 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 22:29:22 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Fix a bug in SDMA RLC queue counting under HWS
 mode
Date: Thu, 30 Jan 2020 17:29:08 -0500
Message-Id: <20200130222908.1403-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Thu, 30 Jan 2020 22:29:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f628c2d-d173-4d02-1531-08d7a5d3dafc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4182:|CH2PR12MB4182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41829249F74769DE6E0C35E3F0040@CH2PR12MB4182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(86362001)(66476007)(956004)(2616005)(66556008)(52116002)(7696005)(66946007)(316002)(6666004)(8936002)(1076003)(6916009)(6486002)(5660300002)(81156014)(8676002)(81166006)(4326008)(186003)(36756003)(16526019)(478600001)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4182;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEcCzMDwyxvh65x6ZyKlbZy7GftANsvRofaQ5qpbzbRvGQp70b1wfven0AGnpIHDc85IQ1+DCtldw2V2yBeB5NrjCDqS+CT+EDKJQTAsdFx6M/vOMKEdI/xVX9UkzQrkStD/JcJ2Bhebgk1AvdUlMeJoat8XRdLI+1MAOLcQMjm4NDk+tSPMfKzp4cVzT6w981UcrqrrXt4jpVtgTamCr9SI1Exh6V9qM96E3bWBRDTu75iO8Yqd+HTuDzZW9X5pXqeM9ByjooKLj/pIiJibUYk1b9aT5jJVJlfbQM78lmD5pn6f7cRBJ0bLzxctBd2hyJGTC4tBSllCG8qTdHnlg7wjXjk/DWeMMkhxxCAfet6yCdqRidpGGqociLfD3zLFU791OxMDG/6aLZmc/0gcrwib4GjbzdZiNhDRaEe9hXaLE87EpRMNNt4nf0gNwPZ5
X-MS-Exchange-AntiSpam-MessageData: Vrm70x2ftgV601l1mKlAUHqxCBJh97dTyp8cvzCHiScnlcPA0jm26EZ9LO3KYkrRY/FB8RnA49Vu2kFcQmPMIJMYqUvFv9tgCg0xtIu5GE9n0/nB1qFA36eZPWB0BeNfC3mJy6E5zYpSbPW66q23bQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f628c2d-d173-4d02-1531-08d7a5d3dafc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 22:29:22.8629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 284l4gD+bhXO0svxAAhZ6ZZJa6C0P9m0VWByB7Uu5dmUCrSH9w43Ymx79jAl947y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The sdma_queue_count increment should be done before
execute_queues_cpsch(), which calls pm_calc_rlib_size() where
sdma_queue_count is used to calculate whether over_subscription is
triggered.

With the previous code, when a SDMA queue is created,
compute_queue_count in pm_calc_rlib_size() is one more than the
actual compute queue number, because the queue_count has been
incremented while sdma_queue_count has not. This patch fixes that.

Change-Id: I20353e657efd505353d0dd9f7eb2fab5085e7202
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2870553a2ce0..80d22bf702e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1237,16 +1237,18 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
+
+	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
+		dqm->sdma_queue_count++;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
+		dqm->xgmi_sdma_queue_count++;
+
 	if (q->properties.is_active) {
 		dqm->queue_count++;
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	}
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
 	/*
 	 * Unconditionally increment this counter, regardless of the queue's
 	 * type or whether the queue is active.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
