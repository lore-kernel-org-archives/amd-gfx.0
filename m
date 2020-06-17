Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AABC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58D12082F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kM6Gf83K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58D12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD766E914;
	Wed, 17 Jun 2020 22:01:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A126E914
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKbjjuTtjgtD/b/IOqyDdi+wv487DOnA5fUNHg4T4u9OljP/X6KzaiUzNCFlrivcZkLjs0HKWM0HF6IMJMG7/Mo3Ne2krIHPSrHfW+DxWmBe6J3ZwP2TAns3laRFOK1Pw+T8rjSoJGaNVhm0dqxeBERAYBe7GCO04lD/94YvBl46C0AVQYh7WPKQkprkV1GXeW6yYkLMKpFYMqUKDOcOo9d0z+cnMfyEFv6E1j8bC7dgDWHYnap8xWnrQ8t5rJ0Hg7+mMq0b+bWw2vDBYxKDWG+yY1rqk3O6BKpEENFCi3sD6aP2Iu6RxqqhPRyOUCfXSy0vHrwRPUIzE2nWGv01xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz7lLB2BsvbndBKDpmZC8ueb75bIGHyiDnJNpk0VxAQ=;
 b=MWz+bMCCw23a2lKjXskXkLTMEtaYeBNLAM+agRPzLL1kSDj1+JoyES0Va4rBDr8VsUPWARGFHCLQejBXIG5LRzbYHc4YgfUExkTAAz964Y/zdX2ysrIMgMWd/6t6kij6qWZr+g6Fxi3n3RDFt5YE6J5PnYy84/xflnyeDslliR5mdJB9VwUAwB+4NEeuOJ6T43FrN9Xz1EdUv5YwweO9mJyVRTy/nhjWFprpkXs1/8S5Uwai8KKWI1dEfzPmV7I2K+MbyPc1XJvY/ZVuMXdHh6bznajuVxKcuzrOHBWOzoMQh3wub7PAvjApi7MGSCJ6wshv3pIG/SSqjKL8aXTlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz7lLB2BsvbndBKDpmZC8ueb75bIGHyiDnJNpk0VxAQ=;
 b=kM6Gf83Kr0m4Ba8V1JfOYW8VmdNIe48MHJ08iHiHYEn7pMrcz9SikHOFnw3heMpbNzHWZ001+/zyDboLTqYDzgbjsNLUgbIAjO+HfHEZ1V2kxlvJqbUY2UKiXs3FyjN0z4iFqb78cK1yX2cwlD4TfdpmrOstSLnfZrGRWiHObOs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:00:59 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:00:59 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm amdgpu: SI UVD enable for Oland
Date: Wed, 17 Jun 2020 18:00:15 -0400
Message-Id: <20200617220016.4844-6-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
References: <20200617220016.4844-1-sonny.jiang@amd.com>
X-ClientProxiedBy: BN6PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:404:8c::31) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR07CA0021.namprd07.prod.outlook.com (2603:10b6:404:8c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17667b02-62e2-404f-d365-08d81309eae5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB018517A4B21B861E9633EEDEFD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQI1/xbigMvoZZkx5JPGdiAJxoTKQOA3LoOG/xUrdg5+AN87DJIZ+SBd6vuuYgyH0BFxgos1+/fqgQnP4wPvREVCNpS39UlMwriQDynWsYgJBejlhbMv5Gr7sq/htHedh9/JHNnpYaL6nsz3x2ZWpc+X3w0JjKK7Cd92SGUd9yRiI/RP18J8kGxDVY4jmAMgvMNCN64jov2unXlwbbY2mYI/9x9orO3fuYbJEJGzCN6uonmSjCXsJ0OyPrxz6N9nW5Ps35ObAXDNLf1WeKMf4hx5NjaCIqChrHJK++CK+3yMF8GNwvwBlRGHRGUPS4sbXtpeGMn3yD8GAfiqf6c2nOacpboAk8tYO5xoMisChxaii0GwnaEHtDe7gwAYA2pd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(86362001)(4744005)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(83380400001)(69590400007)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: S0KdqgIPyUqIr9sgWC1JhRDtZjSboVxm8G/qXtw+w85n1qu43kR8d27m0NIcP5+gARd/U9ZZ/xcg7J8Etkst+YEd7ljoW9j4vRulLeOsyNnmpq/ssEmafs5EaEOdFiEM/wjDMI/21DOQPLmtIrS0COnrw7TeVspWP8PwcsZ+7VsVNaNEyzZMITZOyE2U+jb3UYaF1MJZRpBkYgJlvUw+wjJSc5waUvnSS1rgcR987hhy00wf6vmsH4dQene3z/dwiNP/srZxMeqpYcSzYEX/2qwiPBn7q1uUN5uNqoDxy0x01RHe7c/Lc80xupuV4h3wiE25PyamwsmvwGxD8mtgXOhbDMPbN66HuYd8BYVRpcf/L2HrW9AKUFuxGofWLT9/GE7Urz15zajz70UjsWhY/gU+w5j60bzU+ofhYx1bdoOJ8i7Yz5nXESmvWIDdcCugLs261GUjN27WDJqOwtpXm8dCRdFHSr1sxHE+0UuRgdIyfWhg9DeoldXDf2TmsGvM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17667b02-62e2-404f-d365-08d81309eae5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:00:59.2227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DW8q+fCqLhGnWAaUyTcelWODhUHWvrhsoIj66orllf89h6VcMnhSqLTbwJDsKV6eyV0dLDtPVJ5LGPbCXBfHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/si.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index f1c33395e3fe..e21561fbfb82 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -41,6 +41,7 @@
 #include "si_dma.h"
 #include "dce_v6_0.h"
 #include "si.h"
+#include "uvd_v3_1.h"
 #include "dce_virtual.h"
 #include "gca/gfx_6_0_d.h"
 #include "oss/oss_1_0_d.h"
@@ -2209,8 +2210,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
-
-		/* amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block); */
+		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
 		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_HAINAN:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
