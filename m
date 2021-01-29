Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46BFC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5779764E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5779764E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C906EC22;
	Fri, 29 Jan 2021 21:28:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56486EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecV+OC0vZAfrHYiUx1LClTbrQPIBUCxhQsDpwhkMl2qDrWrSMU2LzL4Vzqx6t3h5cecjGbGFd3G5hwKu58y79FKwFN6M5pBmBDgi3pGdH39QzoKRvrpk44XMEhSUVvIuGTFvJaG007rQY5qmD0SYatobA5h7JzTjD+/9brT6v58+vtMA/vj+P1nQ/gcB4pSLADMi+O8oJKdMCTlv7MLnrg6M6KIxJewHUebG8eLhPQASgce+iWa4yD+je4CrsJFtLTEms/dZxFOn4qHMBALzQie3Pd6zL6V6quXrBGPYxUJ6/zeS/nqm0OatSmRUeCIIxP/lQ3ji4WpFYStW0suTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrNGa28/unt6FxTV59+V4FZYDadfqUB69rXRPR3gmPw=;
 b=KaQLcWUl+bMguvxkXOmZQ/RiZLaFDgMd72nyj2cgWy1zmH6zkRBo8TPRnr1w5Yl2Hmr8UtuByJDF4nOX20bQiA64plUvMq0etwerqA9ujZi0scEUYWgPWN6b6UZGLj9m+ovji7E4lWqy263xyZjdgkeHwVVpa/t16xu89H/a71q5MfnAX7Xc4BHF8aDJSTa7OSu6vemZjdtm2jl/87pz1YGirfyMIzmyeIyQS+z7B7h93gi6viW3v7o0Uoft4cNBwmAJ1Odojdo8rFz9nCB/bPoNEtnIBLZ8mXWFBLd+Rgw2rUe6cLC0TUHR1ieS6sBK5yJTu6blgFf/uiG89Jpl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrNGa28/unt6FxTV59+V4FZYDadfqUB69rXRPR3gmPw=;
 b=P6e4gmqsnFvGn6ifA6vPfbfbfnhKRAJKcrTrHpcekNEAIfvbYi3inJQlbBiFCxyV/mThBRQQVBPa8IzTQwQyxiKy8v08e68l8MY4tvw4QdnNtiCQXm9X/9AhkyzNH1aiGki6ElSKkw4qheGtJ4/xmyHikrI0I4ZZeY6+lsoBUow=
Received: from BN6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:405:6f::20)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 21:28:08 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::99) by BN6PR03CA0082.outlook.office365.com
 (2603:10b6:405:6f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:05 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:04 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/27] drm/amd/display: Set power_gated to true for seamless
 boot pipe init
Date: Fri, 29 Jan 2021 16:27:31 -0500
Message-ID: <20210129212752.38865-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2004f8a7-fc7e-41f8-ef7b-08d8c49cc49b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40485A67255251A6CD349B81EBB99@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoOXcaDHKn5K6QR0gYGWUmH+dR89UCnIc27eFhhVcFE5aam4RPahym81QSJy0KlZwlOID4MqVez1dAYp4WpnBhXddKu39FKK/MBkaw8jNAjJvaxIssorORmSl3wC0tuE3Lee5mcq+cgThmQ0WopfQY1hr9DAL0gqBT9SDg+tn9RRAgRwerxcfh9cEZcVbXBIiKfhqydgJM/gmcVG/8jyGTwcznxV0FDdJTzRJGgPm33V4Qjj3u/K4as+xOVdvOFpHry4e7Qz7uQg09BsPIbx7qylrMRy0L/li+e+IdMkn+RumRGLHxphtFXiUXQYd6zgc/FcKUtKd8xhiVJ11Nwm3/uybByaJPDn7ti8V6MQs7PA+3xsMZ4ixPMRo3iJXIsec2LXhRNwIvgfByaFSQ8SOSsSmZYKdR9GGfazAy+DMdgkMRG/e8gr+LCoYtJxbZfXAGOxqkV7UbwGJ8Gu4d7VwLtekxLOX/xfw54ZW1217a3WYUUR8j0xnZvo5B11k1SH+sDxy3YcxBj0LSoTy9cQ7B8nsK9WVVVqgjHla+R3ArWHnAbxaS377MtfQnOM6ruFWuSEBPVdVtMxoNMEpZgwR/PtfadbVzSCtZY4NYrFsDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(26005)(82310400003)(5660300002)(336012)(7696005)(316002)(86362001)(4326008)(186003)(426003)(1076003)(70206006)(54906003)(2616005)(47076005)(8676002)(36756003)(8936002)(478600001)(70586007)(356005)(6666004)(6916009)(81166007)(83380400001)(82740400003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:06.4971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2004f8a7-fc7e-41f8-ef7b-08d8c49cc49b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
In seamless boot without a flip case, the flag power_gated didn't
get cleared when resetting path mode because the plane_state is null.
The following sequence will cause this issue:
    1. OS call set mode to clone/extended
    2. Reset path mode to remove edp

[How]
Set power gated default to true in seamless boot pipe

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 7a30d1d9b535..2f315a47b765 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1224,6 +1224,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 			// signals when OTG blanked. This is to prevent pipe from
 			// requesting data while in PSR.
 			tg->funcs->tg_init(tg);
+			hubp->power_gated = true;
 			continue;
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
