Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD914C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BCC2082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oNMAx3/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BCC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F926F97D;
	Wed,  5 Feb 2020 23:29:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3FB6F97D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSUHBI9kkBO56Ys+nxtBHzFUkkaacH4ObfhOsfDridG1orgIIrYazKqa8a5OHux1kLQUJoia3a26GffwtDJEck/SdrIBeLXg2gCi09svgpDUPuWm7Re7ZV9V27LjlhTaoN5PRLVHhuvwKK0SdpWaZgwJDNgbzyLUPI8DBh82K2avJvzlyGbM0wdHBuZiLSGD9wcRstok+wMcKo1YqccVhvykr30B3Z7MJmOwSCRDh2R/Yf3DGV4JybRYWmn+SfaQZnRaYkom8oWL7hg6GO1A1JnO2ps8l+lt6CR63B8dWe85jkmPaGjR2C0S2FeJTFACV3yxPKwEh5gxcj6c/MUTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neYqX5DAZFNMKaQJcp4N9yxiNDsn4fXXCuYxfgBQg4o=;
 b=OZyMTk6BRFH6SXOZC2hNCSUFIzJ1aiJIdL/73yKVdvRCF9dN56cSHzKiWzXhWqc7twxCjuKG8LZ7mYguJEVkzIxkSiYPSDH5rB5tX14w2r96VgKLOQs4C635a3HslQPtb8v+oZ+j7kqfWxDAQSFSh4Xt4EZD34oVJEhlh6L7pG/Ud2W3DU3wVOb/X8PBeTVhmMwzUF1fuxnP9RnjVb8DjNGf8E3LAlhrDa+YIcGT9IbHz667hnqZaohzyCQowqURAgHV/mnTGgkFG98clOou3ZhnwUM1MFka0naQ4m1/ftkaogvmjKVM6P9HkUAjKdFyxcuJTpN5ITqnSYuGx9H5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neYqX5DAZFNMKaQJcp4N9yxiNDsn4fXXCuYxfgBQg4o=;
 b=oNMAx3/t4tQJqUIFqcoNTvIMO0k59FuZQKiUHWgYE/Ho6dneOxRpSw3Ww5xWBq0u3aKIJw/DJy/S/3K6nfkTBy6xQAb4/uBsNgs8bnxEIObbza/tm3SpnSNhhTmPThpc7It4crEwsCsDAvkYVTgwPhyIg47l4wICQ0NRBT+6IsU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4072.namprd12.prod.outlook.com (10.141.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 23:29:37 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:29:37 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdkfd: Fix a memory leak in queue creation error
 handling
Date: Wed,  5 Feb 2020 18:28:30 -0500
Message-Id: <20200205232832.26226-4-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205232832.26226-1-Yong.Zhao@amd.com>
References: <20200205232832.26226-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 23:29:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec77efd1-974b-431f-1bc6-08d7aa9343c4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:|CH2PR12MB4072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072F9390B62F9BAC4346F25F0020@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(4326008)(2906002)(4744005)(6486002)(6666004)(66556008)(86362001)(478600001)(66476007)(8676002)(8936002)(81156014)(81166006)(66946007)(36756003)(5660300002)(316002)(186003)(2616005)(956004)(16526019)(26005)(1076003)(6916009)(7696005)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4072;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRCdX3pmfy4B/bBkKJKLPGlNXZ0ShwoYzOprINT3jKlWsBZZ4TmqpPpgkeL4YofksQqkpI3tCUC6JXCMq8QDeaITI8hY+wZqWedxkOQVBrXxi6tHpj0NB0Ge8Lbmby2/Ge1DhskF4031Asd4vPzzAaH7fY+4a9A+jRlRlSwtBhXUjNpGpJFeaxaJ5QJhkKFBnl7yFiwwVTdMR+gn3a9/0jCQLkaa1SB1Dh9u4aIlkfXm1UCalN5UBO9m+HFOAO/LYFGPrLeWE2PlaKK1p9+F/R+cIGM5yA5N14aJN58MHIRapqdVB0pzg1b/FF6V3h/QStSgpCVnhqUftGBqLBj/vYPgbNEeGKPKZytxOEtcDGoJfy/0vtzTzxIyQsQIKE4Od/Vo6YWZmZ4gvU/44BGaYjGK9ROd9SE2fh1k8bSWxf9iGC+QMN8vqUDiCQQ2tAcd
X-MS-Exchange-AntiSpam-MessageData: 8ZAeEJ8UFiHmAHMjeX1qZHGz7iKVxBJxI2ee1770gScuIngiON8ltZOpgPemLxP8e3dZd0ABlhSHzN9HBWv7U3AyUSyPVLzcCUWr/RgvAg2/DMz4oxHKlanzzyQSjAicqQyxVx88PWuLdMBzxPyEbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec77efd1-974b-431f-1bc6-08d7aa9343c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:29:37.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UpwDoe25DpvuyUaS+E/lOgKSqr4rPrRglFLvbSl/l859l+lJgZa4LN1gNVXqUT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

When the queue creation is failed, some resources were not freed. Fix it.

Change-Id: Ia24b6ad31528dceddfd4d1c58bb1d22c35d3eabf
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b62ee2e3344a..c604a2ede3f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -329,6 +329,9 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	return retval;
 
 err_create_queue:
+	uninit_queue(q);
+	if (kq)
+		kernel_queue_uninit(kq, false);
 	kfree(pqn);
 err_allocate_pqn:
 	/* check if queues list is empty unregister process from device */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
