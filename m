Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1C7C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1AE10E4DD;
	Wed,  2 Nov 2022 16:03:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1861F10E4DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ0nXrT/ldePfgu4rts/uS221//E8Md/Sy5IsIv4xPFX+S84ijhlrMXAoL1NgeS23BLwrPldnAkL+/1Y0ZCR9XWg4yGeBYSdHebNQTF1FlMQMDOLkSszFI51hmvldrMvXWsLcw2NLienbaVgeJPA0pnkWLozw19gGu7sEUPfToJ/46ktgiuD/qFn5H7Ia45/xIGgMQs52Uct3Nn0MjYJy581htb/u2Vqz/pv+3OlLKqCJ41r/2148Yb+kQkZ2mvU5NQyVe8jCxrWWSFYTV0JrV/ccxQMkUqTWoa15+2jqIXqTEg/vrS0hiLJfMY0m08+mBOQ2Wx40HlkqkCFq+voBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr2kj7+6hwlRLbdWngP2OK/2q7ony3Azj+JkzkYV9zE=;
 b=k0naEHk1FrhwXuXc5hV5AlYrqrP3qVhDHOvCguBCLkpmnRb/SlzEscWrOspTeMsREriLkCS720Ytqi7PsqYxapB7If6v1wHVsDCKS5zfiYYaSvWunYCKDpkebBI2cQpsAdYV3uA9jGFU24FVfNszrhbSCYfNC+7clzSloCll52cSEF004Qrwq7d9xd9RurjeTe7G99FeciixV2AwhEFpNBKy0dcNe0TRoaDomZsRUn/MKtAWjAy9lwsxZYe8mMmu34Tczn9lzKZenGekLNo8seyYfZZF3BKzCRz2rCHSxReeZn1VGZ8i68q3Lh1d6YEB8haBONgKWehGMovz3ioKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr2kj7+6hwlRLbdWngP2OK/2q7ony3Azj+JkzkYV9zE=;
 b=o0IZvxsmbr+0JEP3iHt/jGHbjFRuzQtULsu6waz6OzSbqovgTpFM287xQ9BVjOOV14pHBQi34MuvqmGAse3DsM0rcsHIo8lwflwuzsfuW1ay0SntI4N6BF9eViYUfppGPi4jppNA3kDdVcQHjCMiPZ0njNEknYx1NbEXQfuX+pM=
Received: from DS7PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:3b5::34)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 16:03:11 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::f) by DS7PR03CA0059.outlook.office365.com
 (2603:10b6:5:3b5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:08 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:04 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/22] drm/amd/display: Update 709 gamma to 2.222 as stated in
 the standerd
Date: Thu, 3 Nov 2022 00:00:59 +0800
Message-ID: <20221102160117.506511-5-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d875fe-3847-48a7-7d2e-08dabcebbd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBgspV4MoQwWc73vCPEABlzn71V4KhcrkF7K5ReBVP57sDu58xhJxA95jYswwRcbkRsdYzUMHP03GNtnfEnHlIDTYOldzT502xhXSixGNnD3AEJN/o/sT0nANnGf5fdO8qjs2ZprU2lXQPU4gwKhFsdQMTDgj79ACMINOzM9Sxpgr//gvsn/vr05sML638tTSLR0IndsdQs50lNnL2/FVwsZ3V3CjAzFElSYqtyKlACd78Vw7WzbYs8IoBxXj/3965Kjlsf3EYH/txQjcq4elv1ft/iB+6c1cLBPIHLS1mLe2IkkZ0uAPR5sZhUiSSvDo0NPWtXxRlkOCf74vOfi3hMDYWusPaNikovTGjBb1HUACvryQraju5MTZ0yK5xMymg0Q2jXI4iHyuMK7ss62xx/Qva6Y5SVh2y+0gIHEM1iAmrecJaqe8ubPySZo1FLDNw8uSPF48+b7gcbXrriaDi5Mcgz+wnZnNy+g9zqPLPmZ+5QqyjVxm39WHosADPMdwAksbDFqvXgU5q4acvvgb6p63LHuhowjM5yuGaP8HFAP3EWOpMP8bhfR4zuBCpOwdSug1pIveXyQnyJQ/vkoeylpgZBmLDQMUbC/EWCM/+HRgiAd7g8XjxUZaWIJMJXkF5fB8wPxHFLZtIyzoUhrkL6DeLuivXLsfTzInmDQq7NX7F/mqMe4jqPM4ZmQgClgKcOfCYrjtCbl4QcICc2K7BmhsT5c3StVC0vuEjFQBkbewwIycC0iviQg/inFTsrnC5dqD6yby5AV+aFmTfhYAKuVy989IJtEwSQFfqSmSpcD1oRxRmhgAXldaphFojmW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(36756003)(40480700001)(6916009)(82740400003)(336012)(36860700001)(356005)(5660300002)(6666004)(2906002)(81166007)(70586007)(86362001)(426003)(47076005)(83380400001)(2616005)(478600001)(54906003)(40460700003)(26005)(1076003)(70206006)(316002)(41300700001)(8936002)(7696005)(4326008)(82310400005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:10.7011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d875fe-3847-48a7-7d2e-08dabcebbd70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Nawwar Ali <nawwar.ali@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nawwar Ali <nawwar.ali@amd.com>

[WHY]
    Previously driver use gamma 2.2 for 709 color space,
    but the standard is to use gamma of 2.222

[HOW]
    Change it gamma to 2.222

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nawwar Ali <nawwar.ali@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 447a0ec9cbe2..f6034213c700 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -61,7 +61,7 @@ static const int32_t numerator01[] = { 31308,   180000, 0,  0,  0};
 static const int32_t numerator02[] = { 12920,   4500,   0,  0,  0};
 static const int32_t numerator03[] = { 55,      99,     0,  0,  0};
 static const int32_t numerator04[] = { 55,      99,     0,  0,  0};
-static const int32_t numerator05[] = { 2400,    2200,   2200, 2400, 2600};
+static const int32_t numerator05[] = { 2400,    2222,   2200, 2400, 2600};
 
 /* one-time setup of X points */
 void setup_x_points_distribution(void)
-- 
2.25.1

