Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95760C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBAC22AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBAC22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1835B6EC7C;
	Fri,  4 Dec 2020 21:31:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0FF6EC7C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxVO7IZG+g+PPGK63ugMCIgKJ4asVW+iBgjS0IUbIyvtYOqo8wy+4rlUNXNqmxQMhSe6uHz5eCFjEJKi3CSi4v7GnnPQxQaO9l+GfApNslC8jt4zpWyUFFh2vJt/16JF1NxosqBCv0F9ifPqvdTxoIthhFS9BAdfhqmFgXiQF6yAaQCBy/DIPaNSPeFTlQIVbeNT50zVZyjzYOBaXY+Ng4cejc8Qon68+G4QLA9Rsc7ZQEsYz/FK3/CShMa/lb4upBsapwfbM9yTBMycaRDZUpvtIgc0/TDA9J9BEdwSJ89ifFK3Ag6N79KFECmoF2fcPeg9xvP3VB+9k9ySuNV6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WqMsxH50BeBV3acil9BglDuljRIWCPN170PJc/QUfI=;
 b=IVHUInY6J+arYTWhcwUQdI0bKHoPfmodkNS4bF6IrvODxvDweD7Q2Tr15dUwEkyVGWuWwy2IYCddxXaJzUoOcsDEi2xF5eslyzuSG0RZTv4KbJNWgrWvTIuhM4QBpaH0pyvBmzsE0MMyeYFbegerEYiyFgJ1zsFyBO7JD6/0fcxd41JrLwKjufXkNl+5fAyzrSBzTAmANF9IdCxrw0oIVwWajw9qErggY5OGOcAdlFwTGoQ6LQ7wqRtVVFbysi6KpG+uKcGLaD2xkoH3VxkzmV6UCnm4vN8CdkdN6yz2wzT6TP/wJD8amDpb8grix9BcPaHpkXjnsjrowDojgL6lNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WqMsxH50BeBV3acil9BglDuljRIWCPN170PJc/QUfI=;
 b=KaygMs+U4I/MSwGArCe1tQ5lec+qaDXCI6Qs7DEae4Quj51RvR4nb2m97HNnBwno7PoMcAy6pcNZpnuuBCI7d6UVoZegqG3bpRU1zBLughMv76rNjSzlHAEB2EmkJY7txlJI2Px9w4JpXdOb7sIYYYpS4kOnjLflMDw2tixjKkY=
Received: from DM6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:5:bc::15) by
 BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 21:31:07 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c6) by DM6PR13CA0002.outlook.office365.com
 (2603:10b6:5:bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:31:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:05 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:04 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:58 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/17] drm/amd/display: Fixed the audio noise during mode
 switching with HDCP mode on
Date: Fri, 4 Dec 2020 16:28:46 -0500
Message-ID: <20201204212850.224596-14-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f2d92ec-4b6d-4131-49e7-08d8989be90f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4851:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4851EAD5DC223063E9E230B2E5F10@BL0PR12MB4851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XK6v73k31G91bvYagFS+T96F54b8MfW8kQb+9nj9Q4nsJg9FgRMNndG8X6WnyvmYIhL5z9lmz18e3QunLwLLa4KZ2ha5I7JWp+3HfOjQ+E6xuKpTdbSDWiHqTCDM7dYO978k3nD+d2Xvb8iD+BReTN/jdVHt4/HgE/kLbcU+7Iu6dgCJkaJwa+tZEATN1JaJlhDmk7CzbFsecUcYq/ArHT2ZwiaWvAt7K/IM55TcB/s9zyfVvgOeM4vv5uY5nath66LMkNOWJMcsntQ4cxBxRq2CR0SmgLygcNaNLpTFhu62rzOQehtExvJOzEsh5doOmcWOwzuyXqOpizGLcW08RJrmqPUAACNtIwFG1MwcDIb1HBCbfPUBcEPrpzJ+xSYXN6qQu1CPPiA9FeOH3pNY6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(478600001)(186003)(316002)(2906002)(82740400003)(1076003)(83380400001)(54906003)(2616005)(36756003)(86362001)(47076004)(4326008)(8676002)(5660300002)(44832011)(70206006)(8936002)(81166007)(356005)(70586007)(336012)(6666004)(26005)(82310400003)(6916009)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:31:06.8892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2d92ec-4b6d-4131-49e7-08d8989be90f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Roy Chan <roy.chan@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roy Chan <roy.chan@amd.com>

[Why]
When HDCP is on, some display would introduce audio noise during
HDCP handling.

[How]
Mute before HDCP handling when disabling core link. Unmute after
HDCP when enabling core link.

Signed-off-by: Roy Chan <roy.chan@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 0052247b4b20..a901baf2aaef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3270,8 +3270,6 @@ void core_link_enable_stream(
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 #endif
 
-		dc->hwss.enable_audio_stream(pipe_ctx);
-
 		/* turn off otg test pattern if enable */
 		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
@@ -3310,6 +3308,9 @@ void core_link_enable_stream(
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 		update_psp_stream_config(pipe_ctx, false);
 #endif
+
+		dc->hwss.enable_audio_stream(pipe_ctx);
+
 	} else { // if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
 				dc_is_virtual_signal(pipe_ctx->stream->signal))
@@ -3337,6 +3338,8 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 			core_link_set_avmute(pipe_ctx, true);
 	}
 
+	dc->hwss.disable_audio_stream(pipe_ctx);
+
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 	update_psp_stream_config(pipe_ctx, true);
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
