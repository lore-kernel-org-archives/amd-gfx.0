Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE49AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A71206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vSkq710P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A71206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6175E6ECDB;
	Fri, 26 Jun 2020 16:19:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE356ECDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0zEEnXU1oKOvSbHhcPRNgXcjYGW9aOfV1bL393E3xlOGCsVQMd1ahSnk8tmV7AmK59IFYSMeeIPi6S81uchZXJ9AV+UNfwTR+8iHBjzMD9EEYGyA8AT/KxnrXP2GtYWmUC19wXtDe/Aec5MU9a90j9LIbcQilc0FuLltqnDm7bRvYiBwzK5BXg28qocuwoA77D1i6RRKFV3zDJjMVNQtxEUboIbMWbYy8XI+M3ZJ6o8tiBXRKl+fsvMdb0gqGMenuTsj5HbCAC5zoCPdLS+Z53ouKjebxBvCcki2fcaEA+eSeuCP/9KkBbeGB5Jb/SVoS92JR4Rw1u4WsiD6P31tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx5bhPOaKhRAL1VqEAEuzZtuxiEmE6X2tvL8bGotOX4=;
 b=I4/Yn4IELVMbybj7ZFCM0RMg4t7gia7jdaQqlSOLiscIy2H/HtgslepbdzNse+PS2AtEqZhTzneYHcNg+CnrOqnYC2NlPUvzi4ORHRO+5Iva+nawhY2ayOHrA6HUsT1uiu/iGkxDUVzT311p0bCuVqQ4oySWFtfaSVXLqngf6+KJAbZxdOgJqq3drwaYwsD3hrvIO1RFZRDue4kfL1Ib9+tQB2DvJOCHwjK/c6u3vR4ArbhBS3oIsnkt6SsdoTCSsT9HJLAxwds9hs69AovAVOvnfHaWNKTMY9U/Lf1p8534A1//ZNfpBnhI3rFTK8ZXZgT5qRNL5FRKICANU36ThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx5bhPOaKhRAL1VqEAEuzZtuxiEmE6X2tvL8bGotOX4=;
 b=vSkq710P+Ou3e55XfX2OZzu+9nF2BHINOOddKxQL+/x8sNUI449fQE5VgVcyoEZyLPgSFuIl2qvI3PrO2Ta96ILyi63InC1UTXlCQt5B8ytK+1zD81MY2D+0kGno81Ymd7uQrIjY8SP2Dd1fJ0dp5F+tCAE5T56SxK9pNh5Wv5g=
Received: from MWHPR15CA0025.namprd15.prod.outlook.com (2603:10b6:300:ad::11)
 by DM5PR12MB1915.namprd12.prod.outlook.com (2603:10b6:3:10c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 16:19:54 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::28) by MWHPR15CA0025.outlook.office365.com
 (2603:10b6:300:ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:52 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:51 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:51 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amd/display: Fix incorrect rounding for 10Hz
 refresh range
Date: Fri, 26 Jun 2020 12:18:43 -0400
Message-ID: <20200626161847.16000-8-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(82310400002)(54906003)(6916009)(2616005)(44832011)(478600001)(47076004)(336012)(36756003)(5660300002)(426003)(1076003)(86362001)(316002)(8676002)(81166007)(356005)(6666004)(70586007)(70206006)(2906002)(4326008)(82740400003)(83380400001)(186003)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e74774c-be2c-4f54-7177-08d819ecc2ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1915:
X-Microsoft-Antispam-PRVS: <DM5PR12MB19150C37C2B443DBAC547CA8E5930@DM5PR12MB1915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: np94vtZcLOX3mh2JyqnsNY7EIHdPErGS5lY7B6U3vFZOmD3SF2obRr0RXd5Flg/GOToNH8ShgxgDgocWDc9Wv1KzwfpIo6vwEYRqxIeOQntiPENh3JgSF8THVkYakRQCv8UzEZd5khBwnY56KL8Ta2PlUW1r5WEuAb3gzzH4MsSW8RNnEWklLX98pDawH8ayOyThMH1+w1gRcH3ZZDwPu/F9lL8jGK7xRF8xChATIaCvw39Z1gc38Jvd2DKSfnhBiIz/GFXh+UuHXY5DwnXna3z30DqmuM7IydQ1x59epXpfJKLuJrsZYR2Qou83i+dBbEPKMWVPMaL6jO6SMuGhcOMWEXvwk2eWJbrVJlRmW0HMduParqvdEss3Fpns+u9TjY+IWHIrH1u7R2VW7iY0SQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:54.0288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e74774c-be2c-4f54-7177-08d819ecc2ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, eryk.brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Jaehyun Chung <jaehyun.chung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
In cases where refresh range is slightly below 10, FreeSync is not
active or supported. Need to round values before checking refresh range
in order to have FreeSync supported in these cases.

[How]
Remove redundant values and round values before checking valid refresh range.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 35 +++++--------------
 .../amd/display/modules/inc/mod_freesync.h    |  7 ++--
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index eb7421e83b86..5ddfd6476ff9 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -32,7 +32,7 @@
 
 #define MOD_FREESYNC_MAX_CONCURRENT_STREAMS  32
 
-#define MIN_REFRESH_RANGE_IN_US 10000000
+#define MIN_REFRESH_RANGE 10
 /* Refresh rate ramp at a fixed rate of 65 Hz/second */
 #define STATIC_SCREEN_RAMP_DELTA_REFRESH_RATE_PER_FRAME ((1000 / 60) * 65)
 /* Number of elements in the render times cache array */
@@ -878,8 +878,8 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		else
 			in_out_vrr->fixed_refresh_in_uhz = 0;
 
-		refresh_range = in_out_vrr->max_refresh_in_uhz -
-				in_out_vrr->min_refresh_in_uhz;
+		refresh_range = div_u64(in_out_vrr->max_refresh_in_uhz + 500000, 1000000) -
++				div_u64(in_out_vrr->min_refresh_in_uhz + 500000, 1000000);
 
 		in_out_vrr->supported = true;
 	}
