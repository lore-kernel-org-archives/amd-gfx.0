Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54977C47409
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5142082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t0sTOqgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5142082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2A26EA4E;
	Fri, 10 Jan 2020 14:47:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213446EA4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhGQShZjsXGpaPjovI42GGpj8yz/hpcK2yJDtOAkF/U1d6mxCEEgY/+DKtO69eWPTBnAasO+qUKOWh1GklHQcC55ZiIRBzmsXpPD7ZvjHXoMtY8IIsJf4WKZbNFWF2XXLMEp0VGmradFJFcI0+nDg3F3duLWcZuDvp7wsb5pYQWrDdO2gdNiCSMjPyYfyWZndT5fn80ymRk+QitzuO4G1zvly1YJNGkMp9whmNvwqo6jGCRdbWCvfjK3Fbw9igb82spT2KYmcOwMdEOpGawv8DMi8cVc8zMT4d1nhdDTMXnhW8xGbOQGddvH8+9gBDGsA/7HoBygiMyEyLtmYE5R7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xr9kQ3LazDZ15EC/vb06zWMIPLaWERgJcDC/tmOzmo=;
 b=i98o5c+OZnGsE+Hbgt/yH2ckYIk4sjYrp660rgBR+lYwIKQrEbxyv3r+CT1mWcTV8WYGc3LcWrA3ROvt+SJapFoyfOsW3BUxN63z8A+4nUf9YT03cUkCibQB5bMBE3LwcZhuS3bmj0GhLlhAT6KzihtwdbyZhUZC1VLQ61d6UESvEtjmbgtDv4htPpunQ79mng7vyqI3zP7Xs13igLF4Zf1/i1S93UdJdjMDD+v5vqgU6grdv0O9osWJYy5LEwATG3DEJ7BC94KkjAvnXlKA8JjiCj2KzR7vYcnN6tjXecKAbTh3RJfeEzexYZ6MtIZWHT0ckWiyKr+jhaAQIcnTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xr9kQ3LazDZ15EC/vb06zWMIPLaWERgJcDC/tmOzmo=;
 b=t0sTOqgRakKmj7IRJy7C6aKbBLDcKfjOOXiZIIusDh7Ud+9VPGHsKrCPEwq7FSIlHiL5DmPuYmvb+Gy/MYSsbMU+JbC+TEbCtYLLElNAchdKcyzuAElaPRIWCMRdj+GKXyzfxgbAv5tVqQR5LZx4dwUVBnXQg9i3p7GkFsTpcBk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:47:45 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/43] drm/amd/display: rename _lvp to l_vp
Date: Fri, 10 Jan 2020 09:46:40 -0500
Message-Id: <20200110144655.55845-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:44 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eda15da6-1abc-4886-8b96-08d795dc0de8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378F06B4C9E0AED898988CE98380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTYywOQFTWfr5/tRSqZmZh9W/FdCGi9650xdy9ojceqiVuXe+PfDDKdr6DE37cyhxv+RwxigdOGLcL+I0vDg3la3jus4ZRezBcXNkW8o6iV87z7Hq554mrVssl2iu0FDyMJ9sXwurZ7gwQo8LULDxanlqURCMjNZa8HlVi5OYGVnu/48ti6Xe2s7FYwU9Rt6tKYWNTgW+kf5Jrh3THps5mhMO1H3OCjXSFDgE+tn+yaaR9ShoCaToY0yi35hoxTcouz0FAS1ucyEgSBhuu0B5Iykt4KHBqhCuStA15/uBEL0UOQImDb2KmlGzkiKrW52QZZ3JeU6rzhK5kcA/A91zbeBg6DgcyjLkaDH6qTVi0Kas7ND4KIlMzlt2+u/SdHlJ13WHoHIl12t5nGUiv4yCmuV6tqCcBxCCUI76ADbg3ea6oB92Qh3UOPmPXqYwWeR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda15da6-1abc-4886-8b96-08d795dc0de8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:45.6821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORmlqlcLtdvriehq+SiLHF6DQIf82Xaj8EP+ToOCY4Hi4suZbtI13J2Ubs4BdeWfW8Krd65ea9T4wL/Pk4bJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 4 ++--
 .../gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 16559f7fb952..e7a8ac7a1f22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -937,7 +937,7 @@ static unsigned int CalculateVMAndRowBytes(
 		*MetaRowByte = 0;
 	}
 
-	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_lvp) {
+	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
 		MacroTileSizeBytes = 256;
 		MacroTileHeight = BlockHeight256Bytes;
 	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
@@ -3348,7 +3348,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 										== dm_420_10))
 				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
 						|| mode_lib->vba.SurfaceTiling[k]
-								== dm_sw_gfx7_2d_thin_lvp)
+								== dm_sw_gfx7_2d_thin_l_vp)
 						&& !((mode_lib->vba.SourcePixelFormat[k]
 								== dm_444_64
 								|| mode_lib->vba.SourcePixelFormat[k]
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index d6fedae03dc8..22f3b5a4b3b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -997,7 +997,7 @@ static unsigned int CalculateVMAndRowBytes(
 		*MetaRowByte = 0;
 	}
 
-	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_lvp) {
+	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
 		MacroTileSizeBytes = 256;
 		MacroTileHeight = BlockHeight256Bytes;
 	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
@@ -3385,7 +3385,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 										== dm_420_10))
 				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
 						|| mode_lib->vba.SurfaceTiling[k]
-								== dm_sw_gfx7_2d_thin_lvp)
+								== dm_sw_gfx7_2d_thin_l_vp)
 						&& !((mode_lib->vba.SourcePixelFormat[k]
 								== dm_444_64
 								|| mode_lib->vba.SourcePixelFormat[k]
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 5dcfbb0af825..af35b3bea909 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -1338,7 +1338,7 @@ static unsigned int CalculateVMAndRowBytes(
 		*MetaRowByte = 0;
 	}
 
-	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_lvp) {
+	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
 		MacroTileSizeBytes = 256;
 		MacroTileHeight = BlockHeight256Bytes;
 	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
@@ -3453,7 +3453,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 										== dm_420_10))
 				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
 						|| mode_lib->vba.SurfaceTiling[k]
-								== dm_sw_gfx7_2d_thin_lvp)
+								== dm_sw_gfx7_2d_thin_l_vp)
 						&& !((mode_lib->vba.SourcePixelFormat[k]
 								== dm_444_64
 								|| mode_lib->vba.SourcePixelFormat[k]
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index 658e0733b99d..bfc2f39bd1ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -85,7 +85,7 @@ enum dm_swizzle_mode {
 	dm_sw_var_s_x = 29,
 	dm_sw_var_d_x = 30,
 	dm_sw_64kb_r_x,
-	dm_sw_gfx7_2d_thin_lvp,
+	dm_sw_gfx7_2d_thin_l_vp,
 	dm_sw_gfx7_2d_thin_gl,
 };
 enum lb_depth {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
