Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C17C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDB32067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="blTojmBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDB32067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC4A6F4AE;
	Fri, 21 Feb 2020 16:04:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2145D6F4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8kF3x+hd8EGJnkGhbNVtFkM5RTh43MBt1ZDuLGQpSTXAcAcbArU/UeLXp6Xd5dfXlq4iKkESLc0Wibbf4OA7mqmCvLL8A5fxC3uGVko0qNV267VyOUzcc//XU/npZ6qgfZvMbqaxq8hSBXY4104ZlGgj3/mpxUkREnvPhIIZ7kUsLcGYbL+MhKNPdaExVT40NsSugv8ULrK0WDf93i34xJvhK2pgk24P+o5ysv8fFGDmLTZ9GmbhVblrPjowFkKt3aiGZwmkC58tqJS0MB7Gy5W676/+6TLLT9DFpb9nBhkvGGf3GnIuEkQ981NPNtb78mNbX6Vrsg+8bCL1InKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdpvyslDmMrpu9P+49Q2q0F560ovMU256BNCEbBbS48=;
 b=aKo20w3eAJpFDwJ6sOB+fneyRVU8mPrQgcPf8Vicuj3FuDrQ2JHoAf3fz/rfbuO5v5OVVab/Rj5C0546j8KhungBw11OwkLtmaCaIUDP2SufbogUKbMY7MjXj8cD9v0U/Bdr5t7oL3X1tj8WOCmMjcDVlhi4abNGmGbHNDrTY+8Mg2ZRgPQyWTt+UyCFGnEwCukFdQUOE2asuewMawxCh5GrBVMd8ZXM8VeAFhV9RNgJRSc1BxIk/nZ/1wxTb5YfTmPpZUO6U9yW8ID1El6mOaP2OUvMtQ+lFTVdIvgHPZY6+ygsMCk7Oun9B2E+1aSW9lJfeZ2D+ywEpQ98OrB+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdpvyslDmMrpu9P+49Q2q0F560ovMU256BNCEbBbS48=;
 b=blTojmBJpM5087izc4wzEARVHPqLHzF0E9nrNubTXJkqetNtwu7YUp12WQi73/jqmdCmSiMqw3eefvRuTyoIsxsSXqGj1P4CZJqSmYIpNS/qGQC3cC1SYNFNJSeWfOGB6LZhclKrpqP553Iy7i1NC7ucVtPQm/LeXgcMlgrhwIQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:11 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:11 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/35] drm/amd/display: remove unused dml variable
Date: Fri, 21 Feb 2020 11:03:14 -0500
Message-Id: <20200221160324.2969975-26-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 21 Feb 2020 16:04:07 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6c11337-5988-4eea-1e79-08d7b6e7ae7a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24090D97F3651337AD256C1598120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
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
X-Microsoft-Antispam-Message-Info: TgHyujruAKDM8MubBmxCOn/xAJufkkVWwLQSotM3lklus4GrnO9ciooZtb/z7F9hiaP3JVeNNs9eZWnIub/CCBXwAzledqCRUhECTdPQ53/XrwYJdVUQgatWsd/BDU29kkmfC/aDlqBEdPmzuPsUJWkAUIT+SQTt2xIHGXRmeOZLIhcvH1ZAwQAvpAxwWdMunmhC3wZYvyBQeoKWQQiE7bclc1erOPJ/P9OW1iTXIn/RfiZGCAGvK0et4FcisPVBNK+Yf1cSXA0V6K0Mz7kdOPpKNyVG5rcfYtb66DRCULe2hPTNMDkwZiepUm3DtBfaI4hzS3MRxakB4u+iQKp8EPBiVIdaLPQ+ybJSw2YQrEE/M1WpY20ZC3FIlLPdl/dIdGYDN1YcTpaZz2cPcw49MKaGG7ywB7tAseTIm2szZd9NVM4Y3GlgH/P+K0NGeQzZ
X-MS-Exchange-AntiSpam-MessageData: lTeL889nH5yNW5DyP9yUMM7QoUn6drmiTVK+Zppmbq7moX4KFVAOVlskjChsnmaKNacfNbcTq2jBgrAeWwdHc4nJDtPLvgTLW2Cs/a1YueCNm8wm9fD5N6ktjIT5MY/U9s6WshUb6vMIPngBO593Nw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c11337-5988-4eea-1e79-08d7b6e7ae7a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:07.8832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcaWZAUxBcAdaazh1VIZwiIRtSRfO9TjbVoP9aFy31EiQIs0UB+48Y3t6M5JbAI4/M4vR2MqVhK2gbmtcnxOaA==
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 1 -
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     | 1 -
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 35fe3c640330..114f861f7f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -327,7 +327,6 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int vupdate_width;
 	unsigned int vready_offset;
 	unsigned char interlaced;
-	unsigned char embedded;
 	double pixel_rate_mhz;
 	unsigned char synchronized_vblank_all_planes;
 	unsigned char otg_inst;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index e23fa0f05f06..193cc9c6b180 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -377,7 +377,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 
 		mode_lib->vba.pipe_plane[j] = mode_lib->vba.NumberOfActivePlanes;
 
-		mode_lib->vba.EmbeddedPanel[mode_lib->vba.NumberOfActivePlanes] = dst->embedded;
 		mode_lib->vba.DPPPerPlane[mode_lib->vba.NumberOfActivePlanes] = 1;
 		mode_lib->vba.SourceScan[mode_lib->vba.NumberOfActivePlanes] =
 				(enum scan_direction_class) (src->source_scan);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index cb563a429590..5d82fc5a7ed7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -389,7 +389,6 @@ struct vba_vars_st {
 
 	/* vba mode support */
 	/*inputs*/
-	bool EmbeddedPanel[DC__NUM_DPP__MAX];
 	bool SupportGFX7CompatibleTilingIn32bppAnd64bpp;
 	double MaxHSCLRatio;
 	double MaxVSCLRatio;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
