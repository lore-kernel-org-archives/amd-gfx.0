Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49055C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2011A20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fraRCVoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2011A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CF36ED1E;
	Fri, 15 May 2020 18:13:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698606ED25
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/MCiKuBZgmEZP2B0CcaApcwetrTQRCBAJ4/nGvvJ/ip82mMLJxNRGkLRIwIyf7o3+Ia5fbcTU60NwCUHuOZiLhxVbj6XY+l4CADgyqqp0hNBRlFIzBbzJ0Ey7VRrHwrJZecIe5zAhK5uqHxHjH2+/3hnH7TupN8uwMgH4WaNkYxp0pJUt0aF9DhD7theV5x/X9afJ12p/nvdillnPsclX8OySvCVzAmElKDs9BbqEZF+T8O6y81fHWp+UTuRNEeBIPRpA76HDPA31n0qBe+va09sylJ0Hm7TDBGcF3Kmj2wSjLIKgbUQmYOUa7Pw3uyfHqReo5+eAj7eEbBnwb4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oagycIdNtymyz2qFdWIugIBIDBEGen7nZAhnVWBbqcA=;
 b=EdJui3Y5CARgVzeOE+gX52AKxouIQ69b8ruHw0cBE5p9QYk7vBceuPUi6jMZsQ5ogy9vwdfGXz3ACA6XkPNM4jZPVgs6YDiUrrsq3HwYAP2sgpIZMlC84ieoyreT+Xg2OY+Y1lQj0B0RABofToYzk4oF0mRNtda5LW7aCXO5XsNq7poVh2/YXk7kOPkYP83MrlBEitX1LI+Pa1grGkjWRNI/QKvc1yjSClejAA0XeYqZG+vUpLjS9XO5QSwN1e9x47DBFOpubbcW8Aou4dNJFwxrIv64OyDtaGkBf3ncemObOHwde6Q6weGk/Tzdqat/rLHcfCejuXIX4u1SOjV/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oagycIdNtymyz2qFdWIugIBIDBEGen7nZAhnVWBbqcA=;
 b=fraRCVoXcCCsIBlFJyKMeqqVEQPJsDAUkCcimYJ1wbJ+z3g0leAm6rHAdf+1JRJjvOS0U1GI/8y4aHnDzeZSRaLwPY5c675cNAOJIpMeUyXjPgS/ttSyzsV7olvIOhYlMWuwLCeJ8dD/RSw95Ew1hjPxLrHHLUKJeyK+Y+zzMQQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:56 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/27] drm/amd/display: Avoid pipe split when plane is too
 small
