Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61783C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECF1222C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XDWd+UJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECF1222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E59F6E120;
	Tue, 20 Oct 2020 09:35:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680086.outbound.protection.outlook.com [40.107.68.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085D46E120
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 09:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBYGUy7FRD+VV4f81o4IF+yP8mY1LxhwaTISOuP6/dv1lKSc64HKKJYfmxjMKO+oygg94rdqh2TXNgtm9uuuAzbM1qNs1SxmadsfWlmhqkGcDSnnjkU1i9TEr6cUtABfAEngtk7S1P4AUhcwAp+NPKozruYqLarzAc+BQFCBwM7kMXiNh1Av/0e7HD+ip3MzfAO5eCt+lVwM2g20jJG4tDlTI9OA7oL4DYieRWHYYb7gut+R1Sj/iMqfjwt73hbZu/ufBtFW8y5NeGiK7JO3hV+cCoLZj+0qUTUvLRVimRjolBwYAcFdecJQ5/+JD06E8PBBJYI0u7qhIlXnccrL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpXXe0IbI2lB1tbvQXI5ShGp6xa0JvlqJV5R7tyHXO4=;
 b=Z1ocxIuqO76iLn4kGrGSYIDEcZoY3C+q0/o3mq1KOXVGX1d22N5/WTsqgQvBNycbUKCOzHv+gkIOZatitiDibGMkhb0iqk9ELnaOSwfX9hQ+rLhl/2lVV8BvEfJyH3OSFFvnUixmumNw29CEMN4efHGytw+3j8qn9MHVYc3Je6711bME9pafL9/ch7VgwThQaBWu5LIOjLL7cFSu67XBABAYjHV8ac42mk64MTbL3LzYLx0ytVDNN1WJHiwi5/hhNEDprFCoFyhw9LaHBjPyyoZAKPDoyQ615cJWVjjgLXLjZ3Y34Ne/N9IiQlMfc0YnpRyw+kfuW+Oel/o3opOI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpXXe0IbI2lB1tbvQXI5ShGp6xa0JvlqJV5R7tyHXO4=;
 b=XDWd+UJpQNg4d/ANkh2eUWj/nV92cw1qNRpHfUDGpAKUO4Kpjk6en1af+iPR5Myv4a9CQTmQGRc+d9d3l2mFbzL5u5CeMKve2sa3KFoJ6DeI5buowLFR5slYxAEUVm7RmNo4osX56k533Nd1h2rvkbQH3tdJZ0O8M5pMbBlaN5g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB4984.namprd12.prod.outlook.com (2603:10b6:a03:105::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Tue, 20 Oct
 2020 09:34:55 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3477.027; Tue, 20 Oct 2020
 09:34:55 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Date: Tue, 20 Oct 2020 17:34:42 +0800
Message-Id: <20201020093442.15802-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HK2PR04CA0054.apcprd04.prod.outlook.com (2603:1096:202:14::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Tue, 20 Oct 2020 09:34:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40cc5f36-fb6d-4205-d60e-08d874db6739
X-MS-TrafficTypeDiagnostic: BYAPR12MB4984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB498492AB82DCF050B90006F7B01F0@BYAPR12MB4984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUekFbcGoJ4gUMP6O+s8BfkP8LJqhCJFeHuN4FRc/EA+H/5vWzD1cK73s4T1R8xqxex+jyD9pCNIGQ7pn98a0QH2KWP3XMwBBu4F8FC0Aax0FxPu8W4zNSazlctxooKynDgmCfWn1nSc/bU+JQI6PWQ9a885Qu5gLwPOruwzwZ//UIMwnPKtPKZRgHGawBii0x9IYxUa7bsk/tr0sD2KlUeQuJqTXEeBohO270fOBa2w8dfZwtan7kppGMCV37MQ/2K7r35IhHu+eDWLT/jvZC1kU+YtfS02MeVBMaekExCWWefTAP1Jpi8zCifYwUBkg7/UXy4UW4tV3hjwB7oG9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(86362001)(26005)(478600001)(4744005)(66476007)(66556008)(66946007)(52116002)(5660300002)(7696005)(1076003)(956004)(83380400001)(2616005)(316002)(6486002)(8676002)(36756003)(186003)(8936002)(2906002)(6666004)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bcDExT0DDHb+ysxAwn6PLQ8XW4G96Iw6pfEoxdbNh8EdpzsJSpu/RkXp2Fa4+YAwqLDBMr12d8t/jc0w39a/14nlSWiL/42xJ+O7sbmWgHCepMqlbSv1P0+genLG3xyP086TEjO0IxppBFTvuPbhz0gloyxqivMFaDUIVNbPa36zjPUg7XeP5iScGK8zRgwgdAC+LZgVRI5iWK6EDRANymIpKES2WRY0sqF58lf9UCi1nWG7hm3He8Ekt8FGtOx/zg2e55bRn854n+qP526L9dfac5tg2vcS0h/cOtiDG+A1GYylTc0ufqYAwNTNANQE+Y/SFLDmxKgJBkJG74DR9ILizUqdw4NisaaOCXTQI3ddGv/v7avmpN7q5+69ZgbHs2vV1/rFCSuuoZvH23eEQ2jDS96I3ACHX857ZQ1qp97kxdu2UT7rKocQBlwFUDVzJ4aWCOhtjbvs41TnTCMx8i3s2QvNpSZnDKu3jUNdCN4ElZtFxV+IGnaYLUhdHALjbSwgQ9auxfBcc9Z0xfmxt0dSdudK28LNok8kgK5bhx6nY9bEeCmYjArfFMyhZJvk3/AkqVY9H+ByCmDvvrSqhQZg2TFOPFmj7R6AbLyjUxeo38lmVoI30i1B0f9DI4vFJEOkqjjQLsZTvwFlGwZBRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cc5f36-fb6d-4205-d60e-08d874db6739
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 09:34:55.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD6tVWsjuxrMbiK8sg/0pDLVxr49SHXeKeVTnRi6sHX/7fm+yx5bm2eCOIq2C/4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4984
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per PMFW 59.9.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 2fba050b3180..76c5b5d8ebbb 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x9
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xB
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
