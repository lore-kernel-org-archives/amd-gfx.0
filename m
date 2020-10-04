Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4526CC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0347D206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3GNEAGUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0347D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83D289E47;
	Sun,  4 Oct 2020 17:20:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FF389E47
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0gozg4AisTTOMwur6M86zQGX4q/wx5It3Km60Ur5EygkpgZTUic1EnjYh6QDG7/iqQB42e5MuObhNH3Jdm854uCScT3FFmrQhbpuVF/kDLHF/AnbqnftDaOx4cj9t64PfDM0mLkTcULEFfGtfCXQ2g6s3c9c2zo4+n5XvjgZU/xJkEafCMxswLrHfMDuQCgcf6YzGINewmm/d81gnMfJbPfEE2Nzx2pcmzQnm5ST/VPRM5CasnL4nbkqkMSS5W7a+vlUBj36jF1rcHjowaYeYXD+we1bAwcaZ494mQn0rVrsV05FmZ07FX1bP22u9hDaSyhNAKCNeh4HlzGs7pL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTui5SNiEZAC0ov3ct7gcAtsAuZkNYNRXN1fsIMOXeQ=;
 b=ng0hFqJQcECQ1B+OxRZnEfHkELscMTgSRZYY1hOZgN2pyq94X37bnwF2PL2DvM6//B7jQmtLfTgy4gTj3sSuqO6KZoJGu5WT9+yfA2iHt9D41vWsvsA+2BxYJgsr+Wxbd4xWpqFA7sj3Pu3XzNZ2W6WeHjoHkKxsmPHtSNX328VIpW5jDFuGNxf1o6fU+61ic/fYWhiZ0GoSQBHOOr6CarelvVePZmILIMtCWFdR7ThSBVy7BQCyi2ixMisxjsQYq1WjNcDIPI93JYhjCVlJi1DdBYccjjl12RQsflFnpvhonq9BloKgDXEDk/9t+x2hXNq1if51TN3jsiEpOXTdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTui5SNiEZAC0ov3ct7gcAtsAuZkNYNRXN1fsIMOXeQ=;
 b=3GNEAGUhqdYl4wkMKOKNP+cNi0tjiCr6HjtGppQoDRpah6wf53DuuiTKhKjNbKpI2Z4SID5lGmQPwBRwXNBd5Xo1F+B+qCI/xCIQEELuXyydkcOF5KqLD09yKlE/haHiuHqRUO52Y0qLPAxTPX8Fwn8l4st7qbskhlEXlYHXNrY=
Received: from DM6PR02CA0065.namprd02.prod.outlook.com (2603:10b6:5:177::42)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Sun, 4 Oct
 2020 17:20:00 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::49) by DM6PR02CA0065.outlook.office365.com
 (2603:10b6:5:177::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:59 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:58 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:53 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/18] drm/amd/display: FreeSync not active near lower bound
 of non-LFC monitor range
Date: Sun, 4 Oct 2020 13:18:07 -0400
Message-ID: <20201004171813.7819-13-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af308997-3df9-4808-483f-08d86889b99d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4506:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4506914F62C81426F24DE432E50F0@MW3PR12MB4506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rf6pUtJymYutYFPZQtUHKnAbVhUr7pcdzDZKL3bh5+robvlnBGkaVoIWCpBtPKcQ7vfNdScD4HopxS8diHp4Ycyo1wtkWpPzTpB399CbJzkizahB4dJbVqAy2J0Tg6L0HyJfH5ij7U0t7OFfKmUwRMZX5FKw/kxh2e/QH/CsBXnLZ+N6pgYYZTJhHocI439OZzK1gnfTZ/5nsnyM6VhSaBhOk+Vto1iiyumnRTIDeHoOdb4Q1luBOT8tgCvtalZpW0b8lfrlMVaECLd/XYCpTLZCOmQiIIOcc6p2qtMdpJmr8iUv1z7t9Duc/L425xdyI7GUne34IfwDyahB2F+DlBmv5MfJ73CKSy0+rLJ5zkgVEr7n82nhy+6vIvZfmyiJrznlfzGnYoomn9z8NPIJCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(46966005)(186003)(82310400003)(6916009)(36756003)(70586007)(70206006)(44832011)(478600001)(8936002)(83380400001)(6666004)(86362001)(5660300002)(26005)(8676002)(336012)(4326008)(47076004)(82740400003)(426003)(81166007)(1076003)(356005)(2906002)(2616005)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:00.5916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af308997-3df9-4808-483f-08d86889b99d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
On narrow range monitors without LFC, a margin prevents good utilization
of the available range.

[How]
Decrease the margin for exiting fixed mode and fix the frame counter to
reset if a non-consecutive render is found.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/modules/freesync/freesync.c    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index f76d31451dcb..52c3cb6b439a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -42,10 +42,10 @@
 /* Threshold to change BTR multiplier (to avoid frequent changes) */
 #define BTR_DRIFT_MARGIN 2000
 /* Threshold to exit fixed refresh rate */
-#define FIXED_REFRESH_EXIT_MARGIN_IN_HZ 4
+#define FIXED_REFRESH_EXIT_MARGIN_IN_HZ 1
 /* Number of consecutive frames to check before entering/exiting fixed refresh */
 #define FIXED_REFRESH_ENTER_FRAME_COUNT 5
-#define FIXED_REFRESH_EXIT_FRAME_COUNT 5
+#define FIXED_REFRESH_EXIT_FRAME_COUNT 10
 
 struct core_freesync {
 	struct mod_freesync public;
@@ -420,7 +420,8 @@ static void apply_fixed_refresh(struct core_freesync *core_freesync,
 				in_out_vrr->fixed.target_refresh_in_uhz = 0;
 				update = true;
 			}
-		}
+		} else
+			in_out_vrr->fixed.frame_counter = 0;
 	} else if (last_render_time_in_us > max_render_time_in_us) {
 		/* Enter Fixed Refresh mode */
 		if (!in_out_vrr->fixed.fixed_active) {
@@ -434,7 +435,8 @@ static void apply_fixed_refresh(struct core_freesync *core_freesync,
 						in_out_vrr->max_refresh_in_uhz;
 				update = true;
 			}
-		}
+		} else
+			in_out_vrr->fixed.frame_counter = 0;
 	}
 
 	if (update) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
