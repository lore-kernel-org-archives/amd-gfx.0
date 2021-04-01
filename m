Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AAEC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7C26138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7C26138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362FB6ECF0;
	Thu,  1 Apr 2021 16:46:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CF86ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGCojyKfOq0SZxdjHrZmRwdY6kgpOSFws9iMcsGC2Siux0BZxfZXhkwOXs1tUeEYkwr4iL1VIzVbYdEHtrrRVnScDg1ebb7yqwKLw2igJEZJQQl5NY5vea+gwbs0cFHNhr6xRnOC0MBKTc3qZe5ZAYOMzVWLh84pjwgLkiy2I6yDChyI6/1pspgpg4l1ZwyjQlCJy0t2/X5clsTfyGtNaGBK6yanBMU8xfNQsqiqIHU9XBcIExVvJuQTqoktphaTJ7JJ9LVyJpQACj0HOY0hBVYlahcYv5wTuH5YJzjuxinfkb4dFihE/j/SWItpqpUK6ZGof6t+YEY4xDcQLczOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EgfGW1HTMz8FaZd13PSCL9S0Sj3wo5oNs0HNOefgXs=;
 b=TcsRpvD01OwWbE6djaCYxpCqepWN6VKRfOxmp0FEG2aucFpDGp5HtSPbq0U5NKpeFJOWOktBZ/iIpdRi4gIHnSommnUYBw8cS7GF5kankoUBh2n86dBnr6bkaFkbN5uz+mDQOQknqDuSogHAZVT5a6Nh6ifEeSiR8MvRAxHxOdgi6IXqjUGLawboGTv2RrGAmlZ5alUSImv0cg6GQRyvcj8JHLXZqV+uQFy30BIb2oiqhUKUSxSi7dYnjiwRS6CsUxKPxCtzs7HygcCYouvCqZVpP0Fi/aSuQfzt9a6xrQafLgFsn+LsBWIWVwSY6J0YCP5gBiqfnz/HPUZDNZZVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EgfGW1HTMz8FaZd13PSCL9S0Sj3wo5oNs0HNOefgXs=;
 b=jwJSpBxw8OPLIaR5JhzfCjalFJ7CLSyVnu7LdVHNJIlajVvHR+5B1TiVDtrWmFcxdzGv2nYw/U+kzQ2rwfqz1Bk/Eq2Q/GwRsctZNQ9VZ/UNAR046yt2UHNi2E0jiIee+9ElxUAR4uAK5y0AvxLCw/vVYY38rcnI1UrvzGC/cgo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:11 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:11 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/21] drm/amd/display: Cleanup DML DSC input bpc validation
