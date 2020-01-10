Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF77C33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84EA2080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MzR2dvTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84EA2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542336EA54;
	Fri, 10 Jan 2020 14:48:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397A66EA49
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMCFuebyotkg4KX4CTJyHFvNgqwq12oyky3Fk6lu0EuaaJTgXNjXJxjbq6HbSlSdAjN0VBzLs/YTpFoZYcfrvuHZgiuX4Ngf3sKiLyVhAV4WWbFAsZWA6kz/2e5/jKFh0yy9SVap+QWrbWIccD4UHTag9U8NQ2UMkAyAWqL3S30Xpr+hgshx8aszf+iYI2iUUlZHHfwWFV01WJRaotRo8ouc726HNa788arvplkJVzMsv2Bstha++92FWTFuhMmBJ9Uyinw23N7JwvRGQreZEHnTiCM3CR1esBLSKYsAq7NxK0EsbmgoCvkhGl7oF5AGypSiC0U5cnR0ii9pnia2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AYw3MJIujTtyHIx9Qkw7cIcIeKuvhikstVuP2C4wiQ=;
 b=GMY75YlNPvhRMMigZt0kEZWEM9SrRTixQ6yeuWZhstzMhSrCLGr3HLdbP3tZGsyuuohcAf6breKCAbaoAgSIBslDBEbCBaX/FuzCwOg6DKycf1afyjzC2u6jukhcxYxOJMis15+dUeiZH14iciwq0Rro65hJYmroianURtLKbrW6o/sr3O6T/huVnDD1yVArcQ7glnE7SeUrN9OSO4/GN26u+Ztz8rJDjVvDZ8DxvAs2oV4Q1CeEWr6TnxkCxojEauqHMvWWHVOYFTM9jjl03WnAiGNHERNJZ7+7K8yMthyP1YxCKK8YFDleIYOs1m3ygBy3/tup9EZ0YdL9FMAZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AYw3MJIujTtyHIx9Qkw7cIcIeKuvhikstVuP2C4wiQ=;
 b=MzR2dvTjO99mdUZBpHX9sd9TZjCItangBUktor/z6FyBzQimwcQ/x3JRzxHR2eYUI70Q+0NNYgBm7HkgfZ9Nh+65U5Rk66cshTZWrcpmX9+MEc+3/Ft0ZtZubsL7cvlwJJgmMNGgluvtKog5PnIGQ1USvYqDqSmANufLrDNw5sQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:20 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:20 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/43] drm/amd/display: wait for test pattern after when all
 pipes are programmed
Date: Fri, 10 Jan 2020 09:46:47 -0500
Message-Id: <20200110144655.55845-36-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:51 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84dd8c5a-5bed-4f2e-efef-08d795dc11b0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB237823997FAEB97BC03EBA2798380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ij+8HMoWRyq75WgRFOj2EOT3ik3jOT9xs4HR5Xn2d+TeHMTGkZTqeBEOXUJu0knSN2CPIjTUgK8di2NajpyXZtomsZvFzvGc3r5KGxB+JidMDq9d9+5e2odCQmz9xiPBkga3pyTLetnLOIy3uYtw2mO4LkAjpdPDe6r1Y11YAgNNZ0qGyNazQ8MdNc0nNEqbD/5z2kYEjssJnY1UwMDqNhLAFMMUh3I1s8Htjg/J3qKDct/let369dvAJtMbyCG39hqnifkr38C4BaO/0UuLerSsP4QE64hspJZ4JmDFCZEOw/1kXXANX4/VvUkK66rns8QNo0ZF6CAkOg1GsNIJvk0L/G0u7PFHRyAVcya4speNP/gC84qB7QoqfHYgUUop7bZw1zz/2GICw6QZGFz7qhNlS3LAMl6RKsHq8Dr8djlKYPBOBhnCp6g2whBdgwiw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dd8c5a-5bed-4f2e-efef-08d795dc11b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:52.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq7w8+VktgmFqKIlN3ngkxI72v7ef/oYl7EeYW3TcZ6KhunBcXMz8ae30xkkuN47eYx7VOgQDwyCZAB2soAwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
Currently we wait for test pattern after each pipe is programmed.  For
ODM combined scenario it will cause test pattern is shown on only half
screen for 1 frame. This is not desirable.

[how]
No wait between odm pipe programming, only wait after all pipes are
programmed.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ea5a09ca3334..9ab6b7402288 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3658,12 +3658,6 @@ static void set_crtc_test_pattern(struct dc_link *link,
 					NULL,
 					width,
 					height);
-				/* wait for dpg to blank pixel data with test pattern */
-				for (count = 0; count < 1000; count++)
-					if (odm_opp->funcs->dpg_is_blanked(odm_opp))
-						break;
-					else
-						udelay(100);
 			}
 			opp->funcs->opp_set_disp_pattern_generator(opp,
 				controller_test_pattern,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
