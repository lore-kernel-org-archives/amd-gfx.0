Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEBDC433E1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D92206B6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YB90dGRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D92206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9070B6E832;
	Wed,  5 Aug 2020 17:41:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680040.outbound.protection.outlook.com [40.107.68.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A326E832
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8Jd0b/b0/vSOaS9CFEyxjBDnJnPAfAX1XMb5iSYHyy0WhGL+QYRmG4Sc2sjpSFiLgRbtO8C0f174e8QXMgGIYx4ECT4ybGkWfmGtjyT/B6Biv3bLqOvOiQRMHCQPJjeFmFMt5tcKOb7L21TCDnUu3FEirjwxtjFrY2LsUMW9HkgN+bw1RYHUYO3c3+STWqQ1sN9J9CYuHBhT6+BJAm/e5f4SSrOm2KMX+g9RDXjPO7+5gl4NfjS3e6uNlO0jaQTHODxC4hpXaoCEetElRmbh6Phe5tNHBbir4kbuhXxITeIVWVJTumTtlrj3gmojmvgIrgWTn21RASL/uROM0oOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaCF5xQua7BGZ2dCLmPEJHXq5PLuhSNuHl6z0+pTXy0=;
 b=OxP/gO+xco6Zzi20ZpqSVHARwJprSVWRFaS0JE54+M3aPLCr3Ekip93y4/AK9e3uFpND8f3enpZ+gqwTcNKBYdzy2mqXi7C8OBfnj9VblJgCLgqdUGJxZYgeLSEHUI4WArbvAW7DBartfK+BQZie6BxrhLoQChhTZsYP5n7a+N1f/0UiLDamDpnQWRjjryZAUBEMBP7oEa2224X35WPDQKlNjO0EGIx7xsdfzwyFZtorGEAx84DqFB+6LeZgmNaEsluZiqRrpuAy+C6WP3aqixtVktbLL5eEwfU4ZgJ0IZusEaEkwXTelk2d1/IvHXc9ObtkQOr4Lg+p7lWYfayNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaCF5xQua7BGZ2dCLmPEJHXq5PLuhSNuHl6z0+pTXy0=;
 b=YB90dGRSxMVKxsN03lJLBqMqxxfaaXblz1ZkEAh/nPIAlsz9vZSDG6ax6OrAuSlOdZf6jFz4/6sP9a7YIyy1FQLFwP33GSoUfn9zYJxKwv7mK5mqitlCTgXqAijjIDTZECY55Mms5WfKekvz+vxlaGDF+VMIsheD6rfO0SQfhwM=
Received: from MWHPR02CA0006.namprd02.prod.outlook.com (2603:10b6:300:4b::16)
 by DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 17:41:09 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::ee) by MWHPR02CA0006.outlook.office365.com
 (2603:10b6:300:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:02 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:41:02 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amd/display: Fix LFC multiplier changing erratically
Date: Wed, 5 Aug 2020 13:40:54 -0400
Message-ID: <20200805174058.11736-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805174058.11736-1-qingqing.zhuo@amd.com>
References: <20200805174058.11736-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34243ca2-8745-4306-c6ca-08d83966bd05
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449F338B383B77CAD9FD649FB4B0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fgBeRjUqljb9TcmmXMTJCZEX1cmR59P6Bzs/LQlGL0dnzrSnky1Y4xtyrSQmp5aZmn0K+63QXRNQMGBAai8kidIBq55hh/YvteNmLMcSFXSC0eWQaMtcoj2hVL8SVWCwVq1w/c4tFMGtQIEeSVgKngQD6yNMoFkPUqKOyu/ZdfdUxMMeeQwNo3XdN91mNDLI5jSCSgqTa62VV1+ZXv4uhPXzwU3rut6FB9zH8FIXdqjQs+dcRwNt40HiozXCFessDr5WsVoiFqfwwJxoHRh31bYoQyLAUm/wdntV3PGqxXo8syWaTz34nVtmZIWiiVvR/6p+AJVZhOoqiT6MNU4ViwGVzUCooh+okNAkXGaZQuF9ZupXMJtIfRZdSr5cVaYUbz27IXy7KbltpceTektxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966005)(6666004)(8936002)(2616005)(2906002)(4326008)(44832011)(36756003)(426003)(82310400002)(83380400001)(8676002)(336012)(1076003)(81166007)(47076004)(356005)(86362001)(478600001)(6916009)(70586007)(70206006)(316002)(5660300002)(186003)(82740400003)(54906003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:09.1935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34243ca2-8745-4306-c6ca-08d83966bd05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
1. There is a calculation that is using frame_time_in_us instead of
last_render_time_in_us to calculate whether choosing an LFC multiplier
would cause the inserted frame duration to be outside of range.

2. We do not handle unsigned integer subtraction correctly and it underflows
to a really large value, which causes some logic errors.

[How]
1. Fix logic to calculate 'within range' using last_render_time_in_us
2. Split out delta_from_mid_point_delta_in_us calculation to ensure
we don't underflow and wrap around

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 81820f3d6b3b..d988533d4af5 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -324,22 +324,44 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 
 		/* Choose number of frames to insert based on how close it
 		 * can get to the mid point of the variable range.
+		 *  - Delta for CEIL: delta_from_mid_point_in_us_1
+		 *  - Delta for FLOOR: delta_from_mid_point_in_us_2
 		 */
-		if ((frame_time_in_us / mid_point_frames_ceil) > in_out_vrr->min_duration_in_us &&
-				(delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2 ||
-						mid_point_frames_floor < 2)) {
+		if ((last_render_time_in_us / mid_point_frames_ceil) < in_out_vrr->min_duration_in_us) {
+			/* Check for out of range.
+			 * If using CEIL produces a value that is out of range,
+			 * then we are forced to use FLOOR.
+			 */
+			frames_to_insert = mid_point_frames_floor;
+		} else if (mid_point_frames_floor < 2) {
+			/* Check if FLOOR would result in non-LFC. In this case
+			 * choose to use CEIL
+			 */
+			frames_to_insert = mid_point_frames_ceil;
+		} else if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+			/* If choosing CEIL results in a frame duration that is
+			 * closer to the mid point of the range.
+			 * Choose CEIL
+			 */
 			frames_to_insert = mid_point_frames_ceil;
-			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
-					delta_from_mid_point_in_us_1;
 		} else {
+			/* If choosing FLOOR results in a frame duration that is
+			 * closer to the mid point of the range.
+			 * Choose FLOOR
+			 */
 			frames_to_insert = mid_point_frames_floor;
-			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_1 -
-					delta_from_mid_point_in_us_2;
 		}
 
 		/* Prefer current frame multiplier when BTR is enabled unless it drifts
 		 * too far from the midpoint
 		 */
+		if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
+					delta_from_mid_point_in_us_1;
+		} else {
+			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_1 -
+					delta_from_mid_point_in_us_2;
+		}
 		if (in_out_vrr->btr.frames_to_insert != 0 &&
 				delta_from_mid_point_delta_in_us < BTR_DRIFT_MARGIN) {
 			if (((last_render_time_in_us / in_out_vrr->btr.frames_to_insert) <
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
