Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A214C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D453206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1HafdJuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D453206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD6789E47;
	Sun,  4 Oct 2020 17:19:18 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680059.outbound.protection.outlook.com [40.107.68.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDB189E47
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHrThCiZQb/IejwBFHjM6QcIZFh5GEkuGn80L5QppwtzVPFClMmYobWvXm/vvmey7pD87HVf/WWp70Slah3jV02/rmhqrCd/hOXYmTqBoT2iXJUSCe0f58U9WDvueogep8hcHNR2lRAVRiWTRXgApY9/Lx/mzgR7PBC6fl+xypPF6QdMN/+aLjUK0Gws4AESLYeJ2k2CsQwDdWk7vix9ClbP6yW5fNTyStFl5zBbnFF4sk8O//EuNPrKF4izjVXmVuKfPu344YOQnXIL7fRmcVHgMmvcJbDgkUGsCSnxGhOENfd6cue/f+swiibO7PwTlCAVaFHz6B+FfUbPrIKYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0jNsYqmbXv4UkUfUnevAZgKYDYpDlul8cypUj1TDng=;
 b=LP5CN7/hqlgSD+UmS9tvl1m6+GjWOovNVh4TkJCD1CWiLxCeqjKnWJNb6uUzWi7QUg2VuBoYnt1NxPQepBLNzaWRPQD00BUcGYlOa9zjriq67GepBPdtiMWQjS1ObLL2irUStc7rcQAytEAyHBUEouYuZCiVMBC08C8m4rk8SAeffgEmApkSnJTacoS5S7w5snXuiYMIw08HuJz9FOecg9H/3HmZEU2h8u5r/SoxwhJ96zqzkd3Bqq60qbp7PGoIk1HkyS8mdlBs+DZ2Nv8+vQr/sQeo6zjTysOGRigLqgvqEA2tkbWafU7JdvuwFeb+jTf9FcUvI+bXBR96azoNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0jNsYqmbXv4UkUfUnevAZgKYDYpDlul8cypUj1TDng=;
 b=1HafdJuJZ9U3mSS2tD6a+15kN8UyEsLZQeVYi+UkjFyZ1Zz/MYjgQr2TaahUvJjxq8IEYCgk5/MlkltiYy62ETzdlqOTgm3cIYKi43G+GQ0wKQRsilTPrceywl+aABW1wcOK9v0LEwow6/m6JuRj7PkXZTOEKIiRlIRhrSnO6xs=
Received: from DM6PR10CA0002.namprd10.prod.outlook.com (2603:10b6:5:60::15) by
 CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Sun, 4 Oct 2020 17:19:12 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::d3) by DM6PR10CA0002.outlook.office365.com
 (2603:10b6:5:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:11 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:05 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/18] drm/amd/display: Change to correct unit on audio rate
Date: Sun, 4 Oct 2020 13:17:59 -0400
Message-ID: <20201004171813.7819-5-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae408a50-454c-4720-419b-08d868899ceb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055300BBC2C968D758E0661E50F0@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bG/BXI/FK3wJXKGVI/m5RSHr4+b8c0IRzpQqF0Zm3b8O5C0ZBBDkDGk8eNJ+an0xJt9qYScMxrifVWNdWc5fqDwg9KmpDx3CugT2mHlPN9Xf6WBx8q93Gxj0WYtg8DVHJNaX5DPpCRYR0jCQXvSf2/oRZcYlgXv1ZwaxVwt+dYMu6JOssHEgZhl73cafgFgizQJZYD2QaIpKQ8uUovMbGxsaEUFjWbe07Vx+67FRv6xISM2U3BvMIbeRWSrXrGtBgG/13bhRot5CUBOBAMmKtJnPl91Qp/PgsgoJy45TbdxAyIoNEJrkMomdvqVzY8aJ1q1mWAB00D3miF/U5sz0rKRBK1S1Dw2m+rZBqE5bVDRy4E9czwnhAnNBLVke6TVDgU4vGkRH63qIOUfqFe73gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(46966005)(2906002)(8936002)(70206006)(186003)(8676002)(47076004)(83380400001)(36756003)(26005)(336012)(1076003)(5660300002)(6666004)(356005)(82310400003)(6916009)(426003)(82740400003)(81166007)(478600001)(316002)(54906003)(44832011)(4326008)(2616005)(86362001)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:12.4497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae408a50-454c-4720-419b-08d868899ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>, Eryk
 Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Formula uses kHz in their formula while our driver operates with Hz.

[How]
Divide audio rate by 1000 on the initial variable that is entered into formula.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index bf37a229a342..d50a9c370637 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -150,7 +150,6 @@ struct _vcs_dpi_ip_params_st dcn2_0_ip = {
 	.dispclk_delay_subtotal = 87, //
 	.dcfclk_cstate_latency = 10, // SRExitTime
 	.max_inter_dcn_tile_repeaters = 8,
-
 	.xfc_supported = true,
 	.xfc_fill_bw_overhead_percent = 10.0,
 	.xfc_fill_constant_bytes = 0,
@@ -2203,9 +2202,9 @@ int dcn20_populate_dml_pipes_from_context(
 		/* todo: default max for now, until there is logic reflecting this in dc*/
 		pipes[pipe_cnt].dout.output_bpc = 12;
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-		/*fill up the audio sample rate*/
+		/*fill up the audio sample rate (unit in kHz)*/
 		get_audio_check(&res_ctx->pipe_ctx[i].stream->audio_info, &aud_check);
-		pipes[pipe_cnt].dout.max_audio_sample_rate = aud_check.max_audiosample_rate;
+		pipes[pipe_cnt].dout.max_audio_sample_rate = aud_check.max_audiosample_rate / 1000;
 #endif
 		/*
 		 * For graphic plane, cursor number is 1, nv12 is 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
