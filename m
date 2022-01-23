Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A642C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59A210E956;
	Sun, 23 Jan 2022 18:21:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E679F10E7F6
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwEcFq07bSVciRd9x1M8Z3201Yh5hTvCtN2uFLEyBkmmLgAIcNq4SyXszRzFTQkXvng2zvCAMZSuRhp4tw3O6s5foSpIH49DaY97O24bF6kKdp1UwrH0CAKepKRU5vtyrJt9eFxxZdgau+Kp90719jjQap3wwT0gTjqBxCJiZXbolqrpUtgpZRA4M1tnLheRErc3254EKQBkL+b4BFMDyjxJHJBHQrC9wi648N0L1rEbdDXfFEyCHRFd+0Lw203Gxr4s632TNCzbUt/lL1BGZvcVr3Cfrq2JOWfxSoV6sRlQ0gzdFU50aL5GmkL0Yqf0caGsGePQmvpPaWDlmFTlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4QWybOd3fjcVtFR2vi4rGEKPFtgUS6qWv1RjqmorO0=;
 b=Aq0+hYSuIZkc4RQ/Y8iiudeFo0OZ/HOr0oXLEO07gSLCAGV+gZCCdhego93fGtQT/FaJwHUhxTcQiSiyfFDyfHmSkkO6fecZvgX5tf9okcCaMlDViGQcx/j2Tn97el0r24QLlggkhZmhd1do5dZJQwzdPgPxArDYyQumCMLH/9Kt1FM680kmMTLu06RUBZXDvYY2zVOqZ9xCebIAch8bBDotKjSxLgbC6XnYEYRzSRofS1cZCKdAHwF3wyyg8psbLPBPkl9WHh40nQtjaTDQ77zBCOtrndkecVimxQcRLyBsHugbqbJOFpbNRCH2GCJNOsSNL9u3tpohB5i4iuL9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4QWybOd3fjcVtFR2vi4rGEKPFtgUS6qWv1RjqmorO0=;
 b=BLlws6YQ3IL9Xl1ESFxPP1LcRh18wxFaP1w4oij5YC5Z0iNLZq6Q9d2Vgqr+Z2JzVp8fi+18pAu8fb4sU3hK5tE+KFS+HzOk9bBmDWe+yGUAS+1QIlRwBzSORB5uJpFZcfufaM4MsPsLnVtugcXn1pcBlL2uWvALtUYTAySvn2g=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:21:13 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::7b) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:12 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:08 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/24] drm/amd/display: Update VSC HDR infoPacket on TF change
Date: Sun, 23 Jan 2022 13:20:12 -0500
Message-ID: <20220123182021.4154032-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70769d4-157a-4d02-e7fe-08d9de9d231d
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016AD974CB999F44BB4C2C9985D9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFnjT9i46/TaQuq8jOYoZpxNm5DO2x4lrNHbOkeg6Nn02HutGxGtGC0wbiOA5hcpGk+Q4AxkntcgXeozZiNN/6RbDX2SYfyrdEdvWtv4EiMJEduMM/nH+WFjof7LgVA+1Jrf5CgFGBA6aOhaLuSFmL2fAWEpMXGOVilagDsB/pDKBUkJJx+KliM3VBszzVkhMl7ESdtcaJ/VAJxe/+GbH8gGzNJ84w84dMPoFspTc0JKl0OXBgTmTxFLJ5pdq2y6bkEvdJGwMIVchoajEpDIvi/SGS55mwAbfUXTqTsyg5pjLMz9URNFvXLresuO7hY6MF4uIpe37VuRrOEIUrlajGDStdnQo7gt0XcS+xcgrN6oMguzxX1KhQyWwxihWa49fq7Dwwa2MB49woiA4RKm4DSBK+g6GEJYOnBtsgEpN26n95xD2PYO/H0SKKNMGoiuYHlXfTMd9qiWfcu+RFivkDRiC1pmO2HYinLRFMVAYGTUsatone0oIEVgsyprCGpeiLC1kjJGH5AqY5gsxxVR/OwyrbFrChBney/VjMicSPW0dfvSnOID9YUIeVkRF6YvOfBSu9Uskh3FaA7LIj8ClcDd5h8j497utGYppCXCxQX2uaSnTJ4WgqqIJMtJUWJaD3pHLSvvdAl1Ui9gOtHSgD7erPYG6B+wJebQfJmO1ATiWkvDVtWurzFn/IZhWP/FMHJHOYLP0BT/gd/nc0gC8/iPfkZk6hawFFwHdhGWEv8FiGCa9zRvYBmGjCfiVBITpWxrgKooVL9oaJN+73xynstEl4GrN+/NflBQf6xoC3k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(82310400004)(2616005)(8676002)(8936002)(36756003)(4326008)(70586007)(70206006)(336012)(54906003)(1076003)(2906002)(426003)(47076005)(508600001)(316002)(6666004)(15650500001)(6916009)(356005)(36860700001)(83380400001)(81166007)(40460700003)(86362001)(186003)(26005)(16526019)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:12.9717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70769d4-157a-4d02-e7fe-08d9de9d231d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Reza Amini <Reza.Amini@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <Reza.Amini@amd.com>

