Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CFC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB39206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GqK124Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB39206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BE16ECDE;
	Fri, 26 Jun 2020 16:19:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6B86ECDD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5ajeEjBI2aTq8gNZ1/mK0eJkSv1sZPssZD43fB4Cd5yq1PuJpiO0kgk4FYY9prsVAa+j0anizWB731GgHELQBIKQpP5oJxWFfVJwQbrweItsmvGGsvzSsn4Klw+4i8biG/1sU8aKapr5d9O+3y0H2GS8RzDcbu6tdyJLTAA/bdfTaXVJrHDkcWVdPUCgdxlLq7YMv+u+tBfZx2zZmFTeRDSsyhfzErNyTUe6Jm8vH8z9Lwx5OOXhhpjMRXdzbz1dtVWLEO7GABh+5DGOf6pb238HAPo9rHD5eO+0RNaUrQsuJnJ+/Vu0c9cupH50Sj0poqb1gDeC/ZjT9iylnfS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRV39IMyaX5TzIHDc4DRKlwAGtz8jnAiL1YW2qhgpkE=;
 b=YfHMdwcM4hQ6n/Htc37VO3/xTn+gUYZpQtr0U6yuFphjpqdjy078X9Bs0Yw2dEnbQy3gxMwyML5KH5/eM07WZNI5IClpi+woEOhs1a9VGFWfcxihdw3K4J/1M9qM5fAqoztC/jD1+ci/1ZVToZmjn+r0zlKZrLV0/m3Ehbp9E7xU8s1hGc1rvNGRmqQE1Eu9dV8GJx/yDI9Hvh97jY4KD0PgnhpOz80ECEyfTepHJ3KoGeWY9JXYs+dKkyNFD0vf7G7olOl/gLBqyAAoY857FZMe1G1EfintYYnq0nm7cDcll7LrvWBfm/mLpgpT++fgxtei2Xz03mlMm7MPIkFcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRV39IMyaX5TzIHDc4DRKlwAGtz8jnAiL1YW2qhgpkE=;
 b=GqK124Cwhq1kA3RuMeJxxEESvW1tQcp1Avi7Pk/Rq4cyRvaiJzYT+cU3WWy9bwh7jaKywAl2YV0YIJvzaZhezgzG9mJcLecM6FaJktYO0+sCLNESlAN/qE1BX5QIW2WUBgHeZo/beCTuomgjEXMiGjN69dDOjFMXS/3HmZ2Qa1E=
