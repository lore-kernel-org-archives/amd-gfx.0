Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9D9C3F68F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0591C2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aVhWY4VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0591C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E036EB7B;
	Wed, 11 Dec 2019 15:33:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6C36EB75
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O71DihsVGTtvYqFAElT9gSha8KsIzbc55Cr3SoCSnLFiZXy43+KcDYX05EZ/foV6S68/rL0ceL09T0rEQMBoLl3q5u4lwQ0r7azoq+sV2cRTSflvwCInf9fzFTHIxiR5CQ+Md37Bk17kN8N01PMTxq4NHsZH/t60Y1mjbl+EKaR1sF64l2FEZvDb87L+Kp35rEnVwnBWwHYQ3z6C1Wvx2qRGf5y1F00bqKgp5apqdN5pL7paOdD0dl83efuIKehI9Y7Vzftmq3rJ6L8ERKJerkRAS35TTE2JAMBnlTPf63M0QUUOy02tCXwFgSzJrpzdgcGSI2ZnO7arkSdMCkI5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXnnlcgR+LnEWCLOmj+hDSGzIVA85ucTCm0pkoJNBQ8=;
 b=CinKxrpxC9dCC+f3IN/PhFPPS/FFp/F29OOTh4RFQGwgctDi1NkPu36WykWB9tz20mUn/Bi68x58LJ8k/LpnPg5abJnXoedI4KYFN/kcGNkuZ6d5VG8b0s6xC/oywmBgO2G8ElwdqltwDN+myw8mTHa5di0/Nrh7WNqbTdbkhV+0WNVcTr/ndi/nqxUifTrgcca5YqX1KImvFuqRgfVsg2TWMxMSb3ZN08VqJ9g2sHdsUXXq9X9p/eHIAvBfqnKKZgmtp8Gz/kHyDfeJjTP+tyfssEPJ8qgoSMuGOoqBOJ1neRUvXiDeAasl++AG4TDNo3d7oj3JMSkpp1WozyU+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXnnlcgR+LnEWCLOmj+hDSGzIVA85ucTCm0pkoJNBQ8=;
 b=aVhWY4VMLF/e1qWUSxOJpevtETksiEB2qtcIVWNsUjltMwnluGimv4NQXsP+oBmPq6nlrUr/YavVfG0REr4Ncxd3v4HAZSnTH3mpi0O+dEP26O0LXvfDx5VqLOttW2eyNAxwqwranKNHcLRbayPw1YHsnsBbwnJ86gppuuPkTVM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:25 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/39] drm/amd/display: Reinstate LFC optimization
Date: Wed, 11 Dec 2019 10:32:24 -0500
Message-Id: <20191211153253.2291112-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: becb501a-1e66-43bc-b7d1-08d77e4f76ae
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24264A75E806B23AB1366CF9985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzbpsshweiRrtlGJ8dN/vypyWdF5mfvaLLECNRqTJ9yLcogXViSS8upIEV56CMMzuJoUGv8ZfkRkqoUvynE0fxg2xGlnwdDUFkOYVNvbC2pCyi3UVxMNDVKsQ4YwlJJpGeWDkz+D74pHRk6nzpLELpCt5GCunXVC8HegcuoWTI2IAOwIbARYXx0Lzq11h/rr8XsFvs07heob2xrvxJU7Sw4QxXtwogsBPUZTA+IAdufgCzf10naPw3uwy1ZkAyj/4LOI4vreikU7F7t1cVe2pCGb+/uV95jxoM4zJZAaxbh+Ur0mc+e4BZl3hvh/QfDIR4xbjUdMSjHmuWmugbckqalei01wfiX/ORUssbvN8vLJrjER1EQTaHQCzMFNG7CWvl/1lO5eUK7WwhGHmtyQUeJRfc//Yb4h7yKwqGlnLdJQZ0PfiGzYfMIqVYE676Y4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becb501a-1e66-43bc-b7d1-08d77e4f76ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:25.7271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTRUWfdTvRbLdHCjSfR9GeV7NxEfl87BsAc98QyO7/Sb1X4LHwRmdxB9j+gT2/QJasP20JVabeOOQ93kn2XaMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Amanda Liu <amanda.liu@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amanda Liu <amanda.liu@amd.com>

[why]
We want to streamline the calculations made when entering LFC.
Previously, the optimizations led to screen tearing and were backed out
to unblock development.

[how]
Integrate deflicker window calculations as well as screen tearing fixes
with the original LFC calculation optimizations.

Signed-off-by: Amanda Liu <amanda.liu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 32 +++++++++++--------
 .../amd/display/modules/inc/mod_freesync.h    |  1 +
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index a94700940fd6..fa57885503d4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -37,8 +37,8 @@
 #define STATIC_SCREEN_RAMP_DELTA_REFRESH_RATE_PER_FRAME ((1000 / 60) * 65)
 /* Number of elements in the render times cache array */
 #define RENDER_TIMES_MAX_COUNT 10
