Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD16ACCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 08:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F256F11333E;
	Thu, 30 Jun 2022 08:26:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24012113336
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 08:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEiJOMGvYcQQur+qh577DCkitiv3LO6YPTHoa3OUMoKd5yGKHJiIhOaBdu/g+N+KGXd44SJwvf2gkZD0HZCy9LdZ8EQdVZTih00LaEe1941HgXD5mm5YYF8jxKl5LPq72jS4xGKOCvp71cirUr1nieWJCr/9WA4CC/MwyVJcGm+Gh8lb/TRoA4ZKXxwTh2SIqGD+GwSgLCi94fMS7njae21igF5gCgdQaHoqAPDkXrdTgRkh8nrJWdAHKkkqnMAiVuBkDzU8pNNr5vknkxQH4euvFoV1K9k5ifciuq64JvlS6zU1LP8U4IhedFdyJ2ofsrPae1s+XgcQmfguTu5Kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnSVIkF41LHI6sab4tC9M6RH4nCSeypEjQsGFeKTDMk=;
 b=gclO5l2vvkTnbNscYPiN91O3/zpZmSQ2O68K58VXkQjw7KJw2AowhJGQYKDwVsRbC8boPVZV0axl/GF8L2o6yUptDWq+5cG1WJHp9HisrruVjNlbFVZ49SHNpOusZxQ/Nf8CD1aQFgshvwDTsi3eAka3n/iJa/0FkgWyFi19DAQLrSlstBZl37NuZVXGg/SesM3W0UbEwXEM5tvUqsgulIzR1eraB66HdFuyLz8RwX61xRYmMLaJtya6I+oH2sxzswlQpJI6eaDC9lnJBLXqBwNuRX9yWuJtDHJdcPcB5+634HxtXlDv1URddQmPXXYpFIFHxKdIBrG0arQ8CeVwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnSVIkF41LHI6sab4tC9M6RH4nCSeypEjQsGFeKTDMk=;
 b=35SCBYWkBwQpptOGlJw086u0JxVVcGRdpNO03sIS/cEeOM6vusNlRANDsLK9zQX/rCLNgvncpa0t14YvO+UTtbnzn/Uz4kUJ7SYZeAGTBloEL03X/lHIyL92KEHhZYj6SJa7s2GlTD/on0zaXGUdOW0/ponpUJYb3dAdZv40Vds=
Received: from DS7PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:3b5::8) by
 DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 08:26:41 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::4) by DS7PR03CA0033.outlook.office365.com
 (2603:10b6:5:3b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Thu, 30 Jun 2022 08:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 08:26:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 03:26:38 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header
Date: Thu, 30 Jun 2022 16:26:23 +0800
Message-ID: <20220630082623.28276-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5d0dca-c56f-4230-8390-08da5a724258
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gloBiJQ3rFdCn52jIs4ruvElaWfszRvVaeuhNrLR0jArYes9FgojlVF/1YT0tnv+7PNHVijhykxGdTVP1xS7EvHK2DHTLBCykPgtAZ4LjtmkEBY9sI0Rvb5A8bMXrgv2fll4yWjg3+HMqhiNqRhG+E9FL94E69NDXbQ3W5SMDNZ1JYi0ZSSOlSLezPzazeSM3UXQQVUyy3eAI+oDX574Ki4mvNcm9cuv1aGnvCZBSiwV2wz+C63Xf7eR/63THZkz7Jxic0+dAHD3P6OoPgatyEX7kYEPg0/jwE4TCLHC/2BvLAScFUd1PW4UAAQwozr9hJrZpI2vyqassyjjzwLj/4QUgqmCHEwZLduKMOKjScz+Cb//ZLXG41Nd6tkQLsNFo1b8R1/bX8Ay0sQZVChdsWXk1Rjoi4xUvg9xIgHtAT+JB0UBZqWNOgpzACmb6njLyYpg7LiswAcdUOpHuLBZCDoEDMiwf6ZqEtdNJHUzBUFbjczBtz/YBfJ+yxZZhhjy4WyFVBBtCSNoeDo2k5lw2Gn/lDYH0zvh3BgaMuZGKC5Yu5bm9+/KDbSJhz7UapDBJ7YoVGuEfDmog3bc3051rAZSRYdY1+N7IfKIzCiJkuMdD+4zvNRbsHXxUCg7O8TE7v9XRqA7SIXu5AqtDc8mV1EETnf0ujvNfhnaoGndXRmLkHBZDnqXtiNyXwLp/iRVaRhDcoWFHjz9TvWO+m06cidUC2XhxmQJx+3fOcY3DbhHT3bGFAmGywr+MGXAUkvqQdc2thduKqznxSw/psxFyznanv5iQCeq3CnljZi50+3NNMUhjR70/qK3RmFLuP4ggXJf9NYsKb5V8hwDh7/m246QQQG6AwZXerIBG2jMKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(81166007)(478600001)(44832011)(41300700001)(356005)(86362001)(186003)(83380400001)(40480700001)(2616005)(1076003)(82740400003)(2906002)(426003)(16526019)(8936002)(47076005)(5660300002)(336012)(8676002)(70586007)(36756003)(70206006)(4326008)(54906003)(6916009)(82310400005)(26005)(36860700001)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:26:41.1277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d0dca-c56f-4230-8390-08da5a724258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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
Cc: Alexander.Deucher@amd.com, likun.gao@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And bump the version to 0x2A.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I2b66b9a289177a979201fca2056ff11e0b81f2bb
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 6a817c7ce110..5becfc1bb2ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1041,7 +1041,8 @@ typedef struct {
   uint16_t        GfxclkFreqGfxUlv; // in MHz
   uint8_t         GfxIdlePadding2[2];
 
-  uint32_t        GfxoffSpare[16];
+  uint32_t        GfxOffEntryHysteresis;
+  uint32_t        GfxoffSpare[15];
 
   // GFX GPO
   uint32_t        GfxGpoSpare[16];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 7c0ca962cf28..3f12127f9c24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x29
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2A
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2A
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.29.0

