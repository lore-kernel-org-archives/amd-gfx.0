Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37EFC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 10:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C7B2070A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 10:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="01FfRrgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C7B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF4B6ECC2;
	Fri,  6 Mar 2020 10:14:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1A06ECC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 10:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z//7EcPKthXIoyzIG+7odFJr7BYaLLOajMlzsoXsviH1cC0remolYeUEky+w7CxrjneViXn5yf1VOUCN4bGBNuO0au8ysn5n5a5idwCsBQI1RhbmCWXA2puW8h2MauU0xmHOW1yj0eeSfp9mWF7eAZ1+S5U262kOM2Wpoa5LPK4HZyiOxdP3poO6Dd6HMdegHwobPdRnCj+3fkSHQKd7OWPC6MMc1qAZWum9hM9w9xFUwZQojSepRsG+/YP5968BsStbe9zxDFyFgp5cdZbiwHhwZn4NrOliUUTVW2x/WNfe/uqoSu+TJYyL0acm29XpZKP1AM73IJ/9fTOu2ppfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJKnWpSeNn71LIgB4svZx9Li6tq349fAwOZHMHdtptI=;
 b=k9iTpcx9r3xRRRUaDVm/vSLpKN2o8caMWzH/tdTZqSCWW5UEsFBUgtSAMHCkJkufr3zAe8Q4M34cTtWIX7GqcnPO2M3AhJDv1kryCFsZtTlOwg6jrR36oKImZitI3vkM8wHFFh8OOUkdDO72QTeM9nas1OK7LOnq+JeOx50hXK0EceTiI2XUZPL9ky+Bq7VIXPsUOtjS1ewXr1+ulrs0rDLAk+xrCHbiRz8HsFnNrkr5Ce6iHsMdmBULzvNpGKdLmPtzxhN/WwkYjaXYhACyP0sFZ9WmCqU0ofcy9Lsh8Ntzpdbk8K1k4S+Bf5z7UmjsZlYDiBKs+SljomBCt/stFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJKnWpSeNn71LIgB4svZx9Li6tq349fAwOZHMHdtptI=;
 b=01FfRrgf2Y5PL9tm43E1UbAbzmlEbGqNcXnenKmYvIkLl9zeWTy/lje5qondfqUC2VgTxBZJlwi2QWCZTx8PBQHH+W13Pwt4f2jTaiPfzhuA/wsQs7Q2O85DZLNiITXzlVBgMyA/KLu5+Bqb6x9W1olI6wPzK6EUWXx/0PXJ4hY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 10:14:20 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 10:14:20 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: bump the NAVI10 smu-driver if version
Date: Fri,  6 Mar 2020 18:14:00 +0800
Message-Id: <20200306101400.4659-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 10:14:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa7e2965-8165-47a9-1582-08d7c1b7227e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3421:|MN2PR12MB3421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3421AB7C3ACF510E327978EAE4E30@MN2PR12MB3421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(36756003)(6916009)(4744005)(26005)(316002)(186003)(16526019)(478600001)(2906002)(6486002)(44832011)(956004)(8936002)(2616005)(1076003)(66946007)(5660300002)(4326008)(6666004)(7696005)(52116002)(66556008)(8676002)(66476007)(86362001)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3421;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 208iKxIJ0NOgDJL5mRqtBDowRGVpVwBBVTn8FrpSoX6qJkRyKrEoJFT7Gg9VTlhQlHd/x8gqwbuUD27981+ha98r8gl4LVVRzdBDkeMk4362QF021Pifh4EY6lhRnRMz1DW/RIDqK+TzKOXM/oNZeoihJJH0HqyNv5rUTytB9twWf/VfO7S2UGU1SJTEisx8So9nsStF5ZhO0kbEAjhsJqcoJ6mRmWXPKKSv7kZ9vuwIFzKSL2SvChKx+bfcFbBDe8b2Y/+dfu5lbqpRuWjK1JGodlWzh9LTrjLNMA9PpPHRgS10jPcuIbNy9kJoPtsymBoBNPBa+p2sp+ZBINklR1iTD8vrxGAbU9zalD7bX1ef4Jee6pc1Wq7fYP2AMw5gGGynbfIrMt3HhiBnxAQBu2Ft8n1p73s5gLaOqBl8pUk4TQgcDi4kFG0R61aRCoM4
X-MS-Exchange-AntiSpam-MessageData: 6vPDm2QQcO2DvnFNGkOZnLLgllI54QpCwjCi5D/X5z6lMm+3kiJVlrRyh0soBQ7UkTQ+W2IZ1PuRvnZJKESQStv4xRttFNuHakcrF4EvaHXVkgFER+Drpfmg/rz9MAkE8q7U6jogCTZ9quZUnoLOLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7e2965-8165-47a9-1582-08d7c1b7227e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 10:14:20.1816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XygrOuRvIFNT7ikxpbVfndm0IPEO5/wr0veFkshRr2G6vRcDppJ67uQosJdHjnHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3421
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest SMC firmware 53.27 and eliminate the
warning on driver loading.

Change-Id: I3f524d03e53ec6778b7118ef72652a538eec4ace
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 3dc25a14ccc3..c030feb160f7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,7 +28,7 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x12
-#define SMU11_DRIVER_IF_VERSION_NV10 0x35
+#define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 
 /* MP Apertures */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
