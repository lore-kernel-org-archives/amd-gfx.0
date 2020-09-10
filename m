Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12802C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6175E21941
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QJJgsRYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6175E21941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F006F6E175;
	Thu, 10 Sep 2020 18:54:48 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7A26E16F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 18:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhVM0MDVuMcyrFXCluNBzoBHRYIsm33A8il/583hXhe/iqm3Zd0HBuvAD40amen6z2MoO4mUANi7Uq7agyvz+pQFmGux5sYnx/Mo6cbtPGyLDQ50elcvheCPgfWeX9B1TXOpmwA16wx8osXp0jZqTfvpkHrZT6l+bt8UoAmhm2QlcN99Jv6mH4OR1Ngcb233tehhcafFtUUI5TXFIwTnkmBhn8iaCUQe5dRPoscqetxpUtEuWBiItB2Y1TAY2c+iq9vXU6CeMsJk1J6xQDIQQMN24t30oXeqrwZR95uRi273hbQf7HG/skCeRjrxSDqRAquOUIODcV7BdS7igsFarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLj3viQ6DrrBe+1zGk7aypeJg4ZR+qVlBP2s9fBIh/k=;
 b=UjPumOGrSlyS4riLJDlbk0vKenZlO8PrGeeQUlJI55BjHvtJcT7M4ea74nZ/TlLRLY2BzlsZ9rx3zppdzwAsZPOIb9drpA3rV+1Kg10RlLzvuJ4nwH1NH9oRCAkJxSH6X2CLZXKeHvROWNCjM0yuxN7j1FbUTPrFzq/O7FysdAOJ5LVWHjBjvV5nNJGlXCo6djU7mtOHVRybtT42jCQHNBK1fTsZ7t9d1TWxtL3fXgyu7R8e+MJjwf7C9M4u9TJ7m9E702jjmUYk48BUPRnM4XAissr+Q7tPZW0Or8Yspb+LV3nGYWgqlU6GcFRQL1zeeeTpg6N3krSaxO/lgg7WAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLj3viQ6DrrBe+1zGk7aypeJg4ZR+qVlBP2s9fBIh/k=;
 b=QJJgsRYS62GSr/XKGMImp/QjutI1pVYwAHc+R0We+qd7dgIbSypOZ5RaPnqbGfusl8lZ8HrmuYU6PH4XaGvcHojs03qSrbYUk/IkhcYv9MGksqTQ4Ma2r/lfX9R37AnfXNhFkPViEAkRM+ROTVxJI9CWydox7ELD61v59dWmEjY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) by
 DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 18:54:45 +0000
Received: from DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b]) by DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::8021:13d3:3dc5:e39b%2]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 18:54:45 +0000
From: Philip Cox <Philip.Cox@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdkfd: Reduce eviction/restore message levels
Date: Thu, 10 Sep 2020 14:54:29 -0400
Message-Id: <20200910185429.14011-3-Philip.Cox@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910185429.14011-1-Philip.Cox@amd.com>
References: <20200910185429.14011-1-Philip.Cox@amd.com>
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR12MB3404.namprd12.prod.outlook.com
 (2603:10b6:5:3a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pscox.amd.com (165.204.55.251) by
 YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:54:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64af4b79-4efc-49b9-48fd-08d855bafbda
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265A25564F7A33CA51F8B4283270@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZnq2Px+Vz48XgoA8SbwwZ6pIZftVIEgAExelTVT98xgR9cYrLt6CM4tJh98fGSQ1q4j6rtEbQyMZWXRoyTzUxOrGhinPFNqiBY7AlJQT0pCtdyAEsLItpswe2L8cDDU6+vkooOGiZJq+b19C1qxbiuHYpMVynSAgW1FH2yti/Rley0HDq6ujgMI0NddLGIimuck4I0Q3C4BxIfi6VrWRbYbsN3ggJZhWHLji/7cd3hcF9VzUSrbBv31uEtFL2Ck7JG32UPzwnMA+CSphQAyCq+BLL+DnDQuE10GUX4f6c030kSLk2KbxED5ht9lYiHhfMCgSXJ2j/n8uaVD4tmiOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(7696005)(26005)(8936002)(5660300002)(1076003)(36756003)(66476007)(956004)(66946007)(316002)(6486002)(2616005)(86362001)(6916009)(66556008)(478600001)(6666004)(8676002)(15650500001)(52116002)(16526019)(83380400001)(186003)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vYcesqcI4EAWdXDXNfPd2Euc4bi9D2+HSxA4Hda/il8jbBa/YSAC4vJk+ChhG7rm3vQIukGcF09XtHQvUztt0hGfja1cEaOMvTXsEZ5dRzKMapAtrhlMjna4/q7lkBUXQcnEHr/btogb7zU7c24IYl3zYfhJBrPKEf3Tvfxqkz/x/d7Jphyf9car3hp/i/nmOiy2FbYfi79Iy/tHGZRN6i/Jg5Vx1ugVpZ90MG8YHLNK+4Xlfp1Vt7MMBSV4pQyIBnQ7MhQDBM8otG2TRDJxOTlOYDgjtohamf02cCYUAzNqielFMFBnY/A01QFE2EPi7XVGNXzmSRDBAUuz2CIaqQGs4j5gmMWFQqP6g+Nv+9IVOESejcWlN5Zmf8auKR9LouZpMEtf8EypnuBvl+zUALT8BtjZIuYJrdOM86rG5edYhaeInmEdZQ80aiS3hURhKG9APII4eiTiQIGONdPy4MQgyOyDskaBJwLoE4DptKOjdZ7IgQqpCTJpEqjIDU/7XRdInY5+JY2DLxjq42yuXK8Sxi/YHxokef4d7k80WAgX0fLOotn1kUeHXnt2wN94FYiQvaOZtcpqpGbXn8jBAaVQCfnwUVpRCUfgm40fxbB9Th0TVxuWYkPGi//7bZfL5Uq3/aB79qwNAAXE0Cfs5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64af4b79-4efc-49b9-48fd-08d855bafbda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:54:45.3098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qODP93dDBIRops+uGdbRfeBcmZ9ex1MoPW76SEzkOZBg9cFh0nz8mBOqGrlOdMNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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
Cc: Philip Cox <Philip.Cox@amd.com>, Felix.Kuehling@amd.com, Tony.Tye@amd.com,
 Laurent.Morichetti@amd.com, Jonathan.Kim@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reduce the eviction and restore messages from INFO level to DEBUG level.

Signed-off-by: Philip Cox <Philip.Cox@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index cafbc3aa980a..0d2bb20b49b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -650,7 +650,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 		goto out;
 
 	pdd = qpd_to_pdd(qpd);
-	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
+	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
 	/* Mark all queues as evicted. Deactivate all active queues on
@@ -700,7 +700,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		goto out;
 
 	pdd = qpd_to_pdd(qpd);
-	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
+	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
 	/* Mark all queues as evicted. Deactivate all active queues on
@@ -746,7 +746,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		goto out;
 	}
 
-	pr_info_ratelimited("Restoring PASID 0x%x queues\n",
+	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
 	/* Update PD Base in QPD */
@@ -826,7 +826,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		goto out;
 	}
 
-	pr_info_ratelimited("Restoring PASID 0x%x queues\n",
+	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
 			    pdd->process->pasid);
 
 	/* Update PD Base in QPD */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
