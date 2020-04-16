Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4133C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A37921841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AOAtJ1fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A37921841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654066E284;
	Thu, 16 Apr 2020 23:41:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9B06E284
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0vrSji6Q1Zwapt9c3nAF8J+Km3W569dzx+NKP2UVOE03CtaVd0NmuAsTGbMaejNzCkHCKU0ZwXUUBJecR02mXzvEXzzIMINUI2RVU7UYhnFXZs7aL7Zny9WPBzOakLfpciAlPde16OtlTD8ecb+AdYfrG1X3WlMhjsD5xabqjYSG4eTgK+QE2TGf/kvQ5inIMWMefWXi66/pYGy0j4gNyNGqTcZvHBo7ECPdJm/jSaOmed2Nqw1Eq4A4EKGMQrfbsAWRXhCyJro2r0o5FBnA/jemxM2SKH0iKyA1GBe2FUbb8CbbMkYvn55hPjIMkcmwZrNIzIgPnVyPaunh2t10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VwiRkhKk82MXZV0oty+Et1MC4h1Ea4yQSmFRVSeljQ=;
 b=f83OMfacoT3sXA1+dpRRQUpik7/dIldRYNw4ZOR7+RJQg2tgr9yXJ806ymW45JkBYoZ+nJzLjr/0pnJ4VZaumi54OzmwbSlFVzGYSXzVifw8zqNYXwLvwONmJfIMuk0wjKsAYyN5SjQ3CND3HZ65qlhY0PViJiFunMj1rJZcudO6Y3CZz+hmqKdDtkYKX41aGIJdvO5rGkt6O4obdQ7bNSXQEvQch1sVIJ+p9ZR2ccqfgV1ia9bdX4UA2i88QRYoDMVdTO2cE4BOEZgHqL4+3t7WStHMp8M+mzE7eP0nskwYTEwyyt3Ww8rha+W0szI+2CXfwgomUSlmUHzLsmdhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VwiRkhKk82MXZV0oty+Et1MC4h1Ea4yQSmFRVSeljQ=;
 b=AOAtJ1fnq2j6voAQ/7HC/SH3YMtJXMmaP2wMvYqUCVrMwa3Z50e1CvHIyb00Ayvf43dpBY+eVl7D5G+00vO5iNGD8/+Bld6ds4T32TofAR8jVq1WdhSEySlzTqbnS3usTUK7yQpbPYc0v1YWFcNGbOohvThW+tk6SOdNIi9LWXM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:31 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/35] drm/amd/display: Change infopacket type programming
Date: Thu, 16 Apr 2020 19:40:25 -0400
Message-Id: <20200416234044.2082886-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:30 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45d3381c-66ba-441c-b895-08d7e25fb0fb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245915A67C1AC414D9998E4398D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXWiiEfzjzBkCL1wbTFrOOMVpca4+Z5EZGzFhalNIRvvSXVISVwjtvzElwaDIvFIfzXjrykfV6hTjIc/OO3Rr6s6RAfGAqPjMvXY5xJBwgRZJaO4M6mgAU4lVXSR/iYiaQBDj9V9i78MdOf+JlvWxyz566ljE4aBsKzSaV0cnPNM6o6DJlCZyjZurgsr0CaR6uNdvosl1va5l/8UE+NV3ZeelMMpQT+Q2v+Zsszp8h7ltHvuGN3lNklttfs0MgCrjwQV7JvG2W0v3DXQIerp9i4GttIGCYiQyV3l5pR6G83yNx4ieUKfybSylqZG1dkUgdCOxLdXapn0+EwumlcGw6fWk7gJ2LD8Qykt5Oi7kggC+eBqT3RapGZzBJ3Z/gyLXEAQNul1odWtUFqrYpYF4ati/R4criQEWndQOpCr6nTe262beSjlrseOYIEJEfHz
X-MS-Exchange-AntiSpam-MessageData: 8zl0Zs1Tqbs7JgQlTHpNtcsA4pPWec3XRl16/vJAl7/cAf5dRITXW/kgPYW5uL1KrQuGdje1TJfS7B134PCMcBMajstWS75qu3NhMkFX4lPj8o9S2ItP/eGt/23jusS29FMT1/5XzRiqJyHFEG4spI88yDsow5i/LFWnKqwYESE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d3381c-66ba-441c-b895-08d7e25fb0fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:31.7650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pPgulBGUnANBcvx+NKMnc0jBLmzU5Fqey0aFMwyqgF3oEJcWqKRLCtwi/G3Syb6cPPFny9XEjNiunSuBZoNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Haiyi Zhou <haiyi.zhou@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haiyi Zhou <haiyi.zhou@amd.com>

