Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB50C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEB023B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEB023B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3716E9BF;
	Tue,  8 Dec 2020 19:29:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 858D66E9C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2KC8YSepsrl53PT7okgBjHu9HVTMuEftn4YjwS/PqV0/7hOcrpkW+ZyxUHVl1E879eK7vuw5kkHkx9c52Et3DoOB9QqTXC5c8GTmgcxU+B7OxRVChrc4A846KOndw7t8+t26kz87hUa3NDLqsCXiaKwUuonyGOAdawzfH5ni7WjeZzdu/ekNq1FKmSIHRL7BVJNPsSkbN4y5oDmP00sLJhFZ4VQ20uthcbi+/cq1z0DRt40LiaRcwOLe0t5+Yfd+30DO7O/cZH/mdppN4lhgLKoQKWxxaEVP1B6UpURp56YHUWYHvWfeOAR7fFWu6V3yzNevUoHusnYSB6msHTTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0P6iZdos1oP57svnZyytoCvbDQgHAldzaYqwM+vj3w=;
 b=ENtlNVrr9WJ+eMSeJLZ6/hjEpfLAlYGJVVuiXF9Zh2rs0pWS67uK3W31Kmh9AIOUlnr51fFLgbioBLh1hK/HEb52mDJJ8VLPBsBfbPm8k/Re2PVRMHjkMZ6fgAjY9uQW0OcL5HR5LZBpgKCJCgdIts97ESCRZlys11rxBi2GLYIAEzH+j/ad9arIUqklSUyI12suEJseDP9F2Ob+K2LmwqgmBs+nVdxfezPlZZoK/YZ7WJ3NDsUPIlAzfBXg/ZF3p8Urcgb3o4DftG63HmbZZTz6eGUsgDKXgYN5GWfgYJWgBc2AvIcz61mT7OxnDx0v7LHXeE4GcDX+GDUKL6cZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0P6iZdos1oP57svnZyytoCvbDQgHAldzaYqwM+vj3w=;
 b=sAOxxtOJbp44coMNzbXFb4W8ve42cpA+4LK+PVMKDdOJPfaeVcJhQIcSnlafioOQVd5pZ+6hFvKkvs/lSDtKaHLGjHqYeNMTQNaGPYyVvpeWLzC0FcB4PwDWVopadA9K2I4hSBJH1t56ITUcNCurIJF38rDHfJOCz81J7kO599M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 19:29:04 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:04 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/13] drm/amd/display: Fix cleanup typo in MPCC visual confirm
