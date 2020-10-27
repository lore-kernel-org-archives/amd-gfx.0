Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C7C63697
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC82721D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A0nyf86C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC82721D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC036EC66;
	Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700074.outbound.protection.outlook.com [40.107.70.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E816EC61
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwABHIUXVZsQnHkgQTACK4RqIiqM3eub0FEGO0sUJusyV0ZzFnEM72mgzvmdSHiOAgLvSmT61vJm813SnUDdxBdoqxpFgt4LtuRBXv4mjBonqZP+XOQMYEZUUo1GqUc9tLUtzEIRsJh+W+RaszuUCu/VnR9uXASYah3OjXofNVfsyGs1L7lf4XFPJhZvMqR3kTxELF9R4iJhXkJvQ9RlPrcPNE0S4K/1JmqhX3HWkEGV1HX4Oba7hM/R+e3Gava/7dgfWWRUpHRhgG/ugvvIOGamWT4EtF7e4BmKPZa0gX3SmK3buU1qlHKLbj1VzE/1v+fEsXROWTWr/RkvzxitJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/yp6kOY9Lpf4Wj5mEshCjuAm56cJKIsJHNKXzkcDU4=;
 b=OSFepJ5mWVmSOnECWvuoH6vsKNyv5clfcCA0aSD2ZIGVeE2YmR6NuvLJm+OIzavnQ/2OJ+E2iSO934q64AxclNFd4nRVPvb7OK7IQdJzp/dTxArPsk0o3BKIBUk4fNLbzDr0mXXIqodl1/ZmTOxoCbcEPNnont4PQP5JBBvXVlqLje239lCOgZEM5wg1Ce2Tuga8WPl1puPKr08Blna97iRcWrbeEUUgZVPQPY6HvYD1ZFR10AoOYHxM5UgGzRGS3m+2ABeGkRyIKtGHOxKnnSoEZN+KYWsoYytGbulWTu8n90pfXNMaoHCutGCP+ePBEi7GmSxV3bxnqt9hqowhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/yp6kOY9Lpf4Wj5mEshCjuAm56cJKIsJHNKXzkcDU4=;
 b=A0nyf86CMLr5Af3uNz+8j5q9uxm1oeL8mfZRYBMuaEsF+2QBNGIuhBd+4Qp96RtUBikcjEWK1ERFOQrIIfNuvs+CUFpUgYHksUsTpwa8HR95DyaX0q5aAHi1jIqhuFoVAjRq7obAWY1feMODcecIBLkO/YsiKLzS3LJt+cIQXY4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:05 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:05 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/25] drm/amd/display: Revert HUBP blank behaviour for now
Date: Tue, 27 Oct 2020 16:52:29 -0400
Message-Id: <20201027205234.8239-21-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b142d646-1af5-4eca-7392-08d87aba48fe
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359539AEC175B4D5BF36059BFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nqwtanogSIwLi14H+EOjbM/7PV67TEzaqofQ9qwJcjf08y+l17etRPw6fegXSoZqwPGpdo1cT5tHrfTncH1Qwcr8sM5P7sS5dz7uRNP1wX1bWyUrCGU/Dvb8IjuXpbDcV0q67OIQ5P7tAydHrSzbLG1vanKcxpVfZRIg40B57CS53bBJE0rOYGeK9hMNGPS3hGckKCS/toWoAwbPbeeFwDxxSVhrCGRwEs/sz6+hjloMG9XT4v0SJrmNP0r2kGdZ8hplGlyWW7megNFThdtSPBZXCNkVD8Mnd4vfM4oqx/e3u3YLwGmrTa3dVGibSpAR5k1Ba/L3XztAlT6Bpwdoq+i8LFJOszsPVu8Siit6Z8rA21ZWpoLeYmuCp0jDWnX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: f/FVIuoVzJcNov5JSxcBZBrRhpWeNuxxM7Ya7UpaFwkQxa7PP4zuR5dS5OBhKQnLunPS/tv7XiLNDBzQgsWkBAWv842bHsVuvYpTuYKzacvQOEGUbhEcUIH7YGdcQ62qBtOYUm+5B7tb7InGCKPymTJRtpoxd536IJ2ec+J0kgmO2PdI+nT65IU5d0MqZzA4JB1Si48kYfKLtN7CG6lFsSnT/OsVOFCz0upT66I3oQxvm/d5XqgJL6k7s1BBFwHDbF/b/NHnA4ZYPZERzV1Afv0rfPR6djPXGAoY6XPv3jpHIYGEE0wIzDSXowvOTWPeA6fx9KGFMmWoaGFTal2grakFrIhXBgn6mY0S3qkgpda4OlcJH52KBTiL3BKYmKDxMKfrJGkseRy8Lh34aZoDULDmS4uIwIbZZKZs4glOeS+TsIz707EQSqA2BXDP9AeE2+jnlc63oRd2qAS3sXV2kQBuKfrC37TKpuqxVUnogBtMegwXl6NhdUQkjrCU312yHtDUqY332QFME3PCa4aNFcZwjaoqXQRMffglLCSU7MU51CdnJaP7b1j82lBhn1KqIl4f90kk0lEU36SY8ohNxLiGYI1oiBvvdxI8FslZGcGPSLeVYAoM9wOgufEwKeYC9lyNzxom24WfubX2F3xh6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b142d646-1af5-4eca-7392-08d87aba48fe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:58.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24ypEkYeClCA62LBmvtGslqwli9NRF/xNGX+fotkU6WWzDBUeMbPQWMwQfua0unm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Commit "Blank HUBP during pixel data blank for DCN30 v2"
modifies HW behaviour during blank, which might have OS
dependencies. We need to assess the impact on amdgpu_dm
and only re-enable HUBP blanking when all necessary
changes are understood.

[How]
 - revert functional changes
 - leave architectural changes intact

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 27 ++-----------------
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 6b6e92e261ef..a57e83428a77 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -809,29 +809,6 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
-	struct stream_resource *stream_res = &pipe_ctx->stream_res;
-	struct pipe_ctx *mpcc_pipe;
-
-	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
-		/* turning on DPG */
-		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
-				color_depth, solid_color, width, height, 0);
-
-		/* wait for the next frame when enabling DPG */
-		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg))
-			dc->hwseq->funcs.wait_for_blank_complete(stream_res->opp);
-
-		/* Blank HUBP to allow p-state during blank on all timings */
-		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
-		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
-	} else {
-		/* turning off DPG */
-		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
-		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
-
-		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
-				color_depth, solid_color, width, height, 0);
-	}
+	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
+			color_space, color_depth, solid_color, width, height, 0);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 50b7d011705d..9e0ae18e71fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5558,7 +5558,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		}
 	}
 
-	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
+	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0 && PrefetchMode == 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
 	} else if (((mode_lib->vba.SynchronizedVBlank == true || mode_lib->vba.TotalNumberOfActiveOTG == 1 || SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank > 0) && PrefetchMode == 0)) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vblank;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
