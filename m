Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E16C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4882622AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4882622AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053676EC71;
	Fri,  4 Dec 2020 21:30:32 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44B36EC7E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYepPyLAEswvTnWC4v21BP/L+BtMUtciSxSJT45Cfk3D63F4msC1a0MYAFF24KZUwrG2F53vllS2wnkYNFoD6lmre9+acjM7FWSlOPXK579IptCMyrlN8dppoO2zjjRD9dEQ+0fRW/OSuTMsIVIuDjGsSQLqiw+s4iandlz8KBJSkamN1J+fYW61KHuaF59maABMqIKASjtelpA1S9ZXpIBB37Pk9gNblw+17gDLyWHfcGfMlcNBmhSdILHWCkMT1e+c33jT648uTPe7BQDOJsyO0h1kjWFRy5GT1m4WI4QPQyuuS2zqwNHlRvkYpmOxFbgyNhEwJv/E+VcC4p/tEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dunnJ/chOa3JCWaJQ9PRbJqTqcBhBpJaasWZX5+AO8=;
 b=Lo5cS9D+rtfGg+eXBTKHILrAQuj2gzvncCK0lJOzE8Kq7Z2jpqV0P8g+djBe+gxNRzSOLvCQTCtSbBrIxJBQuo7gidTGfVWCEQZ+FGtRowa1OQGOATMuxm9kmRvm71VQOlUMXMJ2c/W/rxxvo0A7p6ZMaZcziGSiY94ymMkJw/1D1Y5geFQehvGxu5xu66Yj5+YnIOFYgUmA9GWyGRRO1YkZr+B/17ANm+NtT6hc/4bAeI3Cv3AwRnLKv/mdyH43TrZ5C9EhNw2uT2kY4uEgUMBn/GePmr1csEqGZ3gYexKeo6guRZffejPyX8RNNo2rmVIT/2E8dqmV1fRIvAzmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dunnJ/chOa3JCWaJQ9PRbJqTqcBhBpJaasWZX5+AO8=;
 b=rnyojKq2Mq+IfYHMfM6enaoQ4UwQZafbucyY2P0ov8pMhWBHqpJZYLUCJ+MBDcPwfH3AKxCBq5wfvyAXOfv6qO0bLCDz9Hbae9xp7dP/AZ364xEv0tKpKHElrubGhi1o3cKgUSWhBC7OtTHV1E/9PHnSBHnsuhQeEQWV+XNqygE=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 21:30:28 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::4d) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:24 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:24 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:19 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/17] drm/amd/display: Don't check seamless boot in power
 down HW by timeout
Date: Fri, 4 Dec 2020 16:28:40 -0500
Message-ID: <20201204212850.224596-8-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2da101-b967-43ab-1dbd-08d8989bd207
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:
X-Microsoft-Antispam-PRVS: <DM5PR12MB191682F8DC3FAAAE4FA68FFAE5F10@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: np+SwMVd6BnlvglDptWcAJ7vI7puW0WAqGgMkZz90O6+OodfaJ4RQndO0Ln4MWRAMteao8AwkoOviTrG90cGmHpFVhR5Y2/dJpaY71wGXf2oCmDaFv4m0OuE9zdgVPLKpKkbo2a4u4LWrUPaI0tj48/y6bVM2qPQZjo6AJyQuv9NeiqmwcN1edq23RXn05815Pk7+xdaF1q5VyZbFjtiAbtzdBbAVwqNx0GuSAsGuaz2SVPnzFE/ClOTDna9d3r5GrOb+SxwVNynYQoHNFLfzLL0Uu9U7DOABRq3Cfzmkz+sQlxHR68xkuQkmkqfPc2ICftZ245iBGROznlZZsK27DKLFhdCw2f82d7KGcvSeKJ0bSSS1E96c/kWAQo81JG+Llo0AHWmebzcRNKRFrBKaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(6916009)(426003)(4326008)(5660300002)(2616005)(83380400001)(2906002)(336012)(8936002)(82310400003)(70206006)(86362001)(478600001)(54906003)(70586007)(6666004)(316002)(36756003)(44832011)(8676002)(26005)(1076003)(356005)(81166007)(47076004)(186003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:28.3529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2da101-b967-43ab-1dbd-08d8989bd207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, John Wu <john.wu@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Wu <john.wu@amd.com>

[Why]
power_down_on_boot is designed to power down HW when set mode is not
called before timeout. It can happen in headless system or booting with
the display is output by non-AMD GPU only.
The function will be executed only if it's not seamless boot. So in
seamless boot, the HW is still on.
It's not necessary to check this since there's no display data in both
cases.

[How]
Remove seamless boot checking in power_down_on_boot.

Signed-off-by: John Wu <john.wu@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1e18f0bb40b6..9f7d6b087553 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1442,16 +1442,13 @@ void dcn10_init_hw(struct dc *dc)
 /* In headless boot cases, DIG may be turned
  * on which causes HW/SW discrepancies.
  * To avoid this, power down hardware on boot
- * if DIG is turned on and seamless boot not enabled
+ * if DIG is turned on
  */
 void dcn10_power_down_on_boot(struct dc *dc)
 {
 	int i = 0;
 	struct dc_link *edp_link;
 
-	if (!dc->config.power_down_display_on_boot)
-		return;
-
 	edp_link = get_edp_link(dc);
 	if (edp_link &&
 			edp_link->link_enc->funcs->is_dig_enabled &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