[Why]
Certain displays may experience blanking if infopacket max range does
not equal nominal refresh rate.

[How]
Add additional infopacket versions to program range to full or forced
range in freesync states.
This does not change the vrr logic.

Signed-off-by: Haiyi Zhou <haiyi.zhou@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 101 ++++++++++++++++--
 .../amd/display/modules/inc/mod_freesync.h    |   3 +
 .../drm/amd/display/modules/inc/mod_shared.h  |   5 +-
 3 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index c33454a9e0b4..eb7421e83b86 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -443,7 +443,7 @@ static bool vrr_settings_require_update(struct core_freesync *core_freesync,
 		return true;
 	} else if (in_vrr->state == VRR_STATE_ACTIVE_FIXED &&
 			in_vrr->fixed.target_refresh_in_uhz !=
-					in_config->min_refresh_in_uhz) {
+					in_config->fixed_refresh_in_uhz) {
 		return true;
 	} else if (in_vrr->min_refresh_in_uhz != min_refresh_in_uhz) {
 		return true;
@@ -491,7 +491,7 @@ bool mod_freesync_get_v_position(struct mod_freesync *mod_freesync,
 	return false;
 }
 
-static void build_vrr_infopacket_data(const struct mod_vrr_params *vrr,
+static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 		struct dc_info_packet *infopacket)
 {
 	/* PB1 = 0x1A (24bit AMD IEEE OUI (0x00001A) - Byte 0) */
@@ -523,14 +523,74 @@ static void build_vrr_infopacket_data(const struct mod_vrr_params *vrr,
 			vrr->state == VRR_STATE_ACTIVE_FIXED)
 		infopacket->sb[6] |= 0x04;
 
+	// For v1 & 2 infoframes program nominal if non-fs mode, otherwise full range
 	/* PB7 = FreeSync Minimum refresh rate (Hz) */
-	infopacket->sb[7] = (unsigned char)((vrr->min_refresh_in_uhz + 500000) / 1000000);
+	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+			vrr->state == VRR_STATE_ACTIVE_FIXED) {
+		infopacket->sb[7] = (unsigned char)((vrr->min_refresh_in_uhz + 500000) / 1000000);
+	} else {
+		infopacket->sb[7] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
+	}
 
 	/* PB8 = FreeSync Maximum refresh rate (Hz)
 	 * Note: We should never go above the field rate of the mode timing set.
 	 */
 	infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
 
+	//FreeSync HDR
+	infopacket->sb[9] = 0;
+	infopacket->sb[10] = 0;
+}
+
+static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
+		struct dc_info_packet *infopacket)
+{
+	/* PB1 = 0x1A (24bit AMD IEEE OUI (0x00001A) - Byte 0) */
+	infopacket->sb[1] = 0x1A;
+
+	/* PB2 = 0x00 (24bit AMD IEEE OUI (0x00001A) - Byte 1) */
+	infopacket->sb[2] = 0x00;
+
+	/* PB3 = 0x00 (24bit AMD IEEE OUI (0x00001A) - Byte 2) */
+	infopacket->sb[3] = 0x00;
+
+	/* PB4 = Reserved */
+
+	/* PB5 = Reserved */
+
+	/* PB6 = [Bits 7:3 = Reserved] */
+
+	/* PB6 = [Bit 0 = FreeSync Supported] */
+	if (vrr->state != VRR_STATE_UNSUPPORTED)
+		infopacket->sb[6] |= 0x01;
+
+	/* PB6 = [Bit 1 = FreeSync Enabled] */
+	if (vrr->state != VRR_STATE_DISABLED &&
+			vrr->state != VRR_STATE_UNSUPPORTED)
+		infopacket->sb[6] |= 0x02;
+
+	/* PB6 = [Bit 2 = FreeSync Active] */
+	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+			vrr->state == VRR_STATE_ACTIVE_FIXED)
+		infopacket->sb[6] |= 0x04;
+
+	if (vrr->state == VRR_STATE_ACTIVE_FIXED) {
+		/* PB7 = FreeSync Minimum refresh rate (Hz) */
+		infopacket->sb[7] = (unsigned char)((vrr->fixed_refresh_in_uhz + 500000) / 1000000);
+		/* PB8 = FreeSync Maximum refresh rate (Hz) */
+		infopacket->sb[8] = (unsigned char)((vrr->fixed_refresh_in_uhz + 500000) / 1000000);
+	} else if (vrr->state == VRR_STATE_ACTIVE_VARIABLE) {
+		/* PB7 = FreeSync Minimum refresh rate (Hz) */
+		infopacket->sb[7] = (unsigned char)((vrr->min_refresh_in_uhz + 500000) / 1000000);
+		/* PB8 = FreeSync Maximum refresh rate (Hz) */
+		infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
+	} else {
+		// Non-fs case, program nominal range
+		/* PB7 = FreeSync Minimum refresh rate (Hz) */
+		infopacket->sb[7] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
+		/* PB8 = FreeSync Maximum refresh rate (Hz) */
+		infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
+	}
 
 	//FreeSync HDR
 	infopacket->sb[9] = 0;
