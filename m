Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8569CC04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581A220720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CgnjD+T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581A220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D938D6FD0E;
	Fri,  7 Feb 2020 15:50:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353276FD03
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkZJVUjHMYg54h8VRZK59lBd8qAGqhbSuKdR/RhjszgcA23eBYUdAR9BZ7j3Kp1DdxOLjSFN6rkzM5Fq2Z86uNv8cI3ViG2w8FGziXF/5mhuguqn5ET0sCpholWh7Xj6BKlFK8BsfIHHP6uqi3q43oygZbiAdwmL2s0lbNIuTzuNeqPW2XCRskD2RJoA2QpeenFfW1s7dd/GMnd0C0DywhPsnB9hdrFy+mFvTdF5aKicRJlsEO4xtNThub3Zi4pdMU+dstJHprNPW7dsyRo+lFB7ebimVnTIiKRjclgcPQ1EzkOtW0zqWgzRCHrXnonxuzQls07ozQkbbNeT7rqt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8LMKQKG7rbKHG2FLlgpKlGMCFXQpRmFjhMSP36Tz8E=;
 b=Txv4ZVc2efNr20mqZ/GP90mL/L5rlqLo91avIPvCflS05FNV7htvQJe1eU/Jat1YYY7+KHNOrdh5TN7aUyvTBiIlBcKBbrtV3UmFyQGm2p4uXnSyTIZKlcjx7jXQrQpTTgwrRvubfHK28nWdn9SEYm9yb+W7kzoYSN7LJx7qpgkSx/l+gd8biPFQpz+8vXq4bt25W0gZy5cGGaLsSQFpVvznlJ9nnV3k8flfAY2QbulK+xcmQ5yhnf+zrpPPmnhinnUuUgRAwtsS2Z329AwkbqDMqnH6F3Ie+FoVTgKAsdiTQiUnSp+DlY3x+SbUHUv4YJo7FBk0CgdnWrqO/nMnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8LMKQKG7rbKHG2FLlgpKlGMCFXQpRmFjhMSP36Tz8E=;
 b=CgnjD+T8LWnMD3cTRpYKhehmtprzxa5Ydh5ilYa9HwqhVELmOAEgErQM2UgVpi20u0VJ4//fdWmNm/JyUJ8QmFRH7DIRIXeSIFSNlUELZiqGJAgKFqkZvI9vDFY3lDeKVZh5W0mcVW6IMHtJzL/HkJ+H5SK23bMZxNIoYCW6lvI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:46 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/17] drm/amd/display: Hookup psr set version call
Date: Fri,  7 Feb 2020 10:49:58 -0500
Message-Id: <20200207155010.1070737-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:43 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a4c960f-c35f-4623-acae-08d7abe57db1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440DAE4152318B298B9E2BE981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001)(52103002)(158003001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHSXK4UHzPcnLMFpzyWyqo0piM+xhzYMbNOR4E1ysNpgXB/cZxTe1vodXfEgVYl0nYnlcq9FAeJ3KS0b4BFiQcZDZwOlOB/MosFBfa0gGOfDOqKz5F6rvvj5K0cry9uI4+iJNsR2RIEv6Ff7QQPpBEMXMvqkydglv9zSVYoN8xmd81barRimRzNOzNmzj93ESGNpfizvYCYB3hXEfkZGF5S5DAOQATzbOIf/qTluV0Mu4JmMiGI34dvcYEZzZzMf/uoz0zlh2hf1+lT6VqAALQWg5sBypIQAMjc9m1nI+K8Nz0FDfqm9jlbKT1f4FsQDmiHJBXZQnXTpiG7+YZ68wmEORq1mP4Onvp/PbwiD3u/iku9/p4E9e3TCCb1UZc/QbRLJqqibMS6rDeubWl0ShFz2zkGSuMM9HP49RLZxsT4+yotSBndI/o+1CLTfFigTggntKhHafqhV3tvM1ErDjjN2tJcV3RD/nNhDu1AiUZNl48O6cp7XtD6aSZcQRnmlp4T1e+ZgoLg/h6yUhzwgIQ==
X-MS-Exchange-AntiSpam-MessageData: 7GVJIz1T5aN0XRmTTSd7jXjl1Iff5OK+75sT6g3IG1QJiz/aDLRzjqJk6uRRxpKLET0Xgv3fZH4DiM0gqBOz5vAxoYx+jcgC15lqX3hWPbRHDlFnKqwY038hWAF78PRPoVRhRuQNCJvm6dQsd/Y9cQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4c960f-c35f-4623-acae-08d7abe57db1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:44.3789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmOi8MWytceIC5DIF8n6k6sn6fj8fa75U3SuuoWlX4HVv1xt6YXE4+gDqLVSjV+p5lNoZhRlvXqR+feYKhhn8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Set version is currently not called.

[How]
Add call to set version from copy settings. This
should be the only time this is called as the eDP
caps should never change.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 17 ++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  1 -
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 59cdd8ea31fb..cacb46979f31 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -42,17 +42,19 @@ static void dmub_psr_get_state(uint32_t *psr_state)
 	// Trigger GPINT interrupt from firmware
 }
 
-static void dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *stream)
+/**
+ * Set PSR version.
+ */
+static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *stream)
 {
-	//stream->psr_version;
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 
 	cmd.psr_set_version.header.type = DMUB_CMD__PSR;
 	cmd.psr_set_version.header.sub_type = DMUB_CMD__PSR_SET_VERSION;
 
-	if (stream->psr_version == 0x0)
-		return;
+	if (stream->psr_version == 0x0) // Unsupported
+		return false;
 	else if (stream->psr_version == 0x1)
 		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_1;
 	else if (stream->psr_version == 0x2)
@@ -63,6 +65,8 @@ static void dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_enable.header);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
 }
 
 /**
@@ -139,6 +143,10 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
 		return false;
 
+	// First, set the psr version
+	if (!dmub_psr_set_version(dmub, pipe_ctx->stream))
+		return false;
+
 	// Program DP DPHY fast training registers
 	link->link_enc->funcs->psr_program_dp_dphy_fast_training(link->link_enc,
 			psr_context->psrExitLinkTrainingRequired);
@@ -186,7 +194,6 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 }
 
 static const struct dmub_psr_funcs psr_funcs = {
-	.psr_set_version		= dmub_psr_set_version,
 	.psr_copy_settings		= dmub_psr_copy_settings,
 	.psr_enable			= dmub_psr_enable,
 	.psr_get_state			= dmub_psr_get_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 4fe8b53d9551..5e8553d450c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -34,7 +34,6 @@ struct dmub_psr {
 };
 
 struct dmub_psr_funcs {
-	void (*psr_set_version)(struct dmub_psr *dmub, struct dc_stream_state *stream);
 	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
 	void (*psr_enable)(struct dmub_psr *dmub, bool enable);
 	void (*psr_get_state)(uint32_t *psr_state);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
