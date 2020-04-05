Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D4C2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F1E20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9ZN6pDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F1E20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131216E2B2;
	Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6636E2B2
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A26PeALTvt0od0C5drvMOJKn/MOHoybbpz2HlIwS1y90502jBcHtzh+H+AeZZbbKgMo3nlLXcY42Xdf0j/b7Ua44rA9plaVkgjBXgXhtq4H7ZX9S3dvEnb07krz2Wjg8n4kS2vsA/8cOR1M5Y0vJ8EGAbZLkPVqV/iq8K68/b/vP1tTE0IoxcMy2aLxn3oQNGyFNoVGtyQhV9xU+fSDXC/rDBNh4IJ7it8C7R5kUFYkY6uLqesXmxSRtxXR6dUYN+mR1QOE3IyKoWm9XiONbZ0HCLKvqdmwmvu1L2GAiJPYPqQhhJQlhQFJ1JjC1cwKebByv9/tu35XX4QcZHpLwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Smao8KKamYU047t3HtN4/1YNM8LyknODszMg/69T/w=;
 b=dCn0BHVNHhYv3vUUX4+atDOaPpvOYn7MyaCGI1qjfflCfCE03AJKNqu3e5EvkpPSAHLdDbw9Ij+io81Dy1N5ABk8MClmirgkbaILIpC3cdYi8xt4O1nRw/jb2QCQzzxgeVqAFZDEvcr6iHqVHX9Vo8lp1ZdsUJIO/R1Lje0Tqo584rYDU25YH4SEFBqBfJprva+qqHlKi5Lw1x6MpSjGfoua5WOYSCyOrzGZKwQUSyAUmuQppisbpBgP+ovkTDzBd8puHCcRDLKZPbcoJ4M5In2EpGl4rqzF2lxf5ivvBh/LQQJtgoZeYH+YwyxpSeMj5K3ge+o3OI7/Hzuoys6Rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Smao8KKamYU047t3HtN4/1YNM8LyknODszMg/69T/w=;
 b=a9ZN6pDczdDomnQFNrx0zygNAbxiMThoGHNlW34VHLkxNtC3Tpc03OrFvBNE752Q29C95uKXb83XNXWYBpPV7lNKqOtFaw2xeT/+ajjzyMgim5sTBMrnFdI0ryaS8Fden5uWXNagR3ZRWsN9QlLqblUBFJ1KC5uY5m/5b/mFQTs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:02 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/36] drm/amd/display: initialize get_max_link_cap
Date: Sun,  5 Apr 2020 16:41:03 -0400
Message-Id: <20200405204115.683559-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:01 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c712c4fb-6826-4b7c-de99-08d7d9a1cb72
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25556417FEDB86B5469A82B098C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXcq4WiJKCXIA3++Kh83bdt6xbFKEJVC40saCyAyt7D7Rylzp/u9f8kI1zspukEa6FOULviLgmPhzH6ykuB+/fVxV3Vt29q4c7C79UkMxgSq36rgy2/l2tmOcalENui0LXeE+nGOHwvzJ4ehRqoB8bumAZIP7bIRR0SHig/BZB2wmTSi4sSWxZ1AnBGa2xHCt6Xq5afMA3y+WE9qrBNYMLx7eZ3TFYbmFZKS2NwJRE3u+ff2gCG3k/dpcQmVLv8ck0wFS6zSc7GVk878arQiFosGY+mmLvWp8N8lLbAoiTx9yPOg+UDHhnO5fo3ktnCY+pQ4KzPF8jXFzRjCd+1EmetSC11AB/tMb+V4fF+h68r92dFLGhawHmrQPI1lnWA3j5/Zj+m7iW9b0gRXsDuLcoapVh8DTno7XVVJLYJWT7yZpOeUu194yyL0XNCxPGDr
X-MS-Exchange-AntiSpam-MessageData: otNsda/eSgm+aLjN0qsgtXbF0wKEmAuOYr3wphe41Luvjj0FAJNGZTgySpJB/OBJth6faujYsUUz2fydpHJ2rh5SBHLfdwEVKmp/2H1/aW+cnMGEvrvn8YvGkZICJJopMrPMexy9L7hPJeclDqA4aPS5wcN2C0+LgOb8BcHifCc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c712c4fb-6826-4b7c-de99-08d7d9a1cb72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:02.4378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOkapmNFSrzh6uYpwwg4tEAqFYnhFGudCQZQKQw7yPzlFTQR9vY8d8UcdBKz2s8uySQV30uap3nXciCMDXmvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
 Chris Park <Chris.Park@amd.com>, Harry.Wentland@amd.com,
 Charlene Liu <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
usb3->usb2 switch system hang.
driver needs to limit the max sink cap based on DP4 mode.

[how]
based on s_dpalt check and DP4 check:
limit the USB-C DPALT DP maximum supported lane count.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn20/dcn20_link_encoder.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
index e4ac73035c84..15d513b79667 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
@@ -311,6 +311,28 @@ void enc2_hw_init(struct link_encoder *enc)
 	dcn10_aux_initialize(enc10);
 }
 
+void dcn20_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t value;
+
+	REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &value);
+
+	if (!value && link_settings->lane_count > LANE_COUNT_TWO)
+		link_settings->lane_count = LANE_COUNT_TWO;
+}
+bool dcn20_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	uint32_t value;
+
+	REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &value);
+
+	// if value == 1 alt mode is disabled, otherwise it is enabled
+	return !value;
+}
+
 static const struct link_encoder_funcs dcn20_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -338,6 +360,8 @@ static const struct link_encoder_funcs dcn20_link_enc_funcs = {
 	.fec_is_active = enc2_fec_is_active,
 	.get_dig_mode = dcn10_get_dig_mode,
 	.get_dig_frontend = dcn10_get_dig_frontend,
+	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
+	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
 };
 
 void dcn20_link_encoder_construct(
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
