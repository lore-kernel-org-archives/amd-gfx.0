Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB56C33CA5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C752082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ir8EHMtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C752082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1B36EA3F;
	Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042336EA3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrNoQ2OZkmA+NQko8XEy2Mn/36aJC0wBzHnHnGmRpzMcKBef0Whv1cak78m6F70gNnXkKVNOotvAw/OSTXNTm78bGkwyQrgTw16fqmUPNelFnfbKo79Uq+Seohm/kkdVJdPmAEN9U0VzKL0og1BULaYfwtEDd0JlR3+fTUz+MffnAAjdSPDjGJu0q6KZD+lKqtxfwjochhgX+oUQxSCxMZQytPyBnoLdTF03FJG1Nhz57dtOpNM2Sf+lid7Q2LOJPy0N2+M9ATSENQu5glOYZwPLBlZ4LCcBCXHv8UtJinVPzR1ur+WKYe2+7ou2frGIG1HDivthaVrjjovYfbUdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzTRO7PonuJdSbA75iKn4WJOK28/VkxT6/yC4EjzDk4=;
 b=nP7uz4tbpOpEXmho+D6ztlOiYipgDp2cZlyv8YNPUpzTEozOqHHuRbJM0+OCellrShR2pSLFOqYL+SbS0DydWAeAo7YyU6u+FXnW5pao6eKqhW6z5CZw9xsJDzVryYdHoqMZ8iOsp/3+9Zq4NB64Lok6Z+VYNxu5OwbbtwukHtEZj4gNcOQgDnEJBkiRJGKJ8ZJWsZje+pRshL1QxpGwxMAKO1sgmhcMKN6pKw1Df4pdtlXU0DDelUkSKfZQmjtRlJGdRvc5etl33W0r1yDEK7W+o72DCDs5BnUGhJQ47Pm/2K5kOvm6m/CJmixyKXe9PluyYwm9AUI63+6WexOWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzTRO7PonuJdSbA75iKn4WJOK28/VkxT6/yC4EjzDk4=;
 b=Ir8EHMtnsE9l335aAvoL+PEAVfO2DXqybd/PwAbCoY6p2O4ce3H5oHiIuaaK18q9XrQF+GzL06Wg/Fjz4nvUQjcHMm2Q/88KQLR4D+ID7uQsCI2AvREByUPoKpqPc59fveg0uH6k6Y+sTduZFx/tXpu/6UaoRzCDtTG5jatAvrI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:34 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/43] drm/amd/display: wait for update when setting dpg test
 pattern
Date: Fri, 10 Jan 2020 09:46:27 -0500
Message-Id: <20200110144655.55845-16-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:33 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fab5a8f-242a-4216-e37e-08d795dc06f7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524EB92FCCBA38315E5D73C98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
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
X-Microsoft-Antispam-Message-Info: ifeTDhmtNC4QxcMC8bldXZkZ3mVovbuFqkIqxvTIYBshPV4u2LTY7ZzlV07JGv6UNu1rlPVbm9p3gBY1QwpB2Sma2Ldl+mStiispUkUnFolt/BtjoePlFUmJkKmOvpXVcLhB7mq+1N21C/DE6T/Z7KT/CBIgECwYoDxKKGgpPPMS9SrD5IK5qC0gJBIHdzT4EH8P4tvMTGizXeOmnVeL6t5Dp6QhrKDfWe4wfE3WKuk7YJCyFznGH/LH/DVbq5w5+WfTJBAFoXNBX3JGZiFjuvKPGegpzw0JlcKsnNt2C9wpBLxtp5x4jww+Em6Mo7H3GvnJNO5ssdIjFuPinwzJqBVNnwRsDwXqj23plClAK5VfrV49fBhhnJyZqpc1ZKBpKNBPuJ6XbTwqe6Av/e4PvR1O9njunWQihLSFzPLJ5uF+t7slVGmSkoJuxq0MDAkS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fab5a8f-242a-4216-e37e-08d795dc06f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:33.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2566vT6NNbjML0VRgBy9gYx89ApBdbW1fCe8r73m/c0wcEw+5Q88RRmyWujYlVIZR2YECHrHdT84r8mQMUiY/w==
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

Test pattern should be applied to hardware when exiting set test pattern
function.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0d0507cc9bf9..46f16a77e3a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3612,6 +3612,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			struct pipe_ctx *odm_pipe;
 			enum controller_dp_color_space controller_color_space;
 			int opp_cnt = 1;
+			uint8_t count = 0;
 
 			switch (test_pattern_color_space) {
 			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
@@ -3647,6 +3648,12 @@ static void set_crtc_test_pattern(struct dc_link *link,
 					NULL,
 					width,
 					height);
+				/* wait for dpg to blank pixel data with test pattern */
+				for (count = 0; count < 1000; count++)
+					if (odm_opp->funcs->dpg_is_blanked(odm_opp))
+						break;
+					else
+						udelay(100);
 			}
 			opp->funcs->opp_set_disp_pattern_generator(opp,
 				controller_test_pattern,
@@ -3655,6 +3662,12 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				NULL,
 				width,
 				height);
+			/* wait for dpg to blank pixel data with test pattern */
+			for (count = 0; count < 1000; count++)
+				if (opp->funcs->dpg_is_blanked(opp))
+					break;
+				else
+					udelay(100);
 		}
 	}
 	break;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
