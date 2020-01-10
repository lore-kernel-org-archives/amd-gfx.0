Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6669C33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6872082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K5wUR47d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6872082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23B16EA3C;
	Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED6FB6EA3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBqBlp4xXapMF87X/SOS5uihU600XrqSNBOf11n+wi9V+n0yLQlKu3m/Z/5opu9z59z5K9VlTUh9cQqu2+DVvGFNDoxGEIyAYVfxoSxyTGLe1mAX+CiTAdRiBtMJAwVHIKNaiqATAFVjRe40ornjJkM61rSUnFHiOQ0ze8JV25uLvCEwDIQ49lLn3Gd3JBO4Ac+uKARPjT4gwW7khwvJ7YHT6Oab3F4KuQKnRqxIIuHbPQ5f5jgWJSa8SL3oLG65M54H35AH0ZMm2uflPZibPe6AoQVxrReUFD9vDsyERSsvDA61RMwQnVnUK9oDeJOu670TpLT3esTBxN2LSFCGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGHr2UXqFxo6wANdal5tYFUNQi9redGd6KgZ0Wqg9DI=;
 b=NgsJPf4b9izxf2FXGgpfo/RYr7UV/fwH3HjB0OwC/+yqZtpx5satYJulE49K0GC9jiyI9A+0d0bouMJVIIXhkEVN252dWVggXerBsSTRyw98Yv7Tz3Pz3c+xli66k3atNxrVi03xSISeOlal5IVCu++9uQVLU7ZLzjIr8y/2hQUcVTqyM4HhLeTDBvEGRO/ByIR/1akDz6k9v61VpWubVjaebybOAIuvNmtzWSaWKH+BvX5dSPMQi0rfALnGp5n8lrMJyWCoX9IDn8fsXkh5mLoFCXA/4j2KV5H/GtWDSQxY0xO4Jgn9uWZ8fGcH8XQ17kCsjfBcM16l/Mjt+lRyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGHr2UXqFxo6wANdal5tYFUNQi9redGd6KgZ0Wqg9DI=;
 b=K5wUR47dgENgtmYcXzwffnq60KSGQsMWw3X0RM5BSEx/h7w4YL0Lf/G9PqvcLDcVM4XtkWljFTtfoU7QeG/IHP5LNrQC23bdqLWmLNNpiyxyDHSMQllGLj3SE/dq2BFuBdx62+XzlMbK2h5soOa8ck47ATCj2Y7ohjzf4yvz9Pc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:31 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/43] drm/amd/display: store lttpr mode with dpcd
Date: Fri, 10 Jan 2020 09:46:24 -0500
Message-Id: <20200110144655.55845-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:30 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c835ae6-4041-4fc1-7208-08d795dc0538
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524E58DC34A55F96EB5B61B98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqexnMg56syMKluD+GM4YMveQU0bJIJthPPfHZ4X+JqEhh9jUXxCbYNhpOv+IWfu7GRktURm/MvXg8WquijwvraabbKeMyJl1p7J/gFENmfiet1Gk1cMmq/gT4T21E+4w4Bv775p4uyDMdNHqoCP9CLMN3yEaf8rNmA1OGs5wwijC75M/bOTokySG2Lt6ENG/wHYspQbflW/vGI4HSAhaQppxYJATgRAuzLWEGHmCjZ8tgCsVxJsfv/p1pB99PIqjjnmL3sz6cTRuIC+zGsKoHOdt4mVddwa+7II3IQx/MM1oNsBcla/76PDqZqV70wgWIs5+W7Veq0lCi24uF6AjPQ1g4FzDM3ELjmRokohLT2f8L0VIqamTrHTIJIoUsiLvJbCZPytXQzA3X9n0oe/+JCQBkpoaYnln1SWZFupDzY14AjHkNC9iF25UzjqY5uD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c835ae6-4041-4fc1-7208-08d795dc0538
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:31.0552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRFe26I1UJqBgYmcoHmw0kug+KzYRUQe0FvQCDKEE4n31bWs5nqF9C5vwl5wgw7QxncMhOeFM7SqH244lMCdwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
 Harry Wentland <harry.wentland@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 abdoulaye berthe <abdoulaye.berthe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: abdoulaye berthe <abdoulaye.berthe@amd.com>

Make sure that lttpr_caps has the mode set to repeater.

Signed-off-by: abdoulaye berthe <abdoulaye.berthe@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 38b0f4347383..0d0507cc9bf9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1217,24 +1217,33 @@ static void configure_lttpr_mode(struct dc_link *link)
 	uint8_t repeater_cnt;
 	uint32_t aux_interval_address;
 	uint8_t repeater_id;
+	enum dc_status result = DC_ERROR_UNEXPECTED;
 	uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
 
 	DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Transparent Mode\n", __func__);
-	core_link_write_dpcd(link,
+	result = core_link_write_dpcd(link,
 			DP_PHY_REPEATER_MODE,
 			(uint8_t *)&repeater_mode,
 			sizeof(repeater_mode));
 
+	if (result == DC_OK) {
+		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
+	}
+
 	if (!link->is_lttpr_mode_transparent) {
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Non Transparent Mode\n", __func__);
 
 		repeater_mode = DP_PHY_REPEATER_MODE_NON_TRANSPARENT;
-		core_link_write_dpcd(link,
+		result = core_link_write_dpcd(link,
 				DP_PHY_REPEATER_MODE,
 				(uint8_t *)&repeater_mode,
 				sizeof(repeater_mode));
 
+		if (result == DC_OK) {
+			link->dpcd_caps.lttpr_caps.mode = repeater_mode;
+		}
+
 		repeater_cnt = convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 		for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
 			aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