@@ -678,7 +738,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
 	unsigned int payload_size = 0;
 
 	build_vrr_infopacket_header_v1(signal, infopacket, &payload_size);
-	build_vrr_infopacket_data(vrr, infopacket);
+	build_vrr_infopacket_data_v1(vrr, infopacket);
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
 	infopacket->valid = true;
@@ -692,7 +752,24 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 	unsigned int payload_size = 0;
 
 	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
-	build_vrr_infopacket_data(vrr, infopacket);
+	build_vrr_infopacket_data_v1(vrr, infopacket);
+
+	build_vrr_infopacket_fs2_data(app_tf, infopacket);
+
+	build_vrr_infopacket_checksum(&payload_size, infopacket);
+
+	infopacket->valid = true;
+}
+
+static void build_vrr_infopacket_v3(enum signal_type signal,
+		const struct mod_vrr_params *vrr,
+		enum color_transfer_func app_tf,
+		struct dc_info_packet *infopacket)
+{
+	unsigned int payload_size = 0;
+
+	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
+	build_vrr_infopacket_data_v3(vrr, infopacket);
 
 	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
@@ -717,11 +794,14 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		return;
 
 	switch (packet_type) {
-	case PACKET_TYPE_FS2:
+	case PACKET_TYPE_FS_V3:
+		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket);
+		break;
+	case PACKET_TYPE_FS_V2:
 		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket);
 		break;
 	case PACKET_TYPE_VRR:
-	case PACKET_TYPE_FS1:
+	case PACKET_TYPE_FS_V1:
 	default:
 		build_vrr_infopacket_v1(stream->signal, vrr, infopacket);
 	}
@@ -793,6 +873,11 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 				calc_duration_in_us_from_refresh_in_uhz(
 						(unsigned int)max_refresh_in_uhz);
 
+		if (in_config->state == VRR_STATE_ACTIVE_FIXED)
+			in_out_vrr->fixed_refresh_in_uhz = in_config->fixed_refresh_in_uhz;
+		else
+			in_out_vrr->fixed_refresh_in_uhz = 0;
+
 		refresh_range = in_out_vrr->max_refresh_in_uhz -
 				in_out_vrr->min_refresh_in_uhz;
 
@@ -843,7 +928,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 				in_out_vrr->min_refresh_in_uhz);
 	} else if (in_out_vrr->state == VRR_STATE_ACTIVE_FIXED) {
 		in_out_vrr->fixed.target_refresh_in_uhz =
-				in_out_vrr->min_refresh_in_uhz;
+				in_out_vrr->fixed_refresh_in_uhz;
 		if (in_out_vrr->fixed.ramping_active &&
 				in_out_vrr->fixed.fixed_active) {
 			/* Do not update vtotals if ramping is already active
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index dbe7835aabcf..0ba3cf7f336a 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -83,6 +83,8 @@ struct mod_freesync_config {
 	bool btr;
 	unsigned int min_refresh_in_uhz;
 	unsigned int max_refresh_in_uhz;
+	unsigned int fixed_refresh_in_uhz;
+
 };
 
 struct mod_vrr_params_btr {
@@ -112,6 +114,7 @@ struct mod_vrr_params {
 	uint32_t max_duration_in_us;
 	uint32_t max_refresh_in_uhz;
 	uint32_t min_duration_in_us;
+	uint32_t fixed_refresh_in_uhz;
 
 	struct dc_crtc_timing_adjust adjust;
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_shared.h b/drivers/gpu/drm/amd/display/modules/inc/mod_shared.h
index fe2117904329..198c0e64d13a 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_shared.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_shared.h
@@ -40,8 +40,9 @@ enum color_transfer_func {
 
 enum vrr_packet_type {
 	PACKET_TYPE_VRR,
-	PACKET_TYPE_FS1,
-	PACKET_TYPE_FS2,
+	PACKET_TYPE_FS_V1,
+	PACKET_TYPE_FS_V2,
+	PACKET_TYPE_FS_V3,
 	PACKET_TYPE_VTEM
 };
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
