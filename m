Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9454C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C8D6069E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80C8D6069E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E3E6EE5E;
	Thu, 29 Jul 2021 20:37:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C886EE5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3mM/NgTaqMotFnnTFkYJ4JrCvfZh8y3qZmP+gNORpH0GBTd7t3UbMDVdeT0iJ1VI1f12IwAdlZBiL8GoZy6RjZk9ddQt18nGj655GA8upl0TaQlRPDygSajdUd4/NWRUsHYy82PMdQZod52FKpWZY/yhTYakzme7ixJ8MTetsOpF4Aiwt+mD4Yr6kb0qqL4yITRaVjRt2nPrdSX0GYPUoMwZhv2iWD8hGHUX+0B/Ca/plRXIO7bmR5Bl7phwm/ZTMDgnGh3vj+LTMr036ia9PdLMN4yPcblKwIpm1Tw91MnmKYpGkrMV3776iQma3cjVcurBK/xdO0rRK9uoccCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TecV4w4DpEY4g5Hra8gMiNTfpMc80DqowONuYrYk4dM=;
 b=HMzj5JxILUbfaE/hujX1U1x80yWqjltYbabFTQc7gfm2h7raIM7aYGFrDh6yLrGvYLIqJ37z6QwMwiwrWVypw/JoILYaxC7gEIL7qar9btSc6oPalz3G58ZOAhFnxKdsEWYm5Nj8HkibLXDcws2gcPIEGJeAZWfexjB7G0ycSo7EpTkBkxZzJlPuOToMMDl1orN6AUTK7RPvCLxewo22sXByei5KwDBtnjoHoqGlq5tgBFugG3SR5xT0S6CbsIHynirtNSaWvHjM82L7WLGvII1NbOyX3x+fDD1/7Utnnc/q39D1EuArbeAzonMlVolniFGB21PDeBFBHpTmZsDDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TecV4w4DpEY4g5Hra8gMiNTfpMc80DqowONuYrYk4dM=;
 b=tZf4BtoRND3p3mVOBS3v9ps5YM5SZ5uFcIYX3D2WhzNCWkuRobyCDkBgJcHOSZTMM1t/s71/U7LmZ7ZrCohSm3KD5UbXJamzjzObwllJQtLk37FBoZGiy2k93ZAA558h7CLAZLgt4uD8opN5b+kK7XuICevd63lCKA9/s+Bk1lI=
Received: from BN9PR03CA0190.namprd03.prod.outlook.com (2603:10b6:408:f9::15)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 20:37:21 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::57) by BN9PR03CA0190.outlook.office365.com
 (2603:10b6:408:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:20 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amd/display: Increase stutter watermark for dcn303
Date: Thu, 29 Jul 2021 16:37:06 -0400
Message-ID: <20210729203712.1566129-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60a01cc4-592a-47d3-d258-08d952d0aa47
X-MS-TrafficTypeDiagnostic: DM6PR12MB4169:
X-Microsoft-Antispam-PRVS: <DM6PR12MB416915284B3D9825668B27D58BEB9@DM6PR12MB4169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EnWtuKxV9XWQyDExa5OxkUSno1cpBPRPr0Ml0DBM+d4T74oWYfNRZXDSIbcd02/4JdX9Vo5EyFOzUWBMnPvsYQXkMAjtlYADMy29usuHfm0J4WCvCq28Zr/iwDaTH7A1VK7JDTtF+/7L2aTkOfmEV3wx92fBWD25BkKkHg4IBs9P6kOxREm2v2r7cNNt3gpv6vh+PiFO+x80MzNppCCVCBfBgBBOINQZ4j/BWkw3hll1a0r4f5DEioVtTBZfOcKELRMCsPtAra5qQSyYw4g8QhCzz4zqCAXPYFacMTLeU2LSa9smOPS5cMdRjEbI13eRy4JZlwWyGQERNuv4J8qLO1ytjupspMfH9ucqO49GCGF5sZgt1iA3ZGO4+a3gfPXxULjfly4R77pzLl2ZlMlvPOtJJuaUKo97L+lDVyKYx0wqcgTyZ6hQXJHM+L2UIE6R2Fh5L9mHPqRVxkvvusBinZcERirVG8VuokBn63RlANb0HMpMVKi6UaDZIsB2le3koGn/qA992JcX/cqqlGJD8QXYudxd0MOcwx93VpS3fdfGnjrGg4N3ZykObx7NwGSEIkNDy6TIyBevAM23F7tVbcNvUF1FqahiSWsL8/K1V4DE8SIjdfrvA1MLrer4JLIqzY+iDiDM/ESRByCU7One0CM1GnPOshRQF2+wheYk9xjL2tPdoqgPX/6mBV3LPV9boeXwopxQlbsTy/vxJ56805Nu869F3BiiHE8pl/VAog=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(316002)(82310400003)(2906002)(336012)(6666004)(44832011)(186003)(7696005)(478600001)(26005)(36860700001)(54906003)(4326008)(47076005)(86362001)(83380400001)(6916009)(70206006)(426003)(82740400003)(2616005)(5660300002)(356005)(1076003)(8936002)(36756003)(8676002)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:21.2714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a01cc4-592a-47d3-d258-08d952d0aa47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Martin Leung <martin.leung@amd.com>,
 Bing Guo <Bing.Guo@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bing Guo <bing.guo@amd.com>

[Why&How]
Hardware team suggested to use SRExitTime= 35.5us as w/a to prevent
underflow in certain modes.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Bing Guo <Bing.Guo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 833ab13fa834..dc7823d23ba8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -146,8 +146,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 26.5,
-		.sr_enter_plus_exit_time_us = 31,
+		.sr_exit_time_us = 35.5,
+		.sr_enter_plus_exit_time_us = 40,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
 		.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