-/* Threshold to exit BTR (to avoid frequent enter-exits at the lower limit) */
-#define BTR_EXIT_MARGIN 2000
+/* Threshold to exit/exit BTR (to avoid frequent enter-exits at the lower limit) */
+#define BTR_MAX_MARGIN 2500
 /* Threshold to change BTR multiplier (to avoid frequent changes) */
 #define BTR_DRIFT_MARGIN 2000
 /*Threshold to exit fixed refresh rate*/
@@ -254,24 +254,22 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 	unsigned int delta_from_mid_point_in_us_1 = 0xFFFFFFFF;
 	unsigned int delta_from_mid_point_in_us_2 = 0xFFFFFFFF;
 	unsigned int frames_to_insert = 0;
-	unsigned int min_frame_duration_in_ns = 0;
-	unsigned int max_render_time_in_us = in_out_vrr->max_duration_in_us;
 	unsigned int delta_from_mid_point_delta_in_us;
-
-	min_frame_duration_in_ns = ((unsigned int) (div64_u64(
-		(1000000000ULL * 1000000),
-		in_out_vrr->max_refresh_in_uhz)));
+	unsigned int max_render_time_in_us =
+			in_out_vrr->max_duration_in_us - in_out_vrr->btr.margin_in_us;
 
 	/* Program BTR */
-	if (last_render_time_in_us + BTR_EXIT_MARGIN < max_render_time_in_us) {
+	if ((last_render_time_in_us + in_out_vrr->btr.margin_in_us / 2) < max_render_time_in_us) {
 		/* Exit Below the Range */
 		if (in_out_vrr->btr.btr_active) {
 			in_out_vrr->btr.frame_counter = 0;
 			in_out_vrr->btr.btr_active = false;
 		}
-	} else if (last_render_time_in_us > max_render_time_in_us) {
+	} else if (last_render_time_in_us > (max_render_time_in_us + in_out_vrr->btr.margin_in_us / 2)) {
 		/* Enter Below the Range */
-		in_out_vrr->btr.btr_active = true;
+		if (!in_out_vrr->btr.btr_active) {
+			in_out_vrr->btr.btr_active = true;
+		}
 	}
 
 	/* BTR set to "not active" so disengage */
@@ -327,7 +325,9 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		/* Choose number of frames to insert based on how close it
 		 * can get to the mid point of the variable range.
 		 */
-		if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+		if ((frame_time_in_us / mid_point_frames_ceil) > in_out_vrr->min_duration_in_us &&
+				(delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2 ||
+						mid_point_frames_floor < 2)) {
 			frames_to_insert = mid_point_frames_ceil;
 			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
 					delta_from_mid_point_in_us_1;
@@ -343,7 +343,7 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		if (in_out_vrr->btr.frames_to_insert != 0 &&
 				delta_from_mid_point_delta_in_us < BTR_DRIFT_MARGIN) {
 			if (((last_render_time_in_us / in_out_vrr->btr.frames_to_insert) <
-					in_out_vrr->max_duration_in_us) &&
+					max_render_time_in_us) &&
 				((last_render_time_in_us / in_out_vrr->btr.frames_to_insert) >
 					in_out_vrr->min_duration_in_us))
 				frames_to_insert = in_out_vrr->btr.frames_to_insert;
@@ -796,6 +796,11 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		refresh_range = in_out_vrr->max_refresh_in_uhz -
 				in_out_vrr->min_refresh_in_uhz;
 
+		in_out_vrr->btr.margin_in_us = in_out_vrr->max_duration_in_us -
+				2 * in_out_vrr->min_duration_in_us;
+		if (in_out_vrr->btr.margin_in_us > BTR_MAX_MARGIN)
+			in_out_vrr->btr.margin_in_us = BTR_MAX_MARGIN;
+
 		in_out_vrr->supported = true;
 	}
 
@@ -811,6 +816,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	in_out_vrr->btr.inserted_duration_in_us = 0;
 	in_out_vrr->btr.frames_to_insert = 0;
 	in_out_vrr->btr.frame_counter = 0;
+
 	in_out_vrr->btr.mid_point_in_us =
 				(in_out_vrr->min_duration_in_us +
 				 in_out_vrr->max_duration_in_us) / 2;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index dc187844d10b..dbe7835aabcf 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -92,6 +92,7 @@ struct mod_vrr_params_btr {
 	uint32_t inserted_duration_in_us;
 	uint32_t frames_to_insert;
 	uint32_t frame_counter;
+	uint32_t margin_in_us;
 };
 
 struct mod_vrr_params_fixed_refresh {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
