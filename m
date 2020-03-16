Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B9C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E92D2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tK0GmYmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E92D2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA7E6E47B;
	Mon, 16 Mar 2020 13:50:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3606F6E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVAZHsDpdfl4axgRbqoTB11IW7qtVby3Iw6hdj+rWh3MLpopnWDMVrsbWBdTI3IyV7NKOv+xxJ58WzRpmsowZEgCW+9pP5RxGxBeTyhfk6Jijs42x22VveSeRqnyuNMJ6QVGC9yoW4fGDZMZlsnw8SrpFy57CGbmBWaZebqdoCHpXU4aGHNkHxUBl00+xXq312dG1g2z7kSHQslTufZP2gvIh4L6f1uzykjlEB6sNLI9fD8APeGAmHIoKlDFaM9CnytQeLmCV0YKNVTk7h428OC5C2+IqfzqLtOqrkZ7DOYt7Xp37hkVG+Mj44jgl2sV0V6jsn0Bk6CPj+dsF+ibJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr3gIsd9mwlFSSTznxTFMKYvlb1N7oDhsD59f2g6uNU=;
 b=FCrnfomhMcRaSi7/UczXYwAgoLeclAxip4po4xvpoVZDAfX6QSClElxv8NuA8aaHAC3abTrxME679OhNvui4NdhHPOgfqmBE2u7E5vIoFXsDsQv24r+ZttDCaKB5LkDYlZn5iXFFZfrHUCRh5ouwmaMH6St0TN3IwxZ8lEHN9pDkalVh87khraYtOv5rOfpzwZP0nRp8oGOAJ9PnIqQ1DnEGWR8R/myCaoANggn7Gl+4n/vJK5PD1WFmIlLP2TA//rWosx9y9lb3WCz+LVzA/0jc+Mv6zSxiilJpQw2xSaqivT9NsZCykr+cGFSdB/R83/W9n7CSi69IhoCUQVcUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr3gIsd9mwlFSSTznxTFMKYvlb1N7oDhsD59f2g6uNU=;
 b=tK0GmYmNfDYRgktj0Yipa0jezrevFeKiETZZke/1KYgjG/2/Nln2r0x2gFnt2lX6FNTtTgFm0UWwtf542IK6HjDPeKyGNRvfg+02rRXFi3rv3Ybi5NZvjpePvD59pGdZroKo8/DN2bUsKn8xAgevwysgVIXKzMDqnF3auZJuDXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:07 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:07 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/19] drm/amd/display: differentiate vsc sdp colorimetry use
 criteria between MST and SST
Date: Mon, 16 Mar 2020 09:49:14 -0400
Message-Id: <20200316134920.2526155-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 900ac34f-9ff2-4d5e-6d26-08d7c9b0ef5b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396A0CE5572A02B3743A0B398F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUf2KeefGNYKFNZDrOzXx+vIcjkw4thmczplAlqTvb7tx0yPSZScuZVpRp5Ysmo0HLfeCb77m292Q1nlROT4Dpgw0/aZvWk/EGdPIg9Mh5tjUIhIEKUADcvpD0TuY8Oo4aNMaMgHHY3+uw35e1DgbuV3bQ/WsZC1mYBZWq+iBHz+7jJ8LykoRu16lAGhD+XbFLMsnMmCgxk/ainn4Cr3K4eIV47lfIP5ggsauzBcZ4T0WJyAEtDdNpiWedTg7cJnknCrtIcOYDvVLc9xKV12SLdvIMf2StRmfeo+uzgoZVBkW7DnUn2iKtAsjGejfsmQjtexKN4d5FqJrJPei10Kb7HSiWsKFKUMivlwSSdJj6bdPTpkeAuN93/+uV7D6g3MgSuY3k48T1TpOqaY11WPx+1dDQxyKDg0Y3UiXyQRuTM0ffYBgLBk+PEkSw+apVee
X-MS-Exchange-AntiSpam-MessageData: IrvLvY6J6/viVVw8RL3hmhfOdrqQrGG+RoWYlWIFvYVDZMAXulTYQnIfT0GsJ/pO32SA443V47ijHWLllgOiDf1UHkVH5mCUFBsJlt+UOYHgk+D5UwcF1C6tsq1vM4xe++sBqne+ansvd+LUN6sp7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900ac34f-9ff2-4d5e-6d26-08d7c9b0ef5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:06.6436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGC8rAj4PmYUG1xZxQvOVZ+8ZdX/Sn7ZgkmgBq92WViVMjeHmyz97GDZhrhZvzFyewXVDp5sLv7S4WLB/1ZRxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Martin Tsai <martin.tsai@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
We should check MST BU support capability on output port before building
vsc info packet.