Date: Thu,  1 Apr 2021 12:45:25 -0400
Message-Id: <20210401164527.26603-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778d52d8-68bc-4ebd-e5b6-08d8f52da7c6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11488D5653EFDA139B8C38C1FB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xj6pZlZz2zTa2GwpobLkenECWyngBB4jH+qenhAKqq9mOX08ie6FfcPsbapav3a+u26/euf/VHwxbf491LGvnjnBF6bhQeW+tBxDDClQn7HdZrvM776SvRODPr8nBaz0KilIKtJz41hIF2Sfir+Ukokk5B93KYK5ruhB5Wzxmpxq8VbENZWkO2hSdX+tHC7txCYy1wBCi/aLPiusaV0oE+Jjt3LsaZYUDRNwtVXwVZMxZza6WVBh5gDxuIRmMvWc/4zPXb8uYG5wIX63U9ImUIZOPOEwpSjjvmDoulic4NhvmSfvjVFjuie5RQZSPh8aH9lp0f0AKvbNwXWmY5WHbFMZS9WcFNf1o23c3jfIhLtcCyu1Kq6DLz6wP2j7I+n/tvu9CspWFyzKBeCSTadaKlXHfZIRZvr0p+mwQHNnNQDG0/Z02FPDEM3b3Z9sgm0012PwYqbON6YAi+h/F1wf9qHcvuc25WFnY0Pa6+kQaypizBpQHU8qXQ8gDqqN5AokT5v9tzC6AIhr1ZSV+E8e4bywJLrp5+IRtnGp1bjAFQuOv7Kfs2I74ue/wqbll7FaPLmel3Z8ROTyCoPxBF+WQ5WODIiVFq8dol5BRL86KF3YQ4ph3IknXGJFGaRdUNnOlhrDN2NsQpbc7M6TrQQ5XIjfGO6CqVjzvymxbBnlzWnaYw0Q2vc8TIxsImVD+Rko
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SwfluEmaDB2eDZlE5jOgdbdcpo+KmgVfpU91FnfZoVG/sQqj3q2sRM/wI7ZE?=
 =?us-ascii?Q?fgYJMiTPo24XKNFpVWadKu3rOdEdyRxEKBBTE+gse/5hMXPV2ROvguO1G3LX?=
 =?us-ascii?Q?URyhBMomnIvVhAAbujxYidIwDVXXYQfkANLL4J2mEWwGlpl4old1SpocIeED?=
 =?us-ascii?Q?ROTnmvqJ2vN55OwC/VC/1esOKyyqhiBb51vAKWFpi7IFVaLmatuuQXdIT+HQ?=
 =?us-ascii?Q?EZYKX+RZawn3Gy+dsq2oh5NVngQ8UJjD0oW2EJqFKUNpUpiOJYC3kC2UQlNN?=
 =?us-ascii?Q?kRhkqnCrqGPWoAl7EZ31h28pnRysmT5wZ8Un7nXOZS7NUAEBVnHWnsLJ7PrB?=
 =?us-ascii?Q?BR1y9fXQw9x5tkKhHYbRQ7sNaHbV2en5wba5LdzJsVbfD16W1rzsTfq36eT2?=
 =?us-ascii?Q?CrPW4ZTffr3SkUWRaj/dXXzFNPCw34xNAz97HmyowPUNWTbqiNOB+1HRgMbF?=
 =?us-ascii?Q?De99RZztUFfPNHMDPJWmaf0wZE/rsGYSJpGUcXIk1abfeNrrvzN6XlxDeZtt?=
 =?us-ascii?Q?hQH9JM9RXEg6ayMLCFfJN3qOPHP3L5PigoJfVCwGJR36xfSUd646LGIFFp2C?=
 =?us-ascii?Q?MX75fUyiZt/SNLZgS/yc0WEitnk+e5hl93zwk7g5RvT1Ul4Z/ZgT0X76485/?=
 =?us-ascii?Q?FhUgaAzq5ypQNBDyThvLGfxdUuYobO8Q08y8Y37wa6hqNsoCLCE85arfsArx?=
 =?us-ascii?Q?YwKO2FEq9gPlY0i3qQG6r8/Nx7FSnnL+j41Dz31C6tzNR6Juou87FZibAGo7?=
 =?us-ascii?Q?bQM+pUmdXqLN192hkVBMjF3HzGJDccWT5SPRbfMOy1Sjo1GvUpIg5DwxB1et?=
 =?us-ascii?Q?WTwl1JubUSKI8jEW+U0W/odWzTzttwlZvnMsw9u+9OjM0RFw0M3rVOCNDe94?=
 =?us-ascii?Q?Es6X40qtoRFfqwjqzZkF4eVyPIVGvbZzJB48opoSzB33pxjb0pqPBcievE9k?=
 =?us-ascii?Q?I4P90WIHwLK5kxjkOCq1HomrduyiqJZ5Fp7Btv+7xP2gJ0EHEIolYDnQDLdp?=
 =?us-ascii?Q?QFxbtI90+T+tQ1AN1sMgVR9rBcdXTqVvsUukzL83y3teqxPuJYKGI3cy9CJ0?=
 =?us-ascii?Q?cqPfAMI3rUKxTXBG2mJOYmTv93Niv4N3vA6kQVRzLA0AdKvlvxavNJWjyK71?=
 =?us-ascii?Q?WSGIMBhZqlR9kg+WVrXYDOgL8KZ5HIQ3wgwwHssIfVkm/AHtocl23fBSdWmc?=
 =?us-ascii?Q?OxODGwMRvjR4Ywmh89XVxOe2haZKjUc9mT32zb79sYUCy1uQyY9OZK9yE+xw?=
 =?us-ascii?Q?3VzfkPgX/JaebR+3tQjF4TBiusc7YLRme92hwl2r/6G8kKsiUxK8LOxVT5zY?=
 =?us-ascii?Q?wGHL6OnUQQ71gysgjvExnwVj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778d52d8-68bc-4ebd-e5b6-08d8f52da7c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:11.2007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuOpxQGjwRvYSVL0Rk/bMlWVTl0octSbYtcgCbE7SaZham0nrj4xU3OTWGtF3yFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Pipe input DSC bpc has a type mismatch with maximum DSC
