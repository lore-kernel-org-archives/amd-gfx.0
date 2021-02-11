Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E9CC433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD5164E45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD5164E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721916EE74;
	Thu, 11 Feb 2021 21:45:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFD16EE70
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbykAgSbT4AnGObsYff2egLIuhHUZbh/4Gp7JVHvFBJuayGOb1z3RQwNOdjXpa8bQsdhbUXpgYMCI1hYwR76t9+GxLYFVTe0vEhDoAT72D/HKZVZwQywHr/q6Iugg2IMnhwKL7aYYhXpm2FnKGRSsyLp2cebfjJ2xnUUNf/4CoG3oyIPEXvLRZ8MpifKH1ENROXX2dEEjLJ8PqyzwfLXJK1JX8XBHSTkQy9OjXkK+pakT40nJDH44BIp0fkK48hYvf6BiqEy1hfA7wy51+KZK8anTtNzovb0qVAqTn186vh9ygiz7Jwd+1eeUAmLNhNUfc5DVjftISt/eJ9VEc4O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5LMy/II/NTZGWqJCUy2/4Zq51f4OfIqvm+0kD5Pi1g=;
 b=dbB0vGlQYmyBy+PewSevodyXHwkwKCbOM1QU4IDbiqFJNFEkNq4FfD7dP+tQaX4DgSHzjvfDiIOuhOP7BT2ndMX0o9iU3LYTILQPXnKc3ASstCqDfvwvpuKYjCIU3v0tmBwhsY23erN2CXe9+HnDbMYDa4ixdEdcWSFh5Ko+uiFKEPaBKhXwZAAjGFw0ZIRQELJSgDVoWY4Z/9eUBjA9g5hBFP/iylJ5dzRivNUNOVpDS4WNHeoRGL6YPBYAMgqGuEOeJ/ZlrNRM7ekEHHkqAAmtmbCpz10K5Qsechh0ODvgA/XPPwZ4NJFHpwppkbMLC6haG4Qu6PpL7C+PzcsbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5LMy/II/NTZGWqJCUy2/4Zq51f4OfIqvm+0kD5Pi1g=;
 b=D5VbcEbGH8mP85h862vmQZ+AukUGbOnMgIljZFr3SZKoY4/7XAQityBddj4ll9sb0/8TDd4mGZP/c6hCywEk4UfPWFx3T7toL2cURUrs/pLE71aUvyFlUUGy3lrq4KRFlpD+uJJtLayGoJFxrxpIoVsweZlNcClQOhM320RYz+I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:09 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:09 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/14] drm/amd/display: AVMUTE simplification
