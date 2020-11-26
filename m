Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D32C56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12442206B7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bq0PAJIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12442206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9F66E55C;
	Thu, 26 Nov 2020 04:22:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFF06E55C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 04:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNg4/vfHGtiJ5jw3Mmcd+dfkuLPHleUKVqwJBBUmLWPCSTccDBpn3cYSqOxt1C/6Xexaz170q5mIeKhFjtGGkqXWaNeHqnA9gpBZCIGbwJgxLWFiKk5sJJl5GuMxUVjH9LFYX3UtBEJh6TzlnRYfWul/WVyqr4gWkbcf83lr2+A55cCLrypF3AvA9ycqe96t03cCMLb0pNp5uBlf1C7iDBfLyjHD3cW3GUusECyTxadIMYLvIwAzPuCt6flYHirzaza57y1iodAGS7nFHZwupWNbuCr3vXxUJdTVjE107lwivMGZScUI27nDTzEil3oAzRVQ8p5yLnQLBIv0/LXxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYsYFF8SNpVZ/G4ivDwBypOSaFlichwam4yWGAK1vrs=;
 b=Yz4cuYI2KH9kNU46inaqpsFVoNQ5ufrJOm7Q9pP5tqP1EjMTVEvxjlzOpc/v6MQk0Jx975agXIUN6EzB8LEAOYiIdAE2ALg23x7N0oIN4XAv1cxMB8xNXn9fuhWu3L6KUAA8+rfwJJ8bGj9roTrxSBSz9Lm1EafeUbukKHylReU4xY0BOAvn4b12qGea3VgZGWFXA3Tz0sU60PjYyKGJpsTMV/hVBwLI2Q6scxGDk4yOK+UUj/VFebbKlyPB9iVvISlesrGMAlJybEbO3h4cpn5/mfFbKExFwIzAfJvemeJeCS1URX4Uk1ehS7n6BpTpgzH62YVvpMNbVNfvHAVgcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYsYFF8SNpVZ/G4ivDwBypOSaFlichwam4yWGAK1vrs=;
 b=Bq0PAJIHJa4XoNC8Mipt56tuapiPzTVa7pztolooP6ngCV8Ahwi9y/NUL6ihMnYToBQHUBPeYa8GvaxbiA26Qd7QPhppMPBAB/PBaWV7JdcKZ89ZVIoM1f/5YQPkhhZFs/bhWy3ic8xFOrFp/stEkT9pc618mn3ORigery6EVlI=
Received: from CO2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:102:2::21)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 26 Nov
 2020 04:22:10 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::2c) by CO2PR05CA0053.outlook.office365.com
 (2603:10b6:102:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6 via Frontend
 Transport; Thu, 26 Nov 2020 04:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Thu, 26 Nov 2020 04:22:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 25 Nov
 2020 22:22:09 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 25 Nov
 2020 22:22:09 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 25 Nov 2020 22:22:08 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Date: Thu, 26 Nov 2020 12:21:56 +0800
Message-ID: <20201126042156.10883-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43592e0-e7ad-465b-aac7-08d891c2d7f7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25399739421D3FFED5B70BCCEAF90@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugWlLtSRz51FFFAbaJW19tkCMCe8jEepgavbP+IO9qhhaXIeXMCV7Ah1GhkWG6d/ff6cmmoBgd40DnU3L5fwZ3xPwR4meVtAhnWSQj/1SbBlZxJ2h9hAKl902dFc2biKrCZCEn9s075dwCYlp6/o7Hy349v9YxwxEDQvcjSp9vbfv1urq8JJ3b1P0LwwB+a6htMoMXaKHow+SSOnqd1wv1vweWMSbdiCuQ065sXqGroPmHxG2NEvn1DW4GNU2f1N7KfgvvVZJ4QX4sVaaHN38GVNw1dQ6bVYPxmbPSb51Jtnuxh/dX4ZFLKQh/YKhFQroZSRrxZGfLnJG/JIffIq7h7HKJJcQWfrFcj2DiLrmLNH0eA4qwzNOVOSQH8jVMDceiWdMrDFN7qLprMeqD1/cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966005)(186003)(86362001)(81166007)(336012)(6666004)(70586007)(1076003)(26005)(70206006)(7696005)(82740400003)(4744005)(36756003)(82310400003)(2616005)(316002)(478600001)(8936002)(426003)(47076004)(83380400001)(356005)(6916009)(8676002)(5660300002)(4326008)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 04:22:10.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43592e0-e7ad-465b-aac7-08d891c2d7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's in accordance with pmfw 65.18.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ia96b6bf276f4a99a931a1203e3314a2ff407e924
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index eff396c7a281..78eb99962bab 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