input bpc - align the maximum with the pipe input type,
unsigned integer.

When checking the type we shoudl also check for an
implicit value of 0 and align with what the spreadsheet
does - default to max.

Rename output_bpc to dsc_input_bpc to reflect what the
field is actually used for.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     | 8 +++++++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 8fb29f754e44..f65a6904d09c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2216,7 +2216,7 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].dout.output_bpp = res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.bits_per_pixel / 16.0;
 
 		/* todo: default max for now, until there is logic reflecting this in dc*/
-		pipes[pipe_cnt].dout.output_bpc = 12;
+		pipes[pipe_cnt].dout.dsc_input_bpc = 12;
 		/*fill up the audio sample rate (unit in kHz)*/
 		get_audio_check(&res_ctx->pipe_ctx[i].stream->audio_info, &aud_check);
 		pipes[pipe_cnt].dout.max_audio_sample_rate = aud_check.max_audiosample_rate / 1000;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index 098d6433f7f3..1f7b6ddf3020 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -226,7 +226,7 @@ void dml_log_pipe_params(
 		dml_print("DML PARAMS: PIPE [%d] DISPLAY OUTPUT PARAMS:\n", i);
 		dml_print("DML PARAMS:     output_type                = %d\n", dout->output_type);
 		dml_print("DML PARAMS:     output_format              = %d\n", dout->output_format);
-		dml_print("DML PARAMS:     output_bpc                 = %d\n", dout->output_bpc);
+		dml_print("DML PARAMS:     dsc_input_bpc              = %d\n", dout->dsc_input_bpc);
 		dml_print("DML PARAMS:     output_bpp                 = %3.4f\n", dout->output_bpp);
 		dml_print("DML PARAMS:     dp_lanes                   = %d\n", dout->dp_lanes);
 		dml_print("DML PARAMS:     dsc_enable                 = %d\n", dout->dsc_enable);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 0c5128187e08..2ece3690bfa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -164,7 +164,7 @@ struct _vcs_dpi_ip_params_st {
 	double writeback_max_vscl_ratio;
 	double writeback_min_hscl_ratio;
 	double writeback_min_vscl_ratio;
-	double maximum_dsc_bits_per_component;
+	unsigned int maximum_dsc_bits_per_component;
 	unsigned int writeback_max_hscl_taps;
 	unsigned int writeback_max_vscl_taps;
 	unsigned int writeback_line_buffer_luma_buffer_size;
@@ -292,10 +292,10 @@ struct writeback_st {
 struct _vcs_dpi_display_output_params_st {
 	int dp_lanes;
 	double output_bpp;
+	unsigned int dsc_input_bpc;
 	int dsc_enable;
 	int wb_enable;
 	int num_active_wb;
-	int output_bpc;
 	int output_type;
 	int is_virtual;
 	int output_format;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 94036a9612cf..2a967458065b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -471,7 +471,13 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.DSCEnable[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
 		mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] =
 				dout->dsc_slices;
-		mode_lib->vba.DSCInputBitPerComponent[mode_lib->vba.NumberOfActivePlanes] = dout->output_bpc;
+		if (!dout->dsc_input_bpc) {
+			mode_lib->vba.DSCInputBitPerComponent[mode_lib->vba.NumberOfActivePlanes] =
+				ip->maximum_dsc_bits_per_component;
+		} else {
+			mode_lib->vba.DSCInputBitPerComponent[mode_lib->vba.NumberOfActivePlanes] =
+				dout->dsc_input_bpc;
+		}
 		mode_lib->vba.WritebackEnable[mode_lib->vba.NumberOfActivePlanes] = dout->wb_enable;
 		mode_lib->vba.ActiveWritebacksPerPlane[mode_lib->vba.NumberOfActivePlanes] =
 				dout->num_active_wb;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
