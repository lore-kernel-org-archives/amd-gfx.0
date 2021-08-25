Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E8C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 17:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5478861076
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 17:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5478861076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E515E6E3DF;
	Wed, 25 Aug 2021 17:07:08 +0000 (UTC)
X-Greylist: delayed 87342 seconds by postgrey-1.36 at gabe;
 Wed, 25 Aug 2021 17:07:07 UTC
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (unknown
 [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021FD6E3DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 17:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX22nHD6fkzHnWlLQ+v+2a7Enb0yT/2EqaOG+OFK6kJLI3uq59pxn2ErGgsTNEeaPsmfW4cJURBculUHw4KnZyB7r1Dlalbs4L1kdwv72OnHIQbd/BzTm7gEG77wh39JOEKnlN7xDWi8zXy/D7asux6hx/COV3Pr52RCeoEK2jEdkGnTVn22hBuiEM7g2NWr0FE5XonkoKIxFElDIlNaeLLvABBmrbq08/hV5SzyP+jocy/9dUd9TsBhB7ybM1azFIsZWXZoQXzf5s1AAFcezzLIX95GKX9wfh5I9pDx3p3mT93VrALGYtDyjz1Q193mvHy1aQI6g5HfEw2whnmrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxg0pivZCvCC8zJQcS/+uZEGTQA5XAaTZPrXPEfXoRs=;
 b=PEsRwM9zpJRauBhm+oHINBedEI+2wRHICFI3vnGRUJ806qoPN39QAjGgJM10V8L84Qjzx8ksDSagGs8YV3L6LpExMr2qcJf1KxcMeg2ynOVPorWUV/3TCl76FbBzVrHQ5dwvSou+W4KPqVpntteKUfuJLCIAd9I1HkaM62Mv9TqHUqA+oJUan2etpPoo6BdSNJMhnJWsFMasanZPoKHeHrmamLU84lRQRcG6Iy6vAsGO4et7a8NefA4ed8mozEICyfwBIK0Ii7RLhhJAk8qbYs5lNBSeqTaWp3nbFC+ukOAtxGhsBHTEvodRk8ToPpxLUr7uBKKBX607442FdhTLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxg0pivZCvCC8zJQcS/+uZEGTQA5XAaTZPrXPEfXoRs=;
 b=czRaP3aLwU1m4xThiK3W76gx0DMOyGbLWqN5uWTHxZX33ddeKyGIv5aMlnh1ft21LOxBU8vEVjiumQ1A7gepK2RGS4cOiugS+TZUvHzRc/iTcoX6exBDTAgdXlZRobv51sY600cL443V159xcMlDrAxm/1NxQvafPavE6PsWSjk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:07:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:07:04 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix logic regression in dce110
 apply_single_controller_ctx_to_hw
Date: Wed, 25 Aug 2021 13:06:48 -0400
Message-Id: <20210825170648.2567071-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.191) by
 MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 17:07:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 405221a9-e254-4f0c-6c8e-08d967eac2ed
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5301755008511DC0E52CC703F7C69@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0l7gNbeqyKFEEtCxJg1xUz2PNGohm0SubOFxRV+3z2l0EyksSDJql1OXIvfbC2EuudajiZojhlAK1Y4zyZh/1yBa9Wntohb/903j56XZlSXFBv6ng10o/3idWxdrIqwalGkdXYTD5LYn87jCVrtoVDm/v7ArE7L/MPSEiNybPawRlNgUFZ0gYkAZHgRlybrONI5ZDY6oea2dUo2mAMrMnBoLQOFaUWrKHdt+IWe2tGBD0Bwkm0uY4Ms7gj6di21waarwNmNcX3kK5KPsBWK+7DFjgzYUXvIbsDc8Crg4f6F5DznqMPykwDGn7zdx+evPX+E+RlHnzo7JjJIQRIX0h3hTCXYcEmrWUxJOBSfJhfcICk6UaK93KCkLxSSJASLM3l9e4jPhziBoZnQAJeaaUwInAt3Srfuf3vmrLPqVV4dVcl53TWsBqwUs3CQv9lB8LNhQBPR3epEimPQFWRQubblm3QyhGGFF8L8BlqEXtkBpZIC6mttOJDm1j21u6NUUQkmmSLjjdfTf61TXBUg/b9Ms2zvxU3P0HAD65JJNo8/vNnKr1/Xfkgn+TDeIsonzvM6xpLt6M99H4c+HounQeWb7MwzXGCOHvdeotHxP8Qf10VYb9GhCpzFPhAKMaHazfmFwWK6vtjG+d4lGXgA4G8Q06gruQQf7s1zVNovDKdQwVRzdAskekRPaHlw+/9g8QIrMi3B2ETLXyHL8e0tamg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(2616005)(186003)(83380400001)(1076003)(54906003)(956004)(478600001)(6512007)(6486002)(86362001)(8676002)(26005)(38100700002)(38350700002)(66476007)(316002)(6666004)(6506007)(6916009)(52116002)(36756003)(2906002)(8936002)(5660300002)(4326008)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SywWo+rgRxMyIx7p+1UKhbIDTzERjamnvxVZQC6VNEYhlGBLwIVHmprgRHwe?=
 =?us-ascii?Q?Z2AWuZuWIq5Mqo0S95UFX8mKI3Y1Qsm1p0Hy2tgCKC5L4jjAS+kmdGMnf1or?=
 =?us-ascii?Q?C1WotdYF5+DKq001l9ZW6PfR+ewdm2zadNyH5viFjbY0LU46FksxVrDVzfZj?=
 =?us-ascii?Q?2wyN4nma4BTMruRB9bfjn9bb1SKzehep0x9zIL0Rjm0gPuiULzognbPYDeta?=
 =?us-ascii?Q?AiunO2YyDFLiH9GTNtw5QAfH2+mZtjIHZdTX4eQoisd1DpqEsk/uMU+MFZxI?=
 =?us-ascii?Q?c+yY9RqCp1wd+IWS6PZbzLvkekVE1vwFBS7N+YVfCwgU7DCE90tKXtikJNX7?=
 =?us-ascii?Q?wGkTEQtlfP87Gm0dN8/Q30ryKNnjWPHz/G5C/G/V8Q+5U7av6pCBFGw9pQO9?=
 =?us-ascii?Q?NZr1CQ04JsZOBQf0yj9kbqEJvBAo9sn6y8y1ORjIR2zH3Cejcp0ics5lHRnu?=
 =?us-ascii?Q?0DWZmBnwqb9nI2OyfrKLXVSBvXur44ILLLvGu4HN4Z3NTHZXBMseUkS9icC6?=
 =?us-ascii?Q?jYttzQ25xnizI9WrjLoYRVZTRQoHEptQDOFXkFksEJqd13m8jQ3Wyvn9g1DI?=
 =?us-ascii?Q?VxypCXmW4mcFPA8jEGGDx0VsynX1AFMUOX5oFRkdyZjO2c2xJ3rs0ohIK8Yk?=
 =?us-ascii?Q?CsmbjUyrvw1Jphv0qqm1T5v9O5voAjF8vEW568TK+R7Rtl+55UkWCsArQFpL?=
 =?us-ascii?Q?yqST4gmaA/Yml3xzYMzI0wqxhScHXEDHtWGuqUpEW4nmDHi/Ju72j5j8hC4L?=
 =?us-ascii?Q?gfqoNLxin6rEk/GIQU9FjtnfbeAR5iQN73BwElEejfkLIEjA+YsZPU5DSzaA?=
 =?us-ascii?Q?bNZuAhiOCmXcyX7rolq4KMXtGRsse3MmRm7zmlUDKiawKSVMuY1TFWxYvPf7?=
 =?us-ascii?Q?1gWf0PTXU1ddg8icxy+jcU26529vOkOhTTB9xg1YGrDYhANKsu01u981sxLI?=
 =?us-ascii?Q?DgBWbAJsioRdvh36MR3XROFjzfxGaRvuQ8CgS6BrcHQRJ1C8niAZicxN5kfC?=
 =?us-ascii?Q?w6OW7dkdnaE8OCuTx1dMgDGE6S+MgkqipWnSxJRc2HPygvemeRdQTj2PT9dy?=
 =?us-ascii?Q?buTpMQ4PuduIbTeyP9DCoXVF9YaPsa6WPGgQgv/7gEHcHtPU3XTv32n6UJCn?=
 =?us-ascii?Q?Pv3zEqvpMn5/hhMAujt/6XCBWkZStiT2edwaSzYhSEjeXtQfLD2vmX3IoILL?=
 =?us-ascii?Q?OXa3ERlRvRyNXQhAdcGudOTeDZwCejUvMRN9AOFoH6TxFpFxAITspJFtQR5+?=
 =?us-ascii?Q?mea+zAVOXqCywrMi2nh5ItLKDEWGkZSTQrOigBLDKsXvHG/hJTDfj6WD6ctB?=
 =?us-ascii?Q?M8tyjVkEfbZEgDBFk6kquMR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405221a9-e254-4f0c-6c8e-08d967eac2ed
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:07:04.7640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSEB5fHZFJgNzKzHhjm7pOWdaIyeJckcDdtSEC58WpZQG5GpSVtl/CFtu7qo8j6RoKRw8JCpXTtFRUnmCCPdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 5de27e1d6755 ("drm/amd/display: Add DP 2.0 SST DC Support")
added a new check for DP 2.0 with a CONFIG_DRM_AMD_DC_DCN check
that removed a bunch of logic if CONFIG_DRM_AMD_DC_DCN was not set,
restore that logic.

Fixes: 5de27e1d6755 ("drm/amd/display: Add DP 2.0 SST DC Support")
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 33743dc2631c..f660472e71fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1545,6 +1545,7 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	 * function core_link_enable_stream
 	 */
 	if (!(hws->wa.dp_hpo_and_otg_sequence && is_dp_128b_132b_signal(pipe_ctx)))
+#endif
 		/*  */
 		/* Do not touch stream timing on seamless boot optimization. */
 		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
@@ -1558,12 +1559,6 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (pipe_ctx->stream_res.tg->funcs->set_drr)
 		pipe_ctx->stream_res.tg->funcs->set_drr(
 			pipe_ctx->stream_res.tg, &params);
-#else
-	/*  */
-	/* Do not touch stream timing on seamless boot optimization. */
-	if (!pipe_ctx->stream->apply_seamless_boot_optimization)
-		hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
-#endif
 
 	// DRR should set trigger event to monitor surface update event
 	if (stream->adjust.v_total_min != 0 && stream->adjust.v_total_max != 0)
-- 
2.31.1

