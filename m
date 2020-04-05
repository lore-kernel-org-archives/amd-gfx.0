Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12EBC2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B3620644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ydUxtksd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B3620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0135E6E2B4;
	Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7AE6E29B
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9qQa948HKEe0SApQ+z8TMQCKXyCiltIoc4pd0FxV4Ko++djZaA6Sm9hNaDtHKy2yzyWorzQSLNs0Lsz+WN1dil5GeSGbWaLrfrFTomjjdobGbUu9Ya2wrD1k8/vhPX/i8HwJJcJ0hoy6sN3bMmQKW/um4QE08L2WAa3+PPHHe3uQ3JkvsVyRDulv7T5EAyyP5do6QmaDLbiy+M4ZfKh9FN183xw1VuaQ6slFL9KqYsAK+mSPlYlkyE5IzYlSVVfFf0GTJL/7Z35vruX0iLhgSUnpVxp7UgYHMBmvtZzdxSymO4iobxscfrjOLYy7AaBv+Es5HRVZAdKsfMIdRsAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0QRBefMCqhKyzkzIkfcnigonSl08QzEoDh8qGvkdHU=;
 b=FnE0977Y0n42qRx4IngUty6fJk4wxLo0tsSHVRdFj3SbmHCvExPDVg3idYqKt2kWCxiiK6fS2iOy9ZAQtAsljOLx0xXsvvtLZHzoz2cdebXVwFk7GxD8GaNiultUwhRDlTBsxuFxg8gvdzf1PZzFJRytsZYvXRJCTVQVesJfa6tGviJDwECB/AoucDMIzVjYytWytV1TMn/bXkHPVssiX9V2g9InpK+3Y9A4KA6+j9seOsdf+FGuvUYo5K3yKW7ZScBZoaqGxCOoL6laC1qjToV8/NyzOW2vnybygQxnzaxFRQDo5BKBZygX5JsWWNU2ZiOdbz/e2fsIcX9t3bPH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0QRBefMCqhKyzkzIkfcnigonSl08QzEoDh8qGvkdHU=;
 b=ydUxtksdlYAXx9t6NEhva99eYZYFxQJiE7E7tSDAhqo6TMZVM+T84FWfBMFLiTw80JJGAcsi8J8ftZdaFVMqb9Ln5LgmBaUSm0KONyUiXBFUeOevTuV71LaK9MMCUJs5Wap8W5pwwn/E1W4yi0pabnMgX718SUl2B52ixXJ12/0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:05 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/36] drm/amd/display: Properly map audio to engine on NV14
Date: Sun,  5 Apr 2020 16:41:06 -0400
Message-Id: <20200405204115.683559-28-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:42:04 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc6fe2f7-b675-4e2c-7e8e-08d7d9a1cd25
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555CF0589C8B556E1C5268D98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
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
X-Microsoft-Antispam-Message-Info: XtULdeoOTcCmWQCilFW0043vGvewHVxWJEEs9XKGwJt+mEKcyLsiV+ghrsLwa6/nO50XZKW1MwyaY7a0/6yuFAqYNYk2mZwCwtefbFdl9K19esLa+/xoyZ0bCEMSMaOqk4JgLsbU36LxN81iFnC2j7dS5Tv4OQOGM6v1dkDXsiQldshiDwc0nd40EdRhiMlLJXks5xVpBiHMYiU6dCtbqV6HcRxPBf17tQYpXx2QT2rxCrZSyd52NDN3lF2qatGrRHpwNOHFVMQBm5BLgK2k438+UOOOlbuFrU8bvsoXgAMqg+03gyKZstSTuo8j5Sja9sQguTcDZPfR/vT8BJNj0HUEfco3jfuAhNBWwtbkx4WcZaGAlzOK2gtxECRKhFouPtuhtBPL5lHFNVuv+Skiqqf4qWdjU9Y0xUgyDX0OwmWIhJUG0vMr9B4jPkovtWOl
X-MS-Exchange-AntiSpam-MessageData: XjfNTxN2cDdvako4e/BncC+pshNwXcYxtcTVt5lE0Eczhp66pUY2VW0eU4c14yrE0krfjmH+T21T2dd5EdBmt9TduKRatFGDxSu8xZSjqd7EkzgNyR0NM5SnBT49glyQ4YowB1vviilu18gEDAyUHcYtfZnc6FSDjNstfyrro5Y=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6fe2f7-b675-4e2c-7e8e-08d7d9a1cd25
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:05.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bkxgopZyyafeqNry/gUYhGKqpcKC4yHtwYKW6q64adkySwJFw968m6rU4LapqN7bcDEPQqwbOu+a0B40+bmrg==
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
 Martin Leung <Martin.Leung@amd.com>, Harry.Wentland@amd.com,
 Charlene Liu <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
This reverts commit c30259abddf924533e9452f71ee03819fd6e949d.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index ede0723e667d..9e1d2b2e58f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1324,13 +1324,6 @@ static void read_dce_straps(
 static struct audio *dcn20_create_audio(
 		struct dc_context *ctx, unsigned int inst)
 {
-	/* Navi 14 has no DIGD */
-	if (ASICREV_IS_NAVI14_M(ctx->asic_id.hw_internal_rev)) {
-		if (inst >= ENGINE_ID_DIGD) {
-			inst++;
-		}
-	}
-
 	return dce_audio_create(ctx, inst,
 			&audio_regs[inst], &audio_shift, &audio_mask);
 }
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
