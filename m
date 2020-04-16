Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2932EC38A29
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED83B21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hck/GqlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED83B21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42FA6E365;
	Thu, 16 Apr 2020 23:41:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5A66E35D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoJx99EcpUKm+DHg/pGDNJRs9f2zDkbaBjDEBf7yCOyqD3i7Weuyqdwjx6IenoN1FwpCVXp4eG35bbjhFv0u/ZHfaWIkpNz6LjHuvF9RtvhOaW2h8sKcT06CdzW3UyRr0RP/VihGtKAKZadDXImKHdDrzn6f6ENXUnXZJJxpk68pCS04Z1VzmmPO6fJfLguWlfblFfQ6lJCN+Hu8aBVHitKwhIzXtIrtB7fMkaVmHUvPv2fLsqJxaYIcre7+i/EyAn/5s1hcGfGMUYxlC+yU5UQKFNexP5mnFJeuCvqZxDXqIyBW+odwBVgOiTjZkN21TaaAQEOu6NXrD/ulwQaHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64jcBA7a2OP0g/i34ULc84xx0We9ANdP9xWN/oGf/80=;
 b=I1+m4T6K58iPtSQrgqbp4KP3ZYRhvceh/o/INUfZuTt7oO+Sl5hnyK5qkBYE2WwHsDe3T9NZIuu//ISn8yTx3aT0yaXnVYeXPMkVhV7d1cQW7F9oeBcAvp5mvtDa20r1HRqcvSTebALVk4C7jpve2tdRg/fETxQsbv47GBi6K/ztQIqWw9FFa4nB5eRgbZ+e+N72NHkmAn7sOmHLL491pTWLUoAccTCy1Dwe+2Lu1oXY98Qapf6w11EG1FIbLBgtDV+8QjPhbE38QXMCOYzJVtY0YSUH5HpyIQvoS0VhD758UgL6cQxil3pcOrZ7RWJzBQppbuFRyt70fssJFkQerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64jcBA7a2OP0g/i34ULc84xx0We9ANdP9xWN/oGf/80=;
 b=Hck/GqlEeuubLmj62ZXCw4c7VvyVLaO1E/ELGk5ickCdQLKi3v3qv8LfF6g26o7eZ2IvuoyM57nu70D2ohWwVJ55fTnbYZdxKFoer+FJqb89WBg4tskalr8/3UXSTehuH3if6mOXV+LBi7S4D5j6xXrHkls3Lm46uqlcv5ZEAqE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/35] drm/amd/display: access ABM from stream resource.
Date: Thu, 16 Apr 2020 19:40:42 -0400
Message-Id: <20200416234044.2082886-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:55 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d3e82cc-37c9-462c-a0a6-08d7e25fbf9b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459360904448A52B7DD725298D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i+aZiEbE4cEJD9999RQ3NAPhGmeV58SFGXuSQlcLmwW67tJfffayrQcO0Wzy+Ea1LFRdSxdF6bTD1Bs9fc5phYUF1kYS6LfdLmZXpvV5FZEPTA7h1Gadivdx0MMtDAoMwWyAN+KgrErK5ay6vOwraBSNYtJGiSlBGZQcprJHZM7pEXhDU+Xue6d5aDApVI0fUJG8GYQUHxzrB6nder2JW8CC3x7Y2LVucqD1KKmE1/yGpE36x/iuztOKgK2ZmY3QqNjWqr5nMRQP7dExF93TBuf8LB3URG4DpoyTXoSzrHRtlh5FebdxdBDN4mVbygiFZkYqXfKuefzc/GbN5InAz1FvgwxccrgmKS4yA9CP2/mMGPpBurlRew8/TMF8xm+ZFRa9BIWKvWdepl45bGrL6dT+NurCGxbG9qTuEUm2ruhdTOdCq/nsJ3Q65UmacDy
X-MS-Exchange-AntiSpam-MessageData: DWnv6GtZzoNeDhoVZRT9lf/TOQMBUW4KCakjSVjM2lyj0naewHnWrJA/c4O6OkLBz/TsC7BjLFh84s/3aunK0a7hOh4YKHtT2dTz0tol1rMugJ+jfDr7QQQU+fwBscX0IqbHZ5wHgRILjX+DjPIO4JxE7YUdWoJUwt0yQLMQSXk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3e82cc-37c9-462c-a0a6-08d7e25fbf9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:56.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs0BJN9MCcgyXXvdejilqtWxaGR7E8ivTznfsQNco8I3rd6pV61OjgNdiPm9qrwYLtoyLCh8DvX9uQ068u2KzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
Since ABM resource is mapped to stream res, all the ABM access should
via stream res.

[How]
Get ABM instance from stream res instead of resource pool.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 39 +++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 0d8fae4e9441..9c4686edcf3e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2465,9 +2465,28 @@ enum dc_status dc_link_validate_mode_timing(
 	return DC_OK;
 }
 
+static struct abm *get_abm_from_stream_res(const struct dc_link *link)
+{
+	int i;
+	struct dc *dc = link->ctx->dc;
+	struct abm *abm = NULL;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx pipe_ctx = dc->current_state->res_ctx.pipe_ctx[i];
+		struct dc_stream_state *stream = pipe_ctx.stream;
+
+		if (stream && stream->link == link) {
+			abm = pipe_ctx.stream_res.abm;
+			break;
+		}
+	}
+	return abm;
+}
+
 int dc_link_get_backlight_level(const struct dc_link *link)
 {
-	struct abm *abm = link->ctx->dc->res_pool->abm;
+
+	struct abm *abm = get_abm_from_stream_res(link);
 
 	if (abm == NULL || abm->funcs->get_current_backlight == NULL)
 		return DC_ERROR_UNEXPECTED;
@@ -2477,7 +2496,7 @@ int dc_link_get_backlight_level(const struct dc_link *link)
 
 int dc_link_get_target_backlight_pwm(const struct dc_link *link)
 {
-	struct abm *abm = link->ctx->dc->res_pool->abm;
+	struct abm *abm = get_abm_from_stream_res(link);
 
 	if (abm == NULL || abm->funcs->get_target_backlight == NULL)
 		return DC_ERROR_UNEXPECTED;
@@ -2490,7 +2509,7 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 		uint32_t frame_ramp)
 {
 	struct dc  *dc = link->ctx->dc;
-	struct abm *abm = dc->res_pool->abm;
+	struct abm *abm = get_abm_from_stream_res(link);
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	unsigned int controller_id = 0;
 	bool fw_set_brightness = true;
@@ -2541,20 +2560,8 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 
 bool dc_link_set_abm_disable(const struct dc_link *link)
 {
-	struct dc  *dc = link->ctx->dc;
-	struct abm *abm = NULL;
+	struct abm *abm = get_abm_from_stream_res(link);
 	bool success = false;
-	int i;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx pipe_ctx = dc->current_state->res_ctx.pipe_ctx[i];
-		struct dc_stream_state *stream = pipe_ctx.stream;
-
-		if (stream && stream->link == link) {
-			abm = pipe_ctx.stream_res.abm;
-			break;
-		}
-	}
 
 	if (abm)
 		success = abm->funcs->set_abm_immediate_disable(abm);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
