Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5FDC43332
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614BC2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="coC6iE4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614BC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF406E1A4;
	Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534426E186
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hom76zdPpEJPSNmNWGjBP1n0l6TtkGYynvE2Ol/W+eRQr/dF89xN4hihLtp9jwnTGqznTtVGEJiK8FPBxamiMXWPmwynSCLzEey3mtkypGZurxxCkkSOsZ5oHXhUsjBft5oFF9wjyobLjcaQHuLkXLo2YQp1LOJrOkgcFblC+eF4Ie3veFZ7nuw8wg3TrZsaio0DV3Bj0jHUcXXQc7+YtOsaK5buT2rCyOaZJ9ZCjN25c+tHxiqL9rgShRQuD5WGr/vzc2qdxr5WhwXDV3lsCNmtYHGu5/iyxnifHcG4kxlZqiGmmbDXOMKo8KmBbVi94yiqIEV7ipMGa5kQqD52RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luoYO/r8I5RV4/B2eiSUn5pFkUG0TYsXL0TyJss1d9Q=;
 b=JZnNTmKA3WhgckC840mz1bSs88j+2nIBZrRyBCmUbBYjV+Dz0YyIozjicwYD+i2vpa927Cb1mBqGCnexAJ8Eo+0liXrSf2lJJs5fivnutvw9GWfGD5QVx/B43WAgFSmnK5GDpzDJ0f4UCGUvZw48kuqSUnUCXrfWxYbFBQKKTEsqUs8ahGxbW6XXAKPh6i0VMkGyeaXmbZ/0eO9xo1o9tffWyL6v2RoXwhqCYUls0yXuMW6MM2si4WyXKvdDBbg0coqPw4Vc2DPSavBG7rauE21GZgJp5bOtQK8QPi+E+saVXpK4F6WUSTXsPrHQfs7pBlCa3jGHI/YeZRvAGWC/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luoYO/r8I5RV4/B2eiSUn5pFkUG0TYsXL0TyJss1d9Q=;
 b=coC6iE4fKBG1JyluLU8LgWBLzufLj7YixwzQdSXrfify+FdcTOSDI0MxRjAZnJTow2PpzP+hMcBqHB0LwJrpU31dzxl+ALFXpNwgcz4t35uDxENgXEHAVvxjA9qIQmVi4bWXe8i/v/2LPbubiYOoTQ+I/TzbxX8XVW3OG94qgQc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:54 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/12] drm/amd/display: LFC not working on 2.0x range monitors
Date: Fri, 20 Mar 2020 11:11:25 -0400
Message-Id: <20200320151128.2039940-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:53 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15246317-8a7f-49f2-976d-08d7cce1062e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572ED6DFB0146C15E16488198F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1+ofanvnIvtuAyPWgtG+2iOypZkBew/8dvjnL5RtklTZPKX40INYxd4/rIXP4zif9B2xFhWgHb1wKAyzxaO4U18exxVCyTtYjMYN47X7tIyg9O144jcsC3uMKzoI8Cmhc+ig0lIMsbGJ13/uMMQwxxPdDcJ9R9gsn4Ym30kZqHQZiU6zHA8EvZqh4H8wbc91X0CSMNnkwFGUCyMOcxkMHZv1bUgOkI4FaGHrSZz3X9lMUsCZGC0kHlnHowo7f/UkwUZU4alRgbkvSb0ZmRb0LKwcnzNeVAN70Dk/HlcYHssazy4fpPl806F/MNH6/xvRSUAdLseQmU2KGvBXqMGlPk+KBzRZqKJ28NOSqzMvOmFy/TssW6kwFPz4w4XxaSadrGMTKE+1CQPBM3iSrdAnXoY9IMnE5Xgth75t4HGOz9tveRc2nfQN/okM8H4bUsI
X-MS-Exchange-AntiSpam-MessageData: 8JJiGt31m3c9E51exLKe2NzmYYGSERYozHwz1zpGP2SVXSjFrH90Gmk5+s8Y8FX3DqLKVyTFfYtAfouGlJQ4VoBGrws3wdysqaqc4J5KwjmhPJ5JRwHjMqNvOBs85IatJ1Tzg4on8OjjTcTtzrgCxc9+hLvLabiufPCzOYOLtdc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15246317-8a7f-49f2-976d-08d7cce1062e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:54.1118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl7cGGGIDPKuRxelKwkeRnI3UU9b6sPhiPb2E8hDcGYg0+a49AVzJmJ/ANVzBHUW6uuAEy5o3J0U7OiaZu1y7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Nominal pixel clock and EDID information differ in precision so although
monitor reports maximum refresh is 2x minimum, LFC was not being
enabled.

