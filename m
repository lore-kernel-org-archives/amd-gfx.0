Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A38C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B44E2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m1O94G+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B44E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22836F4B3;
	Fri, 21 Feb 2020 16:04:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CE86F4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQx8l52USN2Gk8GbKbxektH2qwAnHzFSnngsr5642TJo7eNizd8SS9ZLA9lN3gNFbwoyZ2HXbr9+cIDG5Ry1yCbqKupy7JxYWZAWHo1/uqpKoOTN7JTnscoaGWHOWC55XxPJpFrYynegqDcc+mzM/Y5e2rZsKRHU1eF4mYYjeQeB5rKjY9tVPEtKQL+zYSYO5u57NpLawHRcyixqU/MkZiU/8xcw8s3k+7e9YbY7RDPFd/YOOvqL868HBbMs6lv3HzYQnP17LCYIfK2wmp49+aWX5dSxp3VzvWRmI6yzwKzqM1Qu/Z4HoolMkJXSvUWyrsrCeQVHmrl0fv1i/2gi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQcoo9ilpSnKiS6nrsoqB9eESrMWyOuXS3BgfOBpDlA=;
 b=jZJusmrky/sPA3pwkhVo15WZicticTQYETmy7ar3B/BucNDa7pprTikm2S1u7M1R372dFX1fJnSTfMaYXsiS+u8/XXGHXdH1Lu43PXkQEG3xVfYboAXvKSi465ZGjeLyTaVSEQ81XKZivqZFCSn6uYgBlcKE1gxtF+lncfGkfYEq10N3oQAosaQc4h87X7L5CYPnQJE7ourFXI/pDq2ide2IF+BNKjuFXSqeDHhmUaWOE3ZKDs5GmdmWiFP4Pa6zVDZnM9GmHvwELUUQdKkNzp0gYscGtXl2znxjtePE3JcbD5N9yQhenBN26p4HAp7MKIjkgLMqLyvKpeXFIt5d+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQcoo9ilpSnKiS6nrsoqB9eESrMWyOuXS3BgfOBpDlA=;
 b=m1O94G+v1dApYA+GqtNUfwEqs20IJAevCMA23bMXkF50Jqr7hQm2BrJN3sEf8R9WYHcBsz7OMGpKwsRsJCjdI5ETU5nLzsCbPQHzuCm5WX8HCTdrTelifEsr7BUAIoj6RQ6/DOvLvzeNLsDXnYelUM+QG+pWhZp4Nh9vbEv0APc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:05 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/35] drm/amd/display: Link training TPS1 workaround
Date: Fri, 21 Feb 2020 11:03:11 -0500
Message-Id: <20200221160324.2969975-23-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 21 Feb 2020 16:04:04 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9513788d-f8d2-4049-79fe-08d7b6e7acc0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB240930A06D63BA1CC630A31998120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
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
X-Microsoft-Antispam-Message-Info: lO+k+RyMIxS+79ymOWb4YsMeYKbcddP0Hb74cX1Q+22f58EjHpFIvn1gCD1POpmi270VfWkQRN8NtkzrUvUoWUgJJM5s5tpGhDPXAnX67xvKWLZHUU9YlA92zAHm13/VST3Xs9UZh0oMdMQMpuYZrrn/Qk4q7vR05BmS4zYYb1aJREr9eH+MtgtbRhhug0Bi5//bZSy8a7jFUvoGavd7X0OFp471Ur7clNhGAowQjGbd1og6PB5fOo55jrpK2HIV1y3RgPaxba39S5pnYCariaAWkq+KDE30oMMWox+rKy7qJw/z4zNMSFw+dP0+NhGJmO66thQetqArl+Il5erIMERkF3sF2U35sTPZdcFMJ9PqFizyZADDoEFdq2+L/cA/lLkvfusMbZzyqyGCvpj6Zgo8j1AD47yThvA9ORobgnILsgyMjFdBDiP6qF/B3GCY
X-MS-Exchange-AntiSpam-MessageData: ede2SHFDsLMGYAMV5twUjR2enyhn6WFDAkA2g2Or+3iBrVgTKwpKJuhwDG1yr92szd9WLNwKUcnLOupe0lxHnYx9zF921xlj9wyJwvxDRK9F3sVuK5GEl5gxwCXoKYbgLT+V4+shY9O1cjkNfGjBaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9513788d-f8d2-4049-79fe-08d7b6e7acc0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:05.0419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH6hMeoAMblzyPeckWl1faNRXlH7MpkM76XEr0wYx/UdivRVRx0PxZ6hrQXo/hIkxyOsemegEtc8tKxkWDSMTg==
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[Why]
Previously implemented early_cr_pattern was link level but the whole
asic should be affected.

[How]
 - change old link flag to dc level
 - new bit in dc->work_arounds set by DM

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c   | 18 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h       |  1 -
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8de9d6f9a477..93127bc90f3c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -973,7 +973,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 	retries_cr = 0;
 	retry_count = 0;
 
-	if (!link->wa_flags.dp_early_cr_pattern)
+	if (!link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		dp_set_hw_training_pattern(link, tr_pattern, offset);
 
 	/* najeeb - The synaptics MST hub can put the LT in
@@ -1446,11 +1446,11 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&link->preferred_training_settings,
 			&lt_settings);
 
-	if (link->wa_flags.dp_early_cr_pattern)
-		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
-
 	/* 1. set link rate, lane count and spread. */
-	dpcd_set_link_settings(link, &lt_settings);
+	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
+		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
+	else
+		dpcd_set_link_settings(link, &lt_settings);
 
 	if (link->preferred_training_settings.fec_enable != NULL)
 		fec_enable = *link->preferred_training_settings.fec_enable;
@@ -1669,11 +1669,11 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 	dp_set_panel_mode(link, panel_mode);
 
 	/* Attempt to train with given link training settings */
-	if (link->wa_flags.dp_early_cr_pattern)
-		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
-
 	/* Set link rate, lane count and spread. */
-	dpcd_set_link_settings(link, &lt_settings);
+	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
+		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
+	else
+		dpcd_set_link_settings(link, &lt_settings);
 
 	/* 2. perform link training (set link training done
 	 *  to false is done as well)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b3f6311d3564..72298520a303 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -126,6 +126,7 @@ struct dc_bug_wa {
 	bool no_connect_phy_config;
 	bool dedcn20_305_wa;
 	bool skip_clock_update;
+	bool lt_early_cr_pattern;
 };
 
 struct dc_dcc_surface_param {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 6344de3ca979..5f341e960506 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -135,7 +135,6 @@ struct dc_link {
 		bool dp_keep_receiver_powered;
 		bool dp_skip_DID2;
 		bool dp_skip_reset_segment;
-		bool dp_early_cr_pattern;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