Received: from MWHPR15CA0025.namprd15.prod.outlook.com (2603:10b6:300:ad::11)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 16:19:53 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::28) by MWHPR15CA0025.outlook.office365.com
 (2603:10b6:300:ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:50 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:50 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:49 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amd/display: check dpcd read status of
 DP_DOWNSTREAM_PORT_0
Date: Fri, 26 Jun 2020 12:18:41 -0400
Message-ID: <20200626161847.16000-6-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(47076004)(4326008)(2906002)(82310400002)(82740400003)(6916009)(478600001)(6666004)(81166007)(356005)(26005)(70206006)(86362001)(2616005)(5660300002)(186003)(1076003)(36756003)(70586007)(8676002)(44832011)(426003)(336012)(316002)(54906003)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8457f163-43d2-4ec2-197d-08d819ecc247
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1339E0D6FBF72C9D5F434709E5930@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrKIio5tBsi7yNqhGodZ2hVBR4xttJz9GkzCQETrGx+8JknAJCoSQZuHeH/nAxegCunIczTC4QPOrgfZlBUjnYdlhVNByQghWFgNo3sji7MSd2XTyF6SUYm2hUpQv+QzgXFo7LyjP0oKSEdCcOEj5Kr5YK135HgTKWQJNf4jkGRh0SqimeRWk0Y+ifg0PsPwK6nlFxW43BJWfW7nJpiMw3dlB8usJ0U795eIkVwryBAii1B+JtW8HDbBsDszUxDZ6DoszrftfSGAHty8wn/AizPYNxecICWeaHY2lQZzIdA0DCRA3j+TQS0C/ACaH39KEf5IGJRpDqfvlGeO+Ol9QprBISubRp1r+xDWpqahk5QT75VeWRAlr1oYcyE6ywupgCuvnyM8xWCVEiNd+obN6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:53.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8457f163-43d2-4ec2-197d-08d819ecc247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, jinlong zhang <jinlong.zhang@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jinlong zhang <jinlong.zhang@amd.com>

[Why]
For special DP convert VGA dongle, core_link_read_dpcd for
DP_DOWNSTREAM_PORT_0 always return fail, then dongle_type will be set to
DISPLAY_DONGLE_NONE, which will cause desktop resolution abnormal.

[How]
If dpcd for DP_DOWNSTREAM_PORT_0 read fail, skip set dongle_type =
DISPLAY_DONGLE_NONE.

Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 105 +++++++++---------
 1 file changed, 53 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d2116cb71937..7ae6d903cf04 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3097,62 +3097,63 @@ static void get_active_converter_info(
 		uint8_t det_caps[16]; /* CTS 4.2.2.7 expects source to read Detailed Capabilities Info : 00080h-0008F.*/
 		union dwnstream_port_caps_byte0 *port_caps =
 			(union dwnstream_port_caps_byte0 *)det_caps;
-		core_link_read_dpcd(link, DP_DOWNSTREAM_PORT_0,
-				det_caps, sizeof(det_caps));
+		if (core_link_read_dpcd(link, DP_DOWNSTREAM_PORT_0,
+				det_caps, sizeof(det_caps)) == DC_OK) {
 
-		switch (port_caps->bits.DWN_STRM_PORTX_TYPE) {
-		/*Handle DP case as DONGLE_NONE*/
-		case DOWN_STREAM_DETAILED_DP:
-			link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
-			break;
-		case DOWN_STREAM_DETAILED_VGA:
-			link->dpcd_caps.dongle_type =
-				DISPLAY_DONGLE_DP_VGA_CONVERTER;
-			break;
-		case DOWN_STREAM_DETAILED_DVI:
-			link->dpcd_caps.dongle_type =
-				DISPLAY_DONGLE_DP_DVI_CONVERTER;
-			break;
-		case DOWN_STREAM_DETAILED_HDMI:
-		case DOWN_STREAM_DETAILED_DP_PLUS_PLUS:
-			/*Handle DP++ active converter case, process DP++ case as HDMI case according DP1.4 spec*/
-			link->dpcd_caps.dongle_type =
-				DISPLAY_DONGLE_DP_HDMI_CONVERTER;
-
-			link->dpcd_caps.dongle_caps.dongle_type = link->dpcd_caps.dongle_type;
-			if (ds_port.fields.DETAILED_CAPS) {
-
-				union dwnstream_port_caps_byte3_hdmi
-					hdmi_caps = {.raw = det_caps[3] };
-				union dwnstream_port_caps_byte2
-					hdmi_color_caps = {.raw = det_caps[2] };
-				link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz =
-					det_caps[1] * 2500;
-
-				link->dpcd_caps.dongle_caps.is_dp_hdmi_s3d_converter =
-					hdmi_caps.bits.FRAME_SEQ_TO_FRAME_PACK;
-				/*YCBCR capability only for HDMI case*/
-				if (port_caps->bits.DWN_STRM_PORTX_TYPE
-						== DOWN_STREAM_DETAILED_HDMI) {
-					link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_pass_through =
-							hdmi_caps.bits.YCrCr422_PASS_THROUGH;
-					link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_pass_through =
-							hdmi_caps.bits.YCrCr420_PASS_THROUGH;
-					link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_converter =
-							hdmi_caps.bits.YCrCr422_CONVERSION;
-					link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_converter =
-							hdmi_caps.bits.YCrCr420_CONVERSION;
+			switch (port_caps->bits.DWN_STRM_PORTX_TYPE) {
+			/*Handle DP case as DONGLE_NONE*/
+			case DOWN_STREAM_DETAILED_DP:
+				link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
+				break;
+			case DOWN_STREAM_DETAILED_VGA:
+				link->dpcd_caps.dongle_type =
+					DISPLAY_DONGLE_DP_VGA_CONVERTER;
+				break;
+			case DOWN_STREAM_DETAILED_DVI:
+				link->dpcd_caps.dongle_type =
+					DISPLAY_DONGLE_DP_DVI_CONVERTER;
+				break;
+			case DOWN_STREAM_DETAILED_HDMI:
+			case DOWN_STREAM_DETAILED_DP_PLUS_PLUS:
+				/*Handle DP++ active converter case, process DP++ case as HDMI case according DP1.4 spec*/
+				link->dpcd_caps.dongle_type =
+					DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+
+				link->dpcd_caps.dongle_caps.dongle_type = link->dpcd_caps.dongle_type;
+				if (ds_port.fields.DETAILED_CAPS) {
+
+					union dwnstream_port_caps_byte3_hdmi
+						hdmi_caps = {.raw = det_caps[3] };
+					union dwnstream_port_caps_byte2
+						hdmi_color_caps = {.raw = det_caps[2] };
+					link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz =
+						det_caps[1] * 2500;
+
+					link->dpcd_caps.dongle_caps.is_dp_hdmi_s3d_converter =
+						hdmi_caps.bits.FRAME_SEQ_TO_FRAME_PACK;
+					/*YCBCR capability only for HDMI case*/
+					if (port_caps->bits.DWN_STRM_PORTX_TYPE
+							== DOWN_STREAM_DETAILED_HDMI) {
+						link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_pass_through =
+								hdmi_caps.bits.YCrCr422_PASS_THROUGH;
+						link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_pass_through =
+								hdmi_caps.bits.YCrCr420_PASS_THROUGH;
+						link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_converter =
+								hdmi_caps.bits.YCrCr422_CONVERSION;
+						link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_converter =
+								hdmi_caps.bits.YCrCr420_CONVERSION;
+					}
+
+					link->dpcd_caps.dongle_caps.dp_hdmi_max_bpc =
+						translate_dpcd_max_bpc(
+							hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
+
+					if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz != 0)
+						link->dpcd_caps.dongle_caps.extendedCapValid = true;
 				}
 
-				link->dpcd_caps.dongle_caps.dp_hdmi_max_bpc =
-					translate_dpcd_max_bpc(
-						hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
-
-				if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz != 0)
-					link->dpcd_caps.dongle_caps.extendedCapValid = true;
+				break;
 			}
-
-			break;
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