[How]
Add a new definition for port and sink capability check.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 .../amd/display/modules/inc/mod_info_packet.h |  3 +--
 .../display/modules/info_packet/info_packet.c | 20 +++----------------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 676ec4d797e5..36794f7c6232 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4397,9 +4397,22 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			struct dmcu *dmcu = core_dc->res_pool->dmcu;
 
 			stream->psr_version = dmcu->dmcu_version.psr_version;
-			mod_build_vsc_infopacket(stream,
-					&stream->vsc_infopacket,
-					&stream->use_vsc_sdp_for_colorimetry);
+
+			//
+			// should decide stream support vsc sdp colorimetry capability
+			// before building vsc info packet
+			//
+			stream->use_vsc_sdp_for_colorimetry = false;
+			if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+				stream->use_vsc_sdp_for_colorimetry =
+					aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
+			} else {
+				if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+					stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED) {
+					stream->use_vsc_sdp_for_colorimetry = true;
+				}
+			}
+			mod_build_vsc_infopacket(stream, &stream->vsc_infopacket);
 		}
 	}
 finish:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 280b015d10bd..6cfb534e56bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1047,6 +1047,8 @@ struct dc_sink {
 	struct dc_sink_dsc_caps dsc_caps;
 	struct dc_sink_fec_caps fec_caps;
 
+	bool is_vsc_sdp_colorimetry_supported;
+
 	/* private to DC core */
 	struct dc_link *link;
 	struct dc_context *ctx;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 42cbeffac640..13c57ff2abdc 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -34,8 +34,7 @@ struct dc_info_packet;
 struct mod_vrr_params;
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet,
-		bool *use_vsc_sdp_for_colorimetry);
+		struct dc_info_packet *info_packet);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 6a8a056424b8..cff3ab15fc0c 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -130,8 +130,7 @@ enum ColorimetryYCCDP {
 };
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet,
-		bool *use_vsc_sdp_for_colorimetry)
+		struct dc_info_packet *info_packet)
 {
 	unsigned int vsc_packet_revision = vsc_packet_undefined;
 	unsigned int i;
@@ -139,11 +138,6 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	unsigned int colorimetryFormat = 0;
 	bool stereo3dSupport = false;
 
-	/* Initialize first, later if infopacket is valid determine if VSC SDP
-	 * should be used to signal colorimetry format and pixel encoding.
-	 */
-	*use_vsc_sdp_for_colorimetry = false;
-
 	if (stream->timing.timing_3d_format != TIMING_3D_FORMAT_NONE && stream->view_format != VIEW_3D_FORMAT_NONE) {
 		vsc_packet_revision = vsc_packet_rev1;
 		stereo3dSupport = true;
@@ -153,9 +147,8 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	if (stream->psr_version != 0)
 		vsc_packet_revision = vsc_packet_rev2;
 
-	/* Update to revision 5 for extended colorimetry support for DPCD 1.4+ */
-	if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-			stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
+	/* Update to revision 5 for extended colorimetry support */
+	if (stream->use_vsc_sdp_for_colorimetry)
 		vsc_packet_revision = vsc_packet_rev5;
 
 	/* VSC packet not needed based on the features
@@ -269,13 +262,6 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = true;
 
-		/* If we are using VSC SDP revision 05h, use this to signal for
-		 * colorimetry format and pixel encoding. HW should later be
-		 * programmed to set MSA MISC1 bit 6 to indicate ignore
-		 * colorimetry format and pixel encoding in the MSA.
-		 */
-		*use_vsc_sdp_for_colorimetry = true;
-
 		/* Set VSC SDP fields for pixel encoding and colorimetry format from DP 1.3 specs
 		 * Data Bytes DB 18~16
 		 * Bits 3:0 (Colorimetry Format)        |  Bits 7:4 (Pixel Encoding)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