Date: Thu, 11 Feb 2021 16:44:41 -0500
Message-Id: <20210211214444.8348-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7824fb96-3c98-431c-3bf6-08d8ced64d95
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235ED7864FB60BCE234BD54FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvUwe85lXEV7TM1Z7Ynej6+pgOXTICabS5FsLzo9ZtRqDUVQ128kjOs17uRtDTmqCR0fEPqsMrFPg2NRFLZZlOTB6oec4OMj8nTfarnFYK0LY6iDtsyVQVB8f1N4cz5imM9VFyAQyvrKsVFpHYy9VhVTcGVTOqyba+34bMaG+gwR+bwtmveQGIqLf9BhFMUGp2egHKGKsOy6XH82bw6wCaeQybHhRlXdl2HtDMdnbNz8uendBTjulu22M1j6lBOWN50F5aGBnWYF7A47LU0wG60TZIMgvn78JC0IijKzSbPIPts0P3q3ymIKUbj0y9mosoITIMYyQTckKWWWP2EJb5flgpQ6CR9GqdgqcUPdI+ziAnXUtuF8inVOZgFhPrbssCEFt1uBV8ibK2yXGdCdJGm76c3myib9XeK4ozwzzsAzA8Cnl691yvpSznJYAsCWOjy9FU9mK7Yli6DvNYCrG6ttTQfWAdECm6Ft39XsyjFmNuefuAtwI4UU+Fv+83IvqEvFOaSL1f01Zabtt5A9qHNoaw620xRJSHWrWE9rvq6jYAkwcypTeGU1/jTjSmKgv0tKcqhvkpZ+3k6LfIklPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FVY6ZHpP/QOr7OajErOoSEo/MUeWvh4usTqARBHeAjrc8hAdr2+PADv8UmjX?=
 =?us-ascii?Q?RY7RTDt+gwiLA7SfZ85jHnEXPA6/5FARpNznZRCvmze3/eqK3Gun5gg0u2mD?=
 =?us-ascii?Q?Qj1qLVNC6UagNFDrvcSn6TG30e1vcwG1xsptTZ9vcWq0VA82qsn0wYhz5C8/?=
 =?us-ascii?Q?RmNNxPi8HJeSvEWUoKRGsCT6Tnl1zepbxdN7/sacieJ3IRrpLk9F4310jTLB?=
 =?us-ascii?Q?aAeLjA1fv00Ltwr4DER99Wb7HGcV1BEI59g+Qg/VOfWM0VoKZlDRKAsQbk6C?=
 =?us-ascii?Q?2NSgSA2L8DGOKGT+eNbk/pDuSMnPGZj5grfpayHvXlVePD7WJSIZdRlIwBVu?=
 =?us-ascii?Q?b2Vyr6p0hin4DOI8MRSX14UMs65nVXTGpyKAey9FbM39vekZgnFsHdimD6yn?=
 =?us-ascii?Q?8xf4Aephc/G5zdegqMSOpl4XMvfdoLwy5CdmQIhe/1PDukFxBLcoRoell1hV?=
 =?us-ascii?Q?6uMLpnNqV8Q5lUYvAtSS4fjF6Mklp7wn+QmsIVd/0RIuDsa1VZcusl2FIhzi?=
 =?us-ascii?Q?orx+rn7LS3wBJWfWgG+FlcccFXlzyGWSN15djE7idMUno1sPzwiKipyFgzYZ?=
 =?us-ascii?Q?12exsm9JHdMctSJkCMvJ+jr8TqmnpMHZ10yv6o1RSJs8XLOvFOdBG7SFv8lN?=
 =?us-ascii?Q?SNF3t6NS7GeAkHrL5fnVwfnFf9BU+w0SXQshNpbgWvL3dk6ccPbcyqGLszC3?=
 =?us-ascii?Q?vlCFAgv+KUbZOjVN0nnujLKVI3cx+kyMla0p+RPxWGJizx5TdfFfRKZzBg9k?=
 =?us-ascii?Q?51wdhGkr9McfUOTZJMUqlw5nC0JdhrK2OY3OXG44AD5Nttio8lsGCk8FITSc?=
 =?us-ascii?Q?86FeDYoLK1Gg4TOBfxWIsCdG/CowOudyqcTL6ShfpHK7nvMghgbYTWFh/5Mp?=
 =?us-ascii?Q?n7zjVmMBNVnsJVp4PyIPU2zRNoni91i66Qu13xrd5y8+qCHCb7cEqQMCNPaB?=
 =?us-ascii?Q?Xe2HAf3Gkmo+8UGAetxTUX9TacKaVBHnChHtmYYCdBVK3Lyx3w4Szbjlk1MV?=
 =?us-ascii?Q?VvwjCgaO3kiO4aVIsuz76qarhZV++SILVnt3gBP6gTfudzhRLmDGvtucjI93?=
 =?us-ascii?Q?w+CpGVlVRrRvEbxCt05ptp/GIl8wtGT9YscPNnHGB9ZUqMXfz/Ej5DSpCBhh?=
 =?us-ascii?Q?pvKM/A+PB+Sx0iH07wTRcs6XhGknFv0kM8y+a55WJzMdvDrSTI9cqpYoUss2?=
 =?us-ascii?Q?LOulwznfnXNL3FXUHcnX77wcYV2qomV2HlIDKy1lCYiEnHV5mipEz//lRKdt?=
 =?us-ascii?Q?1NaQln9IyBEa1S3jE++fs2bbmet1PGpPW9i4QjFgt1zYrkOUdWSl8ceravrU?=
 =?us-ascii?Q?Z/pDVArNwUHPEEbByDbEq1S0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7824fb96-3c98-431c-3bf6-08d8ced64d95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:09.8291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4ZB4uE2X6qUM9Jm4CzOhsSR/2ZO1yIpzD+/yblakMPSw2FGIBcsgWvEwSmAKBMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Simplify AVMUTE logic in coding

[How]
Avoid multiple calls on TMDS AVMUTE
as updated logic now demands it.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 9620fb8a27dc..ab93da667d51 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -649,7 +649,7 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (pipe_ctx == NULL)
 		return;
 
-	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL)
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL)
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(
 				pipe_ctx->stream_res.stream_enc,
 				enable);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