Date: Tue,  8 Dec 2020 14:28:42 -0500
Message-Id: <20201208192844.23580-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f387140a-4962-4fbf-6f7c-08d89baf85e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB433872F334575C713803B773FBCD0@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrWrjhGHnJ79Fh0Tcf8JEWieeaX1ZpllwZ6mQHxCBv5yspQG72cOl+XOg5AtSyYgus9LdNf3ApInBS6HNMTauXdaHHyive7nMfqoqiQb8+onomCZ+uxd0SauCcTFvEThRkxX4Be01jjSd7sRTYDQAK/uRxQL8DCGAVn8CsEXPVugrAfRdiP23bwj/RKXcUql4EzZTH89vzWtLtUQ7k2rpiKfzaazZYqFNyjdcxWF3t5V+va4Dlm/FEn9NGE/Reml7BENM15T0X+8QTo4oQIUgOimTSfKRf0Y5ZR4TImADECXQ3UIQ1BH8UxWmZ8v7MPIyzMoc9pIQQHPcF1/gcvCBM89BgJiOId4Kftt6xbIw20sSITjkdeZy38cVjue/uuaC1FfwChfzX5R5FLGGabZwqzSTC/HQM8RHg2tlFkQQog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(956004)(8936002)(44832011)(1076003)(36756003)(6512007)(69590400008)(16526019)(4326008)(34490700003)(83380400001)(66946007)(2906002)(6506007)(26005)(6666004)(5660300002)(186003)(8676002)(66556008)(52116002)(6916009)(2616005)(6486002)(66476007)(508600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C4pZnPM6+0A1yi0ed9YjC/oEJdfGq8hfG7aAYWxBmqsn/zdEUaxKgaE/HWIy?=
 =?us-ascii?Q?FjPVEl0IZSDW+9ZerWlj2tHu5EkD0r27eTfKr/huVFzRZ5JZjg+R+EIDTPTZ?=
 =?us-ascii?Q?WLCPARsUBtbnGF5DrQ25HhhCHJuS6rIYL12UrZ2TNyWKzBIR7iNcvHSmmtyY?=
 =?us-ascii?Q?Rblj+fIBtbcRUlF8KSsxY2eApW4LE1BY9JwQsQuOKOfcTGiJqG7VyiAxvRx/?=
 =?us-ascii?Q?HB/5eKp7a4DaTtzq87RFDrRhaQwRSEt37il7FYgstl3eFO65CIEHl/EDtk2A?=
 =?us-ascii?Q?qdxzN7HulGX3gkShZDaD60tP/WNb6eLQURihrIynE8QCm1wBQ1QrAxqqyJp8?=
 =?us-ascii?Q?/WymCfHSJBMHTZ0hImB6xQh5d5CutcmKi16h4ip/akRch9ylfser4lEDcuPO?=
 =?us-ascii?Q?HvvzIEy9cuc0JQyCMPSkfiOY/39T8E8fh683ZFOgM+8TpUAoZnlJJB410MSD?=
 =?us-ascii?Q?OBoYKy/49IlFC/dX4nwEN9MccD2eum4f0n5rBukfjSPGrjlTMqvwII77oLTn?=
 =?us-ascii?Q?+hlPrdF+RcANuz0OwRYhMc6oASmHRpHQJ0ocO0XArMdZCWf8N53hY+RVd79D?=
 =?us-ascii?Q?aVrCeeMxVRPg9CPQ/LuxdFN5l1PVcs4x2d05MwvWqJbWjNxiMqdu3A7b32cw?=
 =?us-ascii?Q?Mw4QCUXNotEynZJlNKu/0GG3eSkf7DMKFM2Hw0SC7Bt5F76Xe3eBsykUgMOJ?=
 =?us-ascii?Q?84Z4POyQkAIbac+SlRS4EM7NBuRZUGAtp/7DBclTv2OO5xLm7ZUa8jOxwe7a?=
 =?us-ascii?Q?o8TDo66fwx2Yfezvk1G/o5UPFJgZ/vFva1j64Jcpz1+wckweKcD3d1pFJmSN?=
 =?us-ascii?Q?PZ6q1akI1ChPdwsFLqbOlLIjyHm8LT7GipeO4PQQWRHPkrutVjdPfc7bMyQp?=
 =?us-ascii?Q?PGcuF2Ue5Tsjsfw3YWe2954bCsuc6N3L98mgKhCwKijErz0HV9JKyEE/kfjV?=
 =?us-ascii?Q?Oxh1bNC9VAqpnyaPomNSkOQmhwhQIgf3u2KHw+jwPRJh4iBc24Ik4F01UcvA?=
 =?us-ascii?Q?kBTY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:03.9660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f387140a-4962-4fbf-6f7c-08d89baf85e8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZTvMFjT2cmpTB6i83oi2QOGHyY6GBIi8lj+NZz9OliW2YAg3nvE+ELFAsOBesbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Typo in MPCC visual confirmation.

[How]
Fix to correct values.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cba3c8cd12a1..31a477194d3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2243,11 +2243,11 @@ void dcn20_get_mpctree_visual_confirm_color(
 {
 	const struct tg_color pipe_colors[6] = {
 			{MAX_TG_COLOR_VALUE, 0, 0}, // red
-			{MAX_TG_COLOR_VALUE, 0, MAX_TG_COLOR_VALUE}, // yellow
-			{0, MAX_TG_COLOR_VALUE, 0}, // blue
+			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE / 4, 0}, // orange
+			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, 0}, // yellow
+			{0, MAX_TG_COLOR_VALUE, 0}, // green
+			{0, 0, MAX_TG_COLOR_VALUE}, // blue
 			{MAX_TG_COLOR_VALUE / 2, 0, MAX_TG_COLOR_VALUE / 2}, // purple
-			{0, 0, MAX_TG_COLOR_VALUE}, // green
-			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE * 2 / 3, 0}, // orange
 	};
 
 	struct pipe_ctx *top_pipe = pipe_ctx;
@@ -2272,14 +2272,11 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 	// input to MPCC is always RGB, by default leave black_color at 0
 	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
-		hws->funcs.get_hdr_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
+		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
 	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
-		hws->funcs.get_surface_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
+		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
 	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE) {
-		dcn20_get_mpctree_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
+		dcn20_get_mpctree_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
 	}
 
 	if (per_pixel_alpha)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