Date: Fri, 15 May 2020 14:13:05 -0400
Message-Id: <20200515181315.1237251-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:55 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 618a6ed2-f603-4f0e-32e9-08d7f8fbbb2f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB38481CFAEA88F38C1C6D8BE698BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE/pYPRLjxIo43iFOgLWUjlfAsgMRd8x1OuPQQ5X6/8JEddbqeB+AEHY656AenyQmqnZNJKTrZVj4r2kTnTQyelMVoG+ZgvFpEQygsNhGLxHlGIWicrIMAHrnE4jVVMwZAcEuWO7jdHk2pTtC47Lt9WPrjDhKWTptG96LK+R2bsa7/qpHHdodVA7Wy3SK4Su3jYcioRFwemqyjX1zjdqMohIncj2Ly+EVtyml0majgQz6VcQ9c+Yk2Zmsb0jXL0Bi8AW/545tavzbyTD/MohsMBPOSEzg5ZD1YMsgBbvEtod4bPkqwCEKikIZ5/XBf0vs/+Y8Tkc1x5m3WJHqZ191uqrc/K1xxPKTNGtVBP9EvQx656koP0e40wtGS7DHXxuYuANHBhW26I3XSlt2u9veiVdGtwha7mGYuMi++n2xtbB5djdTS7XXulB88qFxcb3JoROq5GogxbfaGOSst7tDyJn9aMPi3Gkaailamb8WTm76dGPijeK6cC5YfMV3yTijkQrZvXTG77zvME9x6zs+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005)(160913001)(15963001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lFLocY/qY1gug0Bxe+VF8O0eWzHnCj6ZG/PqXWBHZCMDy2i5Gp2epMdpTqaKE1+8/SmNloS+RxJsVUPRAmpU2UKW82WN07oA/njEHEWSR6Vgz/nRbf5ZWu4/RieE1C0M1PCIrmDM2aluqMl9yzUFrHZpcjL3ZYiodWl0ZwfPOITUpFrKa38RbkgAObd+c0c4jne86c5o8Z4xtQEnv5KVPOpXjqvtXPYa87OgCUWEuX5kq1nUttZ0y7/yz+aeOE633VZEcwhH4M330G+GUBZZm3BSIh+IRpFDagD4fF4wSfes97Ual7+Xlq39oZpp+oauTInUWmGogz1shuifGml7jPY9Sqcyr6HZIHo5hP26CEq7fcj7Mxcp7U7NjFTcOsVb5n0Ac5LICRYARi5/9/a5AU5Djf+2BLTNBzIYScBF4vs0u7wG65I0iT8lpmMtQAzGu1i6MrJbFBY2dKoagjHqo+S6Gn/Jue/InQnT9aPVgJ4f/ZH/WnhtWsxGHiRtKb3S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618a6ed2-f603-4f0e-32e9-08d7f8fbbb2f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:55.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFa534c6hZbE0Xy/V9Q6ysuVo/iyU2yKvylm5OcdSsjTEl237Bs0uEWZ+ikHkI2xCCYiwX01fOYiMNVWuBKdnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The minimum plane size we can support in DML is 16x16. If we try to pass
a 16x16 plane with dynamic pipe split then validation will fail since it
tries to split it into two pipes, each 8x8.

Some userspace doesn't check that the commit fails and because the
commit fails the old state is retained, resulting in corruption.

[How]
Add a workaround to avoid pipe split if any plane is 16x16 or smaller.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 21 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 14 ++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 3960a8db94cb..1e5a92b192a1 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -690,6 +690,26 @@ static void hack_bounding_box(struct dcn_bw_internal_vars *v,
 		struct dc_debug_options *dbg,
 		struct dc_state *context)
 {
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		/**
+		 * Workaround for avoiding pipe-split in cases where we'd split
+		 * planes that are too small, resulting in splits that aren't
+		 * valid for the scaler.
+		 */
+		if (pipe->plane_state &&
+		    (pipe->plane_state->dst_rect.width <= 16 ||
+		     pipe->plane_state->dst_rect.height <= 16 ||
+		     pipe->plane_state->src_rect.width <= 16 ||
+		     pipe->plane_state->src_rect.height <= 16)) {
+			hack_disable_optional_pipe_split(v);
+			return;
+		}
+	}
+
 	if (dbg->pipe_split_policy == MPC_SPLIT_AVOID)
 		hack_disable_optional_pipe_split(v);
 
@@ -702,7 +722,6 @@ static void hack_bounding_box(struct dcn_bw_internal_vars *v,
 		hack_force_pipe_split(v, context->streams[0]->timing.pix_clk_100hz);
 }
 
-
 unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev, uint32_t pci_revision_id)
 {
 	/* for low power RV2 variants, the highest voltage level we want is 0 */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d00de61ac720..99925079a55d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2606,10 +2606,22 @@ int dcn20_validate_apply_pipe_split_flags(
 	} else if (dc->debug.force_single_disp_pipe_split)
 			force_split = true;
 
-	/* TODO: fix dc bugs and remove this split threshold thing */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
+		/**
+		 * Workaround for avoiding pipe-split in cases where we'd split
+		 * planes that are too small, resulting in splits that aren't
+		 * valid for the scaler.
+		 */
+		if (pipe->plane_state &&
+		    (pipe->plane_state->dst_rect.width <= 16 ||
+		     pipe->plane_state->dst_rect.height <= 16 ||
+		     pipe->plane_state->src_rect.width <= 16 ||
+		     pipe->plane_state->src_rect.height <= 16))
+			avoid_split = true;
+
+		/* TODO: fix dc bugs and remove this split threshold thing */
 		if (pipe->stream && !pipe->prev_odm_pipe &&
 				(!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state))
 			++plane_count;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