@@ -918,7 +918,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		in_out_vrr->adjust.v_total_min = stream->timing.v_total;
 		in_out_vrr->adjust.v_total_max = stream->timing.v_total;
 	} else if (in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE &&
-			refresh_range >= MIN_REFRESH_RANGE_IN_US) {
+			refresh_range >= MIN_REFRESH_RANGE) {
 
 		in_out_vrr->adjust.v_total_min =
 			calc_v_total_from_refresh(stream,
@@ -1105,16 +1105,10 @@ unsigned long long mod_freesync_calc_nominal_field_rate(
 	return nominal_field_rate_in_uhz;
 }
 
-bool mod_freesync_is_valid_range(struct mod_freesync *mod_freesync,
-		const struct dc_stream_state *stream,
-		uint32_t min_refresh_cap_in_uhz,
+bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 		uint32_t max_refresh_cap_in_uhz,
-		uint32_t min_refresh_request_in_uhz,
-		uint32_t max_refresh_request_in_uhz)
+		uint32_t nominal_field_rate_in_uhz) 
 {
-	/* Calculate nominal field rate for stream */
-	unsigned long long nominal_field_rate_in_uhz =
-			mod_freesync_calc_nominal_field_rate(stream);
 
 	/* Typically nominal refresh calculated can have some fractional part.
 	 * Allow for some rounding error of actual video timing by taking floor
@@ -1153,8 +1147,6 @@ bool mod_freesync_is_valid_range(struct mod_freesync *mod_freesync,
 			div_u64(nominal_field_rate_in_uhz + 500000, 1000000);
 	min_refresh_cap_in_uhz /= 1000000;
 	max_refresh_cap_in_uhz /= 1000000;
-	min_refresh_request_in_uhz /= 1000000;
-	max_refresh_request_in_uhz /= 1000000;
 
 	// Check nominal is within range
 	if (nominal_field_rate_in_uhz > max_refresh_cap_in_uhz ||
@@ -1165,23 +1157,12 @@ bool mod_freesync_is_valid_range(struct mod_freesync *mod_freesync,
 	if (nominal_field_rate_in_uhz < max_refresh_cap_in_uhz)
 		max_refresh_cap_in_uhz = nominal_field_rate_in_uhz;
 
-	// Don't allow min > max
-	if (min_refresh_request_in_uhz > max_refresh_request_in_uhz)
-		return false;
-
 	// Check min is within range
-	if (min_refresh_request_in_uhz > max_refresh_cap_in_uhz ||
-		min_refresh_request_in_uhz < min_refresh_cap_in_uhz)
-		return false;
-
-	// Check max is within range
-	if (max_refresh_request_in_uhz > max_refresh_cap_in_uhz ||
-		max_refresh_request_in_uhz < min_refresh_cap_in_uhz)
+	if (min_refresh_cap_in_uhz > max_refresh_cap_in_uhz)
 		return false;
 
 	// For variable range, check for at least 10 Hz range
-	if ((max_refresh_request_in_uhz != min_refresh_request_in_uhz) &&
-		(max_refresh_request_in_uhz - min_refresh_request_in_uhz < 10))
+	if (nominal_field_rate_in_uhz - min_refresh_cap_in_uhz < 10)
 		return false;
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 0ba3cf7f336a..c80fc10d732c 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -170,12 +170,9 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 unsigned long long mod_freesync_calc_nominal_field_rate(
 			const struct dc_stream_state *stream);
 
-bool mod_freesync_is_valid_range(struct mod_freesync *mod_freesync,
-		const struct dc_stream_state *stream,
-		uint32_t min_refresh_cap_in_uhz,
+bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 		uint32_t max_refresh_cap_in_uhz,
-		uint32_t min_refresh_request_in_uhz,
-		uint32_t max_refresh_request_in_uhz);
+		uint32_t nominal_field_rate_in_uhz);
 
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
