Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED4C35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB906222C4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nO+JUGqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB906222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32176F4AD;
	Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BBD6F4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YySCmbW+uDmJ//yRvfBsp9EQwDRm9nsV9JmFhZMsZ5t0LaBIB+HIgGH96kGpAtZTB9Y9jA69pUP7AaWktS/obrEYX45fQ+eC/4vcu1R8yEcUiGlnVCqR3kWJ2/Y8cSAs7wtl0uuJDnEchU1JwLHAc7wIEeq0lvfdE3LifkJL0E6KGMMMPlDe6syjG9DFOmjVCUCtv2D6dd+RkCPC84cF5u6fU85ynju1moOIfsSHtdxcCUIXz36i7DCeXHD0WQXXJX0o4eRM9Wi2jWkJSEXB0JSv+LHthWnuZU3bgaaTFaRkD1Xzz5FaIzF8PnxIJhHReJKoDQwIL0NSD0LyHsedBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fErqwbife/xxSTWXqN63uh/WbkZB+g9tOk/C65ohNYI=;
 b=CdPm/QhGhWbyw8IJJOL79XW5eBz+L9h/6xEi8wckUp3bGnF8k/zCdkRKR4i89iGVApCCpt44RaNOBTeg3czMnIfFSNJwRdKnMbW1j0j/ydkfi0XrStRvxDudMpGAw51K/P3D+XP10dg/C8IoKkhssJmHSmwTAIBTYU+z6CDf5sZq2Q+xQbaJUI3EbPhfz6aLJH1kjx9AJ4uM/yl9lcNjiflLq6HdHQwg5gDTiWxVCtLiUF/HrI8DYG2WVu2qW/CU5NuGMYydeIRN5agHQXDyX4SsC7AUjAA+NbJsdBANptXIRfE5h72rOmxJqI8OJ37XSTiwQ2Cn9qgWPD+DFadFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fErqwbife/xxSTWXqN63uh/WbkZB+g9tOk/C65ohNYI=;
 b=nO+JUGqyZC1OJUK7lOanUAwr/74WCHkF8OCYmAdi3ohIeNs5/PoYkqGoyCoT2iQgq8nobfBYY6h19Bhy6AURYVFR/NvulP7/13SnrgAg3JTm1clOFqnpqeP2jjeSR3UxNpAB2YHZ/2KCzFHNvmA0+4q8563KljhpLvFEha7sajA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:04 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/35] drm/amd/display: Monitor patch to delay setting ignore
 MSA bit
Date: Fri, 21 Feb 2020 11:03:10 -0500
Message-Id: <20200221160324.2969975-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:03 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa4e7ef5-3f85-4087-3175-08d7b6e7ac32
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2409148EBA2FBF9B0BC10AB798120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NltUqVVnoPzB2OEpoWB6hRn3ku7tf52wGQb9oTPF4J+V29JpLB4TK+B3FwiWhsaB48pSQ9Stv5ujSUBc3HslU7iKaVmLVXxdqC1O+XJHx53qb7sgKJ1FedUbshsKLkhRlwDG/FMP2jQbvhc7sT9RaIJf9Rw4g5qEP+94R6OGmvqjtVSOGZbAl/g6T2Go2MkyPCWKiUUh0gQvM95POYC/RW01FgeJMILnmPxlJpymYZ5t5niJ47D4nm4x0YJgqGrj/MYn0nxHB3X3YJvcu9rPFS2hETbkM1OXjnROHfkwP3tJR4FulfoZWdV58GKkhNOpzjVLcm6SpAUVDY3NmLN0GSVp57pnxDYky9rI3g5RHcOxbwONtpzOt9QARKFsdf4Oo6p+fuy2be9Xh6exSctct2lvRZMAUAp4K+vI9XJlPjfBdoFha4QkGD8BuPhAm97L
X-MS-Exchange-AntiSpam-MessageData: V1s2PLR4sfIszo7GGwbGlBAFnY3E+dDvPEnp3W9dR1IJrQRki9uUDHP2vSi7UK66CPEqtaZq/E6r/tDqE9WxGKyoyYEgtcN6fKnsoYLBEhF6UT5ssdYDM45Uvcg1J11jpdbvdI7qrFuxFG1CsigxGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e7ef5-3f85-4087-3175-08d7b6e7ac32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:04.0614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYP5EJ9HIzodRPe753/54zqqP5GhmZkjfZxVOn6tT+WnyFvR23LdPoISfMC2og74+vL97ihvLmebf/i7+egYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Jaehyun Chung <jaehyun.chung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
Some displays clear ignore MSA bit on mode change, which cause
blackscreen when programming variable vtotals. Ignore MSA bit needs
programming needs to be delayed or re-set to be retained.

[How]
Create patch to delay programming ignore MSA bit after unblanking
stream.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a3bfa05c545e..3420d098d771 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3095,6 +3095,9 @@ void core_link_enable_stream(
 		dc->hwss.unblank_stream(pipe_ctx,
 			&pipe_ctx->stream->link->cur_link_settings);
 
+		if (stream->link->local_sink->edid_caps.panel_patch.delay_ignore_msa > 0)
+			msleep(stream->link->local_sink->edid_caps.panel_patch.delay_ignore_msa);
+
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			enable_stream_features(pipe_ctx);
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 1490732a4b44..299f6e00f576 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -230,6 +230,7 @@ struct dc_panel_patch {
 	unsigned int extra_delay_backlight_off;
 	unsigned int extra_t7_ms;
 	unsigned int skip_scdc_overwrite;
+	unsigned int delay_ignore_msa;
 };
 
 struct dc_edid_caps {
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