[How]
Use minimum refresh rate as nominal/2 when EDID dictates that min
refresh = max refresh/2.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 4e542826cd26..8911f01671aa 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -734,6 +734,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 {
 	struct core_freesync *core_freesync = NULL;
 	unsigned long long nominal_field_rate_in_uhz = 0;
+	unsigned long long rounded_nominal_in_uhz = 0;
 	unsigned int refresh_range = 0;
 	unsigned long long min_refresh_in_uhz = 0;
 	unsigned long long max_refresh_in_uhz = 0;
@@ -750,17 +751,20 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	min_refresh_in_uhz = in_config->min_refresh_in_uhz;
 	max_refresh_in_uhz = in_config->max_refresh_in_uhz;
 
-	// Don't allow min > max
-	if (min_refresh_in_uhz > max_refresh_in_uhz)
-		min_refresh_in_uhz = max_refresh_in_uhz;
-
 	// Full range may be larger than current video timing, so cap at nominal
 	if (max_refresh_in_uhz > nominal_field_rate_in_uhz)
 		max_refresh_in_uhz = nominal_field_rate_in_uhz;
 
 	// Full range may be larger than current video timing, so cap at nominal
-	if (min_refresh_in_uhz > nominal_field_rate_in_uhz)
-		min_refresh_in_uhz = nominal_field_rate_in_uhz;
+	if (min_refresh_in_uhz > max_refresh_in_uhz)
+		min_refresh_in_uhz = max_refresh_in_uhz;
+
+	// If a monitor reports exactly max refresh of 2x of min, enforce it on nominal
+	rounded_nominal_in_uhz =
+			((nominal_field_rate_in_uhz + 50000) / 100000) * 100000;
+	if (in_config->max_refresh_in_uhz == (2 * in_config->min_refresh_in_uhz) &&
+		in_config->max_refresh_in_uhz == rounded_nominal_in_uhz)
+		min_refresh_in_uhz = nominal_field_rate_in_uhz / 2;
 
 	if (!vrr_settings_require_update(core_freesync,
 			in_config, (unsigned int)min_refresh_in_uhz, (unsigned int)max_refresh_in_uhz,
@@ -792,11 +796,6 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		refresh_range = in_out_vrr->max_refresh_in_uhz -
 				in_out_vrr->min_refresh_in_uhz;
 
-		in_out_vrr->btr.margin_in_us = in_out_vrr->max_duration_in_us -
-				2 * in_out_vrr->min_duration_in_us;
-		if (in_out_vrr->btr.margin_in_us > BTR_MAX_MARGIN)
-			in_out_vrr->btr.margin_in_us = BTR_MAX_MARGIN;
-
 		in_out_vrr->supported = true;
 	}
 
@@ -804,9 +803,14 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 
 	in_out_vrr->btr.btr_enabled = in_config->btr;
 
-	if (in_out_vrr->max_refresh_in_uhz <
-			2 * in_out_vrr->min_refresh_in_uhz)
+	if (in_out_vrr->max_refresh_in_uhz < (2 * in_out_vrr->min_refresh_in_uhz))
 		in_out_vrr->btr.btr_enabled = false;
+	else {
+		in_out_vrr->btr.margin_in_us = in_out_vrr->max_duration_in_us -
+				2 * in_out_vrr->min_duration_in_us;
+		if (in_out_vrr->btr.margin_in_us > BTR_MAX_MARGIN)
+			in_out_vrr->btr.margin_in_us = BTR_MAX_MARGIN;
+	}
 
 	in_out_vrr->btr.btr_active = false;
 	in_out_vrr->btr.inserted_duration_in_us = 0;
@@ -1008,8 +1012,8 @@ unsigned long long mod_freesync_calc_nominal_field_rate(
 	unsigned int total = stream->timing.h_total * stream->timing.v_total;
 
 	/* Calculate nominal field rate for stream, rounded up to nearest integer */
-	nominal_field_rate_in_uhz = stream->timing.pix_clk_100hz / 10;
-	nominal_field_rate_in_uhz *= 1000ULL * 1000ULL * 1000ULL;
+	nominal_field_rate_in_uhz = stream->timing.pix_clk_100hz;
+	nominal_field_rate_in_uhz *= 100000000ULL;
 
 	nominal_field_rate_in_uhz =	div_u64(nominal_field_rate_in_uhz, total);
 
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