[why]
OnSetSourceContentAttribute it does not trigger an update for the VSC
with TF change.

[how]
In this call, create a new VSC infoPacket based on the new config, and
allow DisplayTarget decide if an update and pursuant passive flip is
necessary

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Reza Amini <Reza.Amini@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/modules/inc/mod_info_packet.h |  3 ++-
 .../display/modules/info_packet/info_packet.c | 25 ++++++++++---------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 94b4d7f70e45..fa2c1a3efbbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6494,7 +6494,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
-		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket);
+		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space);
 		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
 	}
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 1ab813b4fd14..1d8b746b02f2 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -34,7 +34,8 @@ struct dc_info_packet;
 struct mod_vrr_params;
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet);
+		struct dc_info_packet *info_packet,
+		enum dc_color_space cs);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 57f198de5e2c..b691aa45e84f 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -130,7 +130,8 @@ enum ColorimetryYCCDP {
 };
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet)
+		struct dc_info_packet *info_packet,
+		enum dc_color_space cs)
 {
 	unsigned int vsc_packet_revision = vsc_packet_undefined;
 	unsigned int i;
@@ -331,13 +332,13 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		/* Set Colorimetry format based on pixel encoding */
 		switch (stream->timing.pixel_encoding) {
 		case PIXEL_ENCODING_RGB:
-			if ((stream->output_color_space == COLOR_SPACE_SRGB) ||
-					(stream->output_color_space == COLOR_SPACE_SRGB_LIMITED))
+			if ((cs == COLOR_SPACE_SRGB) ||
+					(cs == COLOR_SPACE_SRGB_LIMITED))
 				colorimetryFormat = ColorimetryRGB_DP_sRGB;
-			else if (stream->output_color_space == COLOR_SPACE_ADOBERGB)
+			else if (cs == COLOR_SPACE_ADOBERGB)
 				colorimetryFormat = ColorimetryRGB_DP_AdobeRGB;
-			else if ((stream->output_color_space == COLOR_SPACE_2020_RGB_FULLRANGE) ||
-					(stream->output_color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE))
+			else if ((cs == COLOR_SPACE_2020_RGB_FULLRANGE) ||
+					(cs == COLOR_SPACE_2020_RGB_LIMITEDRANGE))
 				colorimetryFormat = ColorimetryRGB_DP_ITU_R_BT2020RGB;
 			break;
 
@@ -347,13 +348,13 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 			/* Note: xvYCC probably not supported correctly here on DP since colorspace translation
 			 * loses distinction between BT601 vs xvYCC601 in translation
 			 */
-			if (stream->output_color_space == COLOR_SPACE_YCBCR601)
+			if (cs == COLOR_SPACE_YCBCR601)
 				colorimetryFormat = ColorimetryYCC_DP_ITU601;
-			else if (stream->output_color_space == COLOR_SPACE_YCBCR709)
+			else if (cs == COLOR_SPACE_YCBCR709)
 				colorimetryFormat = ColorimetryYCC_DP_ITU709;
-			else if (stream->output_color_space == COLOR_SPACE_ADOBERGB)
+			else if (cs == COLOR_SPACE_ADOBERGB)
 				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
-			else if (stream->output_color_space == COLOR_SPACE_2020_YCBCR)
+			else if (cs == COLOR_SPACE_2020_YCBCR)
 				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
 			break;
 
@@ -391,8 +392,8 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		}
 
 		/* all YCbCr are always limited range */
-		if ((stream->output_color_space == COLOR_SPACE_SRGB_LIMITED) ||
-				(stream->output_color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE) ||
+		if ((cs == COLOR_SPACE_SRGB_LIMITED) ||
+				(cs == COLOR_SPACE_2020_RGB_LIMITEDRANGE) ||
 				(pixelEncoding != 0x0)) {
 			info_packet->sb[17] |= 0x80; /* DB17 bit 7 set to 1 for CEA timing. */
 		}
-- 
2.25.1

