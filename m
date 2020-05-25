Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09194C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CCF2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MlLpkzIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CCF2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697386E111;
	Mon, 25 May 2020 18:13:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D6789C13
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKnN6beMkePPJ8tDQdqQEiPg1BzLUeoa1MThAQv8He/aPZ3WN08D1bZ/RuzmCxZi8U85uiTlbjmCt+eFd8n6eMkuGPJe9nohRrxiKdEnReuOrkhasds7w1SUY3c5Vu9/IwtHCoH5Rg5WglOAcmgHaGOsfbnE0KXVhSJ+LOEoU70NccLN7fSsAXq4uEhEb33a5zi5bl4JVv1UzEsTvnKaJKI5HFSKItRHuTh/i7ogLOmWcHy3XUG+YzlmNUYBLk8auCnXZg+x/g3yqXirH2XnAKMslrLvoCzK0+tnNFn4uA8gRalNh1quH0yYjCMxcpf7ZcJfHV6y2qwXnY+aDZ9NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMsOx52FH3/ydbR4RK750HF3hbD5QImkHZiOowLyko=;
 b=KmPt1J9IEO0lDCYAHWsydRLvGQhAFNzwzQXJK3EMLCSWIAYCppmqR3sPV/pRL2ZburGVTVdcX4O+S4ecWjbT/oveV2Ok4iA1xQBW7PdFwt0E0aQIGF9t/r63GjrQAxw58PDw+w8oL9wU7b12WGd7nefw3dMLWGHx54z2RzDAIErstrhsXgCSpY7RsRFauwmuAseOLtUQ3+sqxu6XJ83bHEbDw8/jeJRIFVRJCuJFBhS20DsMSL6jvb8bRTRaKT0jCvfL6996MrV3cfg7t0wGMRFxyS8ZtK6UsChAsMuHvWP4Dwi8XQn+gImCLlurbbuME2fDrV2+uR25HEMDIOmQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMsOx52FH3/ydbR4RK750HF3hbD5QImkHZiOowLyko=;
 b=MlLpkzIW1l7FrhKGPBE7hpJcm1xY5RGc+zBwd+TY5KCTHcTE8qsW/6o02NgLXBX82QxMvWghKCHF26wkzUVEDI110ww61bOnFz6Ga8+PTUeJAb9PbIVwKUTMxkr8KueTXoSm5TCzmWUeLn8DmfJiXqQQOKGvGpR0Tw7HG0/Cr/k=
Received: from MWHPR22CA0032.namprd22.prod.outlook.com (2603:10b6:300:69::18)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 18:13:13 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::6c) by MWHPR22CA0032.outlook.office365.com
 (2603:10b6:300:69::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:11 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:10 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Handle link loss interrupt better
Date: Mon, 25 May 2020 14:12:56 -0400
Message-ID: <20200525181306.3749-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(4326008)(44832011)(336012)(426003)(316002)(8676002)(8936002)(2906002)(2616005)(6666004)(86362001)(82310400002)(47076004)(82740400003)(5660300002)(186003)(26005)(356005)(81166007)(36756003)(54906003)(70206006)(478600001)(6916009)(1076003)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec128cb5-5db8-4586-9788-08d800d749e7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25396BE40F828D793E3DF2D1FBB30@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqYzH4AjneR/NgNNdw+XK6SWsOdWaTKHAm20nUkTI713KmsPhohS98dGiILpgVPMHp6xB7aRTQyU1+wHc5+1ws24vW07zuNOLnVTPv/sThZZQIEv/CDDyzE3Y8EXEKp9mb56kBalga0VoEd7rAw/vw1jB1pNjBejKPwAzBH1H/E8EB4koWuVY1aRGFX7vZfD9CU/mLdtFBcDXul0b+xPcFwBu8Qcqg5UjBJRVecaKv8M3x4+wsG0KX/r0wX6AWV1z41i2uyYWuLFb1fF7YTHxHmy17a+LZ0GwYs7l4HhtTMknZv5QsJ+9Va48RnMCekr9xW7o+uKsdSnu3EZQqvrib3hBiO408lT1Bv14FGGlBPsKJDaqmG22DMLj/WJzJhmLO0v3qKxzXCs7BjsOs3V9w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:12.9219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec128cb5-5db8-4586-9788-08d800d749e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Link loss currently only retrains and re-enables the stream.  This can
cause issues for some sinks.

[How]
When link loss occurs, the link and stream(s) should be completely
disabled and then reenabled.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 26 +++++++------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b578687f2b38..08c3b32e188c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2849,7 +2849,6 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 	enum dc_status result;
 	bool status = false;
 	struct pipe_ctx *pipe_ctx;
-	struct dc_link_settings previous_link_settings;
 	int i;
 
 	if (out_link_loss)
@@ -2925,12 +2924,6 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 					sizeof(hpd_irq_dpcd_data),
 					"Status: ");
 
-		for (i = 0; i < MAX_PIPES; i++) {
-			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
-				link->dc->hwss.blank_stream(pipe_ctx);
-		}
-
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
@@ -2940,20 +2933,19 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 		if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
 			return false;
 
-		previous_link_settings = link->cur_link_settings;
 
-		perform_link_training_with_retries(&previous_link_settings,
-			true, LINK_TRAINING_ATTEMPTS,
-			pipe_ctx,
-			pipe_ctx->stream->signal);
-
-		if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
-			dc_link_reallocate_mst_payload(link);
+		for (i = 0; i < MAX_PIPES; i++) {
+			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
+					pipe_ctx->stream->link == link)
+				core_link_disable_stream(pipe_ctx);
+		}
 
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
-				link->dc->hwss.unblank_stream(pipe_ctx, &previous_link_settings);
+			if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
+					pipe_ctx->stream->link == link)
+				core_link_enable_stream(link->dc->current_state, pipe_ctx);
 		}
 
 		status = false;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
