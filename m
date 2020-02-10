Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E156C3B186
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 21:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3123F2070A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 21:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="idJdkIpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3123F2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8942D6E9F5;
	Mon, 10 Feb 2020 21:08:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F34806E9F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 21:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqghlPI/HDtSfTPPABLmmHGP2pLz2XmvgwERTX3f8iOLgU5GAdED2d2vhEEqEqjh6L2nxXTPiOHZJwuOj4ODMMcMZNBR2OziE4R8DHut8ELqEOgtQnj13R89V5ZrLPq0rmR74Csw7uhBkKuGosaLLEUSTqS/KIGO6NlkEb2CifGfyClK9h4Q4Yg81+qRICwQNzuXlRq9i/O+nui9zGhJwo/OgZAyR5Eygj6/Kd4taHsoh61bdrJCMNKq+8gEC/udE58A2ltC+oOQ5EOi0ouJvllsafCyTCOjr59krALi+70Q4vW3hpD/nKcx3wUNetdwhJ6ZrpeEnMHCSv0moa3w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+BD5TjryQgoSoOfe0CMtqIfYo138dlcqIYJHTQBDTQ=;
 b=YCF/T9o15+CZNeeqzROYy8ybd0EVm5SkqbAp3A5yLz0r0G1PAE2Ubc6sApjMqsiVRzLyo6iP7ZjJW/Psf/PVPYD7gPwazYBUvUKx6NBc4y1DSP/y9AnCkefDxe06H9eb2f58T4s7X5rdOovOIsTMl342eljcsMo3ZUsC7IuwTOToMoGN6DLrsxfI2S7O3wz8xPTfZM/nERVbdI+5pF3+F4SPCglmX/THshv4jJEWsQV9OJ16qtCD7fGps1r/4WZN36AadtOkPhCWACPKej+hqakhbb32DVgQ7t6AXKxmPnD612QQ8qa9+8vTfM4jlxWdx6nIapx1YURwNN2YGb3sYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+BD5TjryQgoSoOfe0CMtqIfYo138dlcqIYJHTQBDTQ=;
 b=idJdkIpA7+l095sCquJNzIEgtzKllWVyEdhO7OHkp1RGHVhs5uWpX7p3EVPOGcntXxlb638b+ygSU5KwpZzGLZi7ZaslkmfeNx4FTJdCuk0/mKNxuBMC2HIdccP3nznbvwFO9dAeCPdw+ydka5enbZdmUY1RpPfQ8s2hHtx78dw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from MWHPR1201MB2559.namprd12.prod.outlook.com (10.172.96.23) by
 MWHPR1201MB2510.namprd12.prod.outlook.com (10.172.100.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 21:08:55 +0000
Received: from MWHPR1201MB2559.namprd12.prod.outlook.com
 ([fe80::309f:f40a:a657:eeb6]) by MWHPR1201MB2559.namprd12.prod.outlook.com
 ([fe80::309f:f40a:a657:eeb6%6]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 21:08:55 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, zhan.liu@amd.com, Joseph.Gravenor@amd.com
Subject: [PATCH] drm/amd/display: Add aconnector condition check for dpcd read
Date: Mon, 10 Feb 2020 16:08:32 -0500
Message-Id: <20200210210832.2779-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To MWHPR1201MB2559.namprd12.prod.outlook.com
 (2603:10b6:300:e0::23)
MIME-Version: 1.0
Received: from ubuntu.localdomain (165.204.55.250) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Mon, 10 Feb 2020 21:08:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e5346e4-54e1-493f-6cb6-08d7ae6d6fde
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2510:|MWHPR1201MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB251083A779B389B5465B1BFE9E190@MWHPR1201MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(5660300002)(52116002)(66556008)(66476007)(66946007)(8676002)(6486002)(6512007)(81156014)(2906002)(81166006)(8936002)(6506007)(44832011)(478600001)(2616005)(36756003)(956004)(1076003)(86362001)(16526019)(186003)(316002)(6636002)(6666004)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB2510;
 H:MWHPR1201MB2559.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOmyqj7k/Cq1mfSva8wFxk9H0CMi5wl2m69LHWqR8S/VZqB50+G+2OprZ9ZaXQF+H84TgaH7DzCQPT/Oc8/oVlJyitS8xI7yUio2XKQV36F5rUa+n2krM0uSYvpiYAX+bJRcrz7hCZYNxpxdmGS2cyQNBh/yegk1Bz0X1RGXRTlbts44fBj5/MH+1OUuBYd1wLJSv9Hil0rX2uzGmdPC0/ioxpSR1GnKL5vUc6E1x/WqLNkH3J8h6Wpt1LFgqoublJR2h8nJDqN9pNwXXVENfvKvzkPyKNUpG2AezZFmAJacSosPvH+Jrgv07VMBf4+ufSQQpPiK4sCN0iqQ7+l30pRXWmge4swuEQhLlY+4NyyAUJKhwbZfOaoN09bqDQGCPBAdv3DCrxA2HTCc52WPdmCKKCMe07WDrJD5LoZG3CtF5KF6ob/x4YQELnH8EY6N
X-MS-Exchange-AntiSpam-MessageData: baqjAyz9d86rOUNIhNiM0yKoXMK2IRCIykYZI49hO6xkcpFl3Sa0eXhFrP9iYq7KGPj5zQ8AHYRvv+ddUgEtAMGdZm7G4QYEVBxUrMAKxrESAl/6CRV3P3iRIbgLmlLP3d9Qaw64COVdMqJa22x8UQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5346e4-54e1-493f-6cb6-08d7ae6d6fde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 21:08:55.0489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVXMi87BUF4NTvwRljq2mZOeqFfOThACpubf6G9PBnrHw/vLBYByBog5SiXjY+VX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2510
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
core_link_read_dpcd() will invoke dm_helpers_dp_read_dpcd(),
which needs to read dpcd info with the help of aconnector.
If aconnector (dc->links[i]->prev) is NULL, then dpcd status
 cannot be read.

As a result, dpcd read fails and a line of error will be
printed out in dmesg.log as:
"*ERROR* Failed to found connector for link!"

[How]
Make sure that aconnector (dc->links[i]->prev) is not NULL,
then read dpcd status.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 42fcfee2c31b..92e1574073fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1331,11 +1331,20 @@ void dcn10_init_hw(struct dc *dc)
 			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT) {
 				continue;
 			}
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				dp_receiver_power_ctrl(dc->links[i], false);
+
+			/*
+			 * core_link_read_dpcd() will invoke dm_helpers_dp_read_dpcd(),
+			 * which needs to read dpcd info with the help of aconnector.
+			 * If aconnector (dc->links[i]->prev) is NULL, then dpcd status
+			 * cannot be read.
+			 */
+			if (dc->links[i]->priv) {
+				/* if any of the displays are lit up turn them off */
+				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+								&dpcd_power_state, sizeof(dpcd_power_state));
+				if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+					dp_receiver_power_ctrl(dc->links[i], false);
+				}
 			}
 		}
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
