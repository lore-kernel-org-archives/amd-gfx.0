Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C5DC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B27D2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BLerVpdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B27D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ED26E198;
	Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F2C6E179
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1l5q/90vfDkAl1vZDPYqCpBTPaIyjqhWv6gMM1jWpYZWzGqlgYgVjgRHr8NQG6ouop6tVXaSEe5GFfrgN/SYg3KRSwJHo7qE8wBhpsU9IjjKVJi9NKRRrhaHGocth/UfIlS9xVhbzITa9J+luX/PrU18lQIZBrSbRyHb8RTeh+TFcaFlI2JYwbtSz0Lfvs6p+mS1VNTg3ApsXPgnwN/3jA7rZccs0GS5mBReFLUrAfnFDikPodM+PJYHnhSVCPaPxRIe23lvUahK7dRjxrtrlk9GmVamD/aPNCrUfD0z9zyqth8ikrBocTam92/bTVuisL9BSN3WFnfYX3vOJSfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlSNGUnoTldKQj7wk/xl6Q0kFQbAGzffz3h/XQEwpnA=;
 b=mufq7z1KSvv58kNpNcNiSNsfVJX71ZhRohL2WNlwX+10gZvpmQKBoalWrnxL+5m2EPTeDP5RlNmm/I+Y8bW4x7AYHOrxSvQD2xNEFEYclofxWh7Kzj72vTZXWBcMqD9hHH0z6AHb9DscWawlCfHvEGYy3dVb+veQRA7FJJpnKUNUsttkTDpEinNcWRv5F8Ew1dKjxi7FoSPP0391Dd/zQQtJSIE9uyRArKRbn7+MzNnqh4lNeoYE7lZIA+9WUZyLF49zdZFMgNfmculPZJpkN9THdrNyy3qjzShLTBprO7Tb2IvLSZtO1d+VglxFNJn1fmhovWpJ/htxlomJRrsf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlSNGUnoTldKQj7wk/xl6Q0kFQbAGzffz3h/XQEwpnA=;
 b=BLerVpdu2+73rchL2IFMOtmxICDj0Jkv0+H2UjG73JtDCEyB5tlrw1aDJBxX2J8/UheDKTSVJC68dnXAe1dKGEREyd7SMVY25/d7l8m6z3Q3550I3JilIql13An4Dgq1n65x/GxwnYdFNSNyuC5mdKniIWtIimzngow0UXW5+Bc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:51 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] drm/amd/display: Not doing optimize bandwidth if flip
 pending.
Date: Fri, 20 Mar 2020 11:11:22 -0400
Message-Id: <20200320151128.2039940-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:50 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 419a242b-d864-4f1c-01dc-08d7cce1049a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257272B163599CF017C9F4F098F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMkiw1EANc3N/XXCOcRu6jpzpXHEaJOcegNIwNhHJEL+jiMxMBrPfv/zJpDig0kQJ8NtXWNzRbfWcaV3s/Fr3+46nqBRryTQB8TSA7Q+FS2EaetP2TvhYiJ0cw0PJESYs0yOjSFWohsFSIQQj3DEVQM+E3fhgEHOe6enB3w+befGxZCVkItmKzGEKqFF/BbT9Q7V+bxLuwb8m2lj2Du/mQaOUdYkg4ojepLjhMEvWGgK3uq10/pdAdsWQ83RXLPcam6XgEzI4FdX0bY0fSkDEtaUuz6pd1MP80ZhUrgLL+YAwKFOaOz0w8i1M0qiMaXLuI0VUDiI4VI8LCVJ1h3jla3ddhE+IlQz7zve4PofX2trF3paS0XZzJVLrMnrJEcNmddHOLtiSNDCRv7GPLcinCnaHNysY6UUJeHeoCP9rARoidXzildE8ZUP6vtLI7uz
X-MS-Exchange-AntiSpam-MessageData: /trZo0rZ1RH/Y8wDC2AInPSBsY43xpbP74/u1QIOcOxzlw6Qeq6d+Hp26CgF0e+zEsN0a5/bHwNzGyBtN4KGfYF6sBYSynNmx99NnfW9E++x7QBUquE3HrcwqwkVrRHQ3gp+RnVTfkmoStlRcmoEthaX1L2raBULyY9kgbzOcm8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419a242b-d864-4f1c-01dc-08d7cce1049a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:51.4543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnbpwt7Aj+o7lcfaUq5gTXYXWiisS1rW0dD700WI9WvnGSg90lEAie/r4R7M2UUw2aavVfoR7u9bJSn2LxWmjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
In some scenario like 1366x768 VSR enabled connected with a 4K monitor
and playing 4K video in clone mode, underflow will be observed due to
decrease dppclk when previouse surface scan isn't finished

[How]
In this use case, surface flip is switching between 4K and 1366x768,
1366x768 needs smaller dppclk, and when decrease the clk and previous
surface scan is for 4K and scan isn't done, underflow will happen.  Not
doing optimize bandwidth in case of flip pending.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2ffb22177df9..1a2c2e3dd6d2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1360,6 +1360,26 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	return (result == DC_OK);
 }
 
+static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct pipe_ctx *pipe;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->plane_state)
+			continue;
+
+		/* Must set to false to start with, due to OR in update function */
+		pipe->plane_state->status.is_flip_pending = false;
+		dc->hwss.update_pending_status(pipe);
+		if (pipe->plane_state->status.is_flip_pending)
+			return true;
+	}
+	return false;
+}
+
 bool dc_post_update_surfaces_to_stream(struct dc *dc)
 {
 	int i;
@@ -1370,6 +1390,9 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	post_surface_trace(dc);
 
+	if (is_flip_pending_in_pipes(dc, context))
+		return true;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].stream == NULL ||
 		    context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
