Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8C3C2D0C7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6658B2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q5XJHOME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6658B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245526EB75;
	Wed, 11 Dec 2019 15:33:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE4E6EB75
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISFyuHnvkYk3JOLulEr/5TpExjEWFMpplig48vTjljwnYn9/bIqUIGLx5ioBFIQsz+/ThwCy9YyZt3nxJme9AJyBndc4UOi4nBv5JDI1nRUggDAwYzI/3nbvGbjU5lNGL5BsoL+Y31M+63MSfkXSFgJ+1hrH4rpDRr5LuSyfi28Ab74XSjjP+m+ThWJXdQdoOfPboMdCPV4MFy5/RzWD9nQBEjuFAakQQFSFA1c8afQ3F1zdzjwWFiqIJduh4IlcuQY1ra+cN8ohauuxzR/T/ERccbDfP05X2n8MUWHt4enj1WJTsHyAX6bOrtYDY8IU0pv/dQTMVrG3z5bgJjG1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNwRtdyFlHksZ0z4ZSBBggyAA91elHyz1i0iT+4BtzY=;
 b=lYuikhnEE8SXTeutkToAqMRTdKY274kNJijfHEKVe0mawQYGpqkLltOnjA2FHmrLxqaPozCyTINNsheWbuu2vE/edq1jABPPZ9u26lhEg094VQ37ZYEkY5voN3AYy3Qfd2yjVpOfty9PJf6rqfa8cd4fNwhHUWtbei5lpxDk/IwLphP0AUkgyxuWU7mE5861EMvb7OuB5sxJWH+dyQdfKDr0JfO4DYWIcmZ4dsIRvTv19tJDXrJpG+lacnM04vTbwTaJG8/Ve8XL8lC15i9C5+7sD8BtPK0CfK1pO13qwNBehSYLH5G4/IXBfpiuDZV42uThrM/TReEfvLnOYrTx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNwRtdyFlHksZ0z4ZSBBggyAA91elHyz1i0iT+4BtzY=;
 b=Q5XJHOMExPjiA06Q9nQ8/LqInNAu/I7crZqorYM8FQWKPz9VyXqW1GTBFUVMHNS25rc6OBk9ccJ41hL4cIdMjKQURPl2QpSUAZxvLUo+qDVMGqIvk4F02IbOSELTzgdJAPl8UjsipKrps4G0lyzuVA5gJWIxWl7+NsSHnqDI1Sw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:23 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/39] drm/amd/display: Add interface to adjust DSC max target
 bpp limit
Date: Wed, 11 Dec 2019 10:32:21 -0500
Message-Id: <20191211153253.2291112-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e95ab58c-7fe2-4ef3-4d67-08d77e4f7518
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2426998B7116040A917F22BF985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTyyWeb8tLx7NvXhQ9rj9rw0ZF3eEia8jx+1aF4RzhISq6KsvMiX5OsCfZGlO9zc79UO8wFsjMcoQq8ozoHu8A1FQ7Ynwor+DVk5U6fyxXzyx1BvFiJL94PwPVE0MM19Q3pijysBfVdQ4mTI682n3iFgJpw27GenDfRkyBkU1iGJuTtINVF6IGSoSQKkw5HRSivUCZbABbr5OmiPVGveOEWEDdWt10w8jt+J6qRJq2EnvZh5WYinto8BsvE75C59wGp3jCUOiPB3D0/8eLxTcfS6vPteIKTF0nDDGt6r/de96YKjtlxQSIIqFzoi/5DUBgVwsd1H2gNZEKxnYioCVfuPRTUosCUxMYeB3/cCu6P/2bCSradmp52KXt6l2UpsblY3/hE6eMnqUGOHwD1e0ZX4Z7td4WhOZZFrokJ8AnxknFfwCs7kmRMuFtugcGs+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95ab58c-7fe2-4ef3-4d67-08d77e4f7518
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:23.0506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pg3FH7+CUjVU0P/QVc7/m6mSbWelfVjxfROaNZBKFqA70UfdYc18AAu+caPgzafJvuzEjV6k8O9iyLUGBXnAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Harry.Wentland@amd.com,
 Joshua Aberback <joshua.aberback@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
For some use cases we need to be able to adjust the maximum target bpp
allowed by DSC policy.

[How]
New interface dc_dsc_policy_set_max_target_bpp_limit

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     |  2 ++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 8ec09813ee17..7ece8eb5f48c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -77,4 +77,6 @@ bool dc_dsc_compute_config(
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		struct dc_dsc_policy *policy);
 
+void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index d2423ad1fac2..71b048363506 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -29,6 +29,9 @@
 
 /* This module's internal functions */
 
+/* default DSC policy target bitrate limit is 16bpp */
+static uint32_t dsc_policy_max_target_bpp_limit = 16;
+
 static uint32_t dc_dsc_bandwidth_in_kbps_from_timing(
 	const struct dc_crtc_timing *timing)
 {
@@ -951,7 +954,12 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, struct dc
 	default:
 		return;
 	}
-	/* internal upper limit to 16 bpp */
-	if (policy->max_target_bpp > 16)
-		policy->max_target_bpp = 16;
+	/* internal upper limit, default 16 bpp */
+	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
+		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
+}
+
+void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit)
+{
+	dsc_policy_max_target_bpp_limit = limit;
 }
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
