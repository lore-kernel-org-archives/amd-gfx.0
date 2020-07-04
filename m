Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4ABC433E1
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7205A2075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uoq5HuFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7205A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A636EBE3;
	Sat,  4 Jul 2020 01:15:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693686E3D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvxyH8Yr9BTCPjlq4eZayo7PS71UJTTrEK+ZmP5ssrq3RZ8Wh4Mwj3p0p+SZIsfek0I0qJZlWWvlcUwZrng9jA3I8GyYbKej1pfRnfVIEp7d1tO1N0/3WwN2r03n5NIIf21eOGtHRHveV+tLGYe8X5LaJ5stSCoySubpZmXvgRCx809MTd+bsnI4p+yLocP8tjnCwuKwCQ6297CbTMMJLKZUN1juHsinLTP5lziXfO8mVQRbZfKtx0YGrN5ROKdF3faPifZykbuArmwRJyh3ldnkV7VS2LyFx263MtA6rkZsxtIe95MRel7UpVqAQsTvD9rcbCiurP/L4M5jW1OJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xuYFjYpLl/2Jpbpc281MDYtXQA6LothTewB4RLjHPo=;
 b=cngx3na+4X7QCizAtqLUJBpcOQCyJBDK+Qt503h3X2ADn9XFK/zzbF3qQ+ecKksoPWxC+p/nUWUp3GbRrkOZiN2aarlVp37t6td6J+bVrWaNX43utlvjGPt4csNa3ZqiNcoxMDy8hQLr8xE2bWs07nAtmj7grPz+zUFouS5irgIHnN25Lbhde8qWzVSyofRkFE5P0qHu8bzvPHc8wgfLjmzq7vl4NGFgxEM+RWNoIiDOINruWJDEc2T/UX+ICp2lNG8HL9rsfXoRfVfjCtCMJDp26M8NAB3sPkJf3W3BS5U4eX+492Ttrkp4bXYosK9SNAPSlapS3UjTwrQJmtFUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xuYFjYpLl/2Jpbpc281MDYtXQA6LothTewB4RLjHPo=;
 b=Uoq5HuFl/tJlJo0W4GevmnmijA35Zuq2ybQgKP5+EGyx9wznv6xNstzb3q0qQnEwxzqD8nY1J57H7H2pPCRTuFIMs73YDyFdFckyb4K07A9FAC4ZaLBRWjp96QiIR/pUkNwGp6w+mSp/bs7Rf03uAJxCI2LdBZk6kAoNzV5S9PM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:26 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:26 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amd/display: Remove VSC infoframe dep on DMCU
Date: Fri,  3 Jul 2020 21:14:53 -0400
Message-Id: <20200704011457.2368241-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:25 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e74dedb7-6668-497c-4f6d-08d81fb7bbb6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37685A51170CD74FE5312BC3986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhLtsf6zyqkcegwyQ5F9PNBEnKDaDZ5qUfXv8w4e77IcaPSHTyvVbuEKnLFiQi/Tf0lWEmcQpb5OFwov2OOX7TZFA5TMS5g/H1JYw1F3NNvEdPKMsJHOgEKy41qjKP7aca5rqZnDXkT5iqqvYZ7Bf1Px355GsuHjzAA497pGhH28wJOm7Z1emXB3gMtiFvtdfZki3mdYfW98+YH8TC2vMYKeIvk+4NJ28kIUZWgIP+hVYZnbZ4QEYsqmHVYvoOFkq8qJfeB3bRvD4wh41Is7wg/YbAhMQCwWZ8oRoWP4Stn0toubFAn32YBztas4V9nOSiKU9Di8LmzbFBeF0FITfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7ZJaspiMIxJmRGLgTqqLRNpUWe9pdl3tSojMFY7wlNkVY2Uo1v1fGlplAmCTVQvATdSXMEr7g2GP6j1zUXDC5px+s5LfSZxQ/U8s9uNu/0DKSZQkrSg1wDwhr5FuRKDEfyNgU13v9vH2CUIJ8biAvEPDUUPYrlsZJVKq33q/aSStX+T77s7GMHYYtQTC8DXHmq8xHtYYy0zwxmZeUnl/yZ6nMGKb6iSGzQDWGYMHmgUMCg31cTnhs31ite61gQ75L1FgaSKPwL2jcTb6kE8T4iwvOoaP+X2PxbBcmv8NoXsyP+SlNHM3j8wvcT8OH9UUWpVQSAXFE9F4jPpK+bsAT9z0aS5QV2sVRx53FEiVF4zpEGeH8mURnkNHZRSEUwABRS6OjAGrvqa1M3tXCv3uOkVg+ToXVbjmR+nYGXZRDJdIVOF3XIiKIQKPzEYKK42KmcLT/hlIYRLc6Fe9UoNV88dSVd9mASIP7tiNHb473x56XtC1uZIjpTlGJ09NZmQLLiIiFmOyKkAkotEpK/zhzg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74dedb7-6668-497c-4f6d-08d81fb7bbb6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:26.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfobnNPK88AR4YD1japwkbdBuUXHofJc2FT9qlQBgTP0oOYDL+mEez7+Aw8EnkTGC4vPAdDVcFCKS6Ge1naZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Roman Li <roman.li@amd.com>, aurabindo.pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
VSC infoframe is needed for PSR. Previously only DMCU controller
supported PSR. Now DMUB also implements PSR.

[How]
Remove VSC infoframe dependency on DMCU.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 132a2bde6a14..b4e120e95438 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4629,24 +4629,20 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
-	if (stream->link->psr_settings.psr_feature_enabled)	{
-		struct dc  *core_dc = stream->link->ctx->dc;
-
-		if (dc_is_dmcu_initialized(core_dc)) {
-			//
-			// should decide stream support vsc sdp colorimetry capability
-			// before building vsc info packet
-			//
-			stream->use_vsc_sdp_for_colorimetry = false;
-			if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-				stream->use_vsc_sdp_for_colorimetry =
-					aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
-			} else {
-				if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
-					stream->use_vsc_sdp_for_colorimetry = true;
-			}
-			mod_build_vsc_infopacket(stream, &stream->vsc_infopacket);
+	if (stream->link->psr_settings.psr_feature_enabled) {
+		//
+		// should decide stream support vsc sdp colorimetry capability
+		// before building vsc info packet
+		//
+		stream->use_vsc_sdp_for_colorimetry = false;
+		if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			stream->use_vsc_sdp_for_colorimetry =
+				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
+		} else {
+			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
+				stream->use_vsc_sdp_for_colorimetry = true;
 		}
+		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket);
 	}
 finish:
 	dc_sink_release(sink);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
