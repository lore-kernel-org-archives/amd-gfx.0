Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6564C35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995362067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XEKh0gZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995362067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBED76F4AC;
	Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFDD6F4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc1Bk+KcJh/n0lWV/yE74z7ziEZqRDZBA5mvLI9YDQ5awOF6P2nfDxTjg9TxLN7LoyrSc9Ai5lxK+uqOEBbvPF75Q5IpKhvphUfwocqdWCM55dlmrEi/CJWEDLeGhvPGsbOexULnvvNdtX3OrMEbigBlqOY6M1QHTjknFp3cZ5nsAou5in01A4NzmfvJrN8nicF4q123kOr6TCF5VtIvE7q4ErJmKGZ2roH5AMzuG+bXBetpqoQn13PaIYAkOhSom6Cl1MvlAh+ZsyB3hANsN0d2Giv1EeaOlwGp4l4bibT6TkozhwaEeWpWPYCoK2H8/qm9QcE1yb/9zCYOxnV7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKl7WwJcpDv+1VZ6Z0uI3EZtg5VUd32/Ro0HVYFWWys=;
 b=MkUOlnwVtTiwG61KpheFO8fa0Dp3Jw0ofyowTcO5aewOS1cRcqme8mKalhD+09kH9gC9IVLHBq4cs9QhwigdEI7WfuYTIXK5WTJGyuhkg8xiY7qbBj6bkszufWxrN4EAeVcTW4SLETYBlCHnzv9SfcTPmphnYyMItMbz7VjA3A2JTkMtbhL9zZAjlKWm/wsIChu1T6LDHNwcFxRn5gmE7JP9wW3Erm+Y69x71GWvd4izeZSKwahn2Hh0LZliKIMiMoATxn+7vFfK3IXBfHTqc8ESu+AauJ81BWzUfVAkhEgPEEJga49vzE5IFAw126YPKQS+NnnXJ9XnnIZMU3w/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKl7WwJcpDv+1VZ6Z0uI3EZtg5VUd32/Ro0HVYFWWys=;
 b=XEKh0gZjU8gRpBnuaS8M3Hk23fHH9zL4mAxd25Ff+IIg0y9b7BZjrMMRHT3tXQ1+OWOViCLJfsH4XkAnjif22/Trjd6mJMqXjbim8i38Ag/jmth86rigobkR0UCql6KSXCMZ4Vdqld0AzOZ1hs7t7JW99u4eB6mkrRxnjpgNR/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:03 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/35] drm/amd/display: Workaround required for link training
 reliability
Date: Fri, 21 Feb 2020 11:03:09 -0500
Message-Id: <20200221160324.2969975-21-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 21 Feb 2020 16:04:02 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76b36fac-36b6-464b-384a-08d7b6e7ab92
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24090B438C573D3EAA3D5DA498120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZkaA3q/9ZQ8J1eufHa2Qa5kYL88D4M13YNiR3hE0Bfj/sMFHKLkZ1XS2P0r4CpW6VQkqsqWgEdTrHuvIQ3vs4pGy9dEBGzZ9L4WaSE26JFi/bZO4rto16NGUQ9uDk7BnzwSgmKMCIWe90XvvJWshi5BEL1wMzaCGCMRrj6eNefZW/KqugbpJ4OaKJSIbBEKtYoBcKw0k6qD4+4QX3lCUPYKvbDXdJH51FV8NI1QHQkaQcXEdjFua6kI0kHdMc4arhkKyD+FlR14wa55U+ILI8WbIfjlV18ZBBVxLh23LhZzCd9j4fn84M7Ni7HPBahg7fnpeNOUm5p3UjE714xvV6tsvDQ6zrPN/utzeJKbVJF3heAKzxeAGatCSizbWx8NksIQrVfB7OYKPolISl2AXNMd4QyGcaGA/y+V7p0vgiui/4g6QSNCnOfLs+Ul+43n
X-MS-Exchange-AntiSpam-MessageData: lHR0M3Jbvwc3Eu4Or8OmVTkuVvidH30rkXE2NpjRzLImtiFN78t7u8Chzq9eSs6L38FBh13OtgGWL+VLYRtJmTi9zgQyke4X/sgGz4L8pZdOMIggz2+I5uNel723p3E3/jMSWpm0xGnwAkZRsoDSbA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b36fac-36b6-464b-384a-08d7b6e7ab92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:03.0570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spqAJGRfpda44Ghw3q4xCVuL3svzTDHaWPtah7uJqqLBoB3KDPRFHrTChrDLu/lEA+kyImffhLwOHfnBzBsCFA==
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
Cc: David Galiffi <David.Galiffi@amd.com>, Sunpeng.Li@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
A software workaround is required for all vendor-built cards on platform.

[How]
When performing DP link training, we must send TPS1 before DPCD:100h is
written with the proper bit rate value. This change must be applies in
ALL cases when LT happens.

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c0fcee4b5b69..8de9d6f9a477 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -945,6 +945,17 @@ static enum link_training_result perform_channel_equalization_sequence(
 }
 #define TRAINING_AUX_RD_INTERVAL 100 //us
 
+static void start_clock_recovery_pattern_early(struct dc_link *link,
+		struct link_training_settings *lt_settings,
+		uint32_t offset)
+{
+	DC_LOG_HW_LINK_TRAINING("%s\n GPU sends TPS1. Wait 400us.\n",
+			__func__);
+	dp_set_hw_training_pattern(link, DP_TRAINING_PATTERN_SEQUENCE_1, offset);
+	dp_set_hw_lane_settings(link, lt_settings, offset);
+	udelay(400);
+}
+
 static enum link_training_result perform_clock_recovery_sequence(
 	struct dc_link *link,
 	struct link_training_settings *lt_settings,
@@ -962,7 +973,8 @@ static enum link_training_result perform_clock_recovery_sequence(
 	retries_cr = 0;
 	retry_count = 0;
 
-	dp_set_hw_training_pattern(link, tr_pattern, offset);
+	if (!link->wa_flags.dp_early_cr_pattern)
+		dp_set_hw_training_pattern(link, tr_pattern, offset);
 
 	/* najeeb - The synaptics MST hub can put the LT in
 	* infinite loop by switching the VS
@@ -1434,6 +1446,9 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&link->preferred_training_settings,
 			&lt_settings);
 
+	if (link->wa_flags.dp_early_cr_pattern)
+		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
+
 	/* 1. set link rate, lane count and spread. */
 	dpcd_set_link_settings(link, &lt_settings);
 
@@ -1654,6 +1669,8 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 	dp_set_panel_mode(link, panel_mode);
 
 	/* Attempt to train with given link training settings */
+	if (link->wa_flags.dp_early_cr_pattern)
+		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
 
 	/* Set link rate, lane count and spread. */
 	dpcd_set_link_settings(link, &lt_settings);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 5f341e960506..6344de3ca979 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -135,6 +135,7 @@ struct dc_link {
 		bool dp_keep_receiver_powered;
 		bool dp_skip_DID2;
 		bool dp_skip_reset_segment;
+		bool dp_early_cr_pattern;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
