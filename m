Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54077C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BD020644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bQJvHDOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BD020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C45D6E284;
	Sun,  5 Apr 2020 20:41:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DFC6E210
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8zrPBOTTH3YfPkuJPFOMH651m1WlTFIayIMOiZHoyO4aNzVoNrDfCB2HY6klQ2DwrPiFTtSEII/l6jBlhoymPPBOKbAf5ldFpwZ07arc3+o612J24xw4sR50Hf+i8PUzcLjqLEzAZl7sjAcKjhMEmaRX2jLR/ce+o5kqOCLXE6dtlyNC4mtygpz3dMVYOLx9rAwVDRvpuV5AQXgUrRTRVbb7hUVb7CWj+2p9vQ5AiQ37cIX4Wecoxgf+xFCpvBGbQXj6ksf49BnVmR2sazry0kTg9avQ/1xNi8/NskUkf4d1e/HPHvVge2fkBfKjto2MEa6p3EzENrXAo816OLn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ui6Vq0dQ/FGU5DKYVadu28jjTk6vd8RmdrSuDThJGs=;
 b=ndB92AeRu3CuDEAy409lK+zyDvVAeZBfN1ADOFVkfQ3Vh9uPph2LSIB6exHS8gtIQvHgzHyEEx+AbOEUdhOGEU/cYBqvk7wTzm5f3DXJnq5CzNDO9d30LS0gQRIuorSj1ZdRNSzXm9L4WQomP+3uJZp1YR7ejgMWla17xdSu3qgo7XZj8SDyhuuFVW6quX3x/dNvEnlJW8Q46dqjHmkO4Tij9NQpr02i//Mdf5Y71znR6domVzhDDfaxtEVH5+lx+sMm2xgQTspIzdTgEzoevvMiyks/EQdqj6U6YfT/nKw66vuyD0sIkj6nciHH7m64R/5LXzvegLcpWCNzSWoRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ui6Vq0dQ/FGU5DKYVadu28jjTk6vd8RmdrSuDThJGs=;
 b=bQJvHDOl+8MznmGrxNFTLcoo+ehc/458SfkyDUO32fq2ognnDakpSW2kFktlVaxLETn6k6PFHKySlToc2c9K3hfKwTQs5MnP4kvuRnxY/ajZ49kqU1+BJb03WXP/eWFymvgi29ROjUS11fblp3MYbm3t1n583owR4Kt3B1PWGX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/36] drm/amd/display: Use config flag to disable dmcu obj
 creation
Date: Sun,  5 Apr 2020 16:40:49 -0400
Message-Id: <20200405204115.683559-11-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:47 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 635d2518-4db6-4c77-e0df-08d7d9a1c33d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25558436E9F39D835600EA0A98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
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
X-Microsoft-Antispam-Message-Info: 055u0TKVeDo+eVJd5g0xQ/3RVQKYRs6XnFuYvWSwoRoIgQRCfO4YkavWEvU+hxWoHlWLF1GNaQmTBDo7C305HQjBgk0o5v/EQdifNk7TaE4N9yGTnl1x7r5kX7dr/aeqj59e2EMhn+6cR3TH8vDjHIDvDR0bzj3VpiYyzbxR0/GC3beftqGwASYINgqPi+RN0qoZju8WmYyHCAMKzFSPGchd/gPx/9YtjE4GUHzXVCcIBD+NpmN0o0IQny2Jm22za4obAizqSZJu3/ft2SCfUyKEik0BgEgyg8hjzMqr4Xif0RurGoOLYUi7C7SuIHVeE1AbP8JfE5UPWNklU+dMyoOF6SDhfw/tpo1uF/aNX20tI02M2VyMtXmeu6rrsQuFgzt2/RmtCowx3cNdFvLDo7wDk7+iiYPPMT/iJaiwLJ08yvyUtWVVeKG2gISyvAIl
X-MS-Exchange-AntiSpam-MessageData: uX+bwZ5gZLsgiTx2XJzhzQHGJsuIoWQD/s45FCNwTqphmuVSkp/VSkaudFRVC7lefFS3UScDWZ/lGyrzgUCeBWM0NaqPXOAPlYuP8o8dSKI27LxSbJPHBWgMBYAQnVaAkRTpKQbNnWHGlknZfgZ8Wg6BgZZ81/PTZOZ54JRna/k=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635d2518-4db6-4c77-e0df-08d7d9a1c33d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:48.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yu4TwgEmeMySrHMxrngucw//6DWzNa8X1rHaBpCVje/t/Jd97rQFqp0auSiG2VX1i4JU0uw3FPKKVzFZrQS30Q==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
When dmcub is the default we no longer wish to create the psr and dmcu
objects. Currently a dc debug flag is used to implement this, but these
flags aren't populated until after dcn21_resource_construct is called.
This means the dmcub objects will never be created. Therefore we must
use a dc config flag, which is populated before dc resource construct.

[How]
Add a dc config flag.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9ff239d35519..fa0724435a3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -230,7 +230,7 @@ struct dc_config {
 	bool forced_clocks;
 	bool disable_extended_timeout_support; // Used to disable extended timeout and lttpr feature as well
 	bool multi_mon_pp_mclk_switch;
-	bool psr_on_dmub;
+	bool disable_dmcu;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 17cef02f7327..0e638a77b5ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -993,7 +993,7 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 	}
 
 	if (pool->base.abm != NULL) {
-		if (pool->base.abm->ctx->dc->debug.disable_dmcu)
+		if (pool->base.abm->ctx->dc->config.disable_dmcu)
 			dmub_abm_destroy(&pool->base.abm);
 		else
 			dce_abm_destroy(&pool->base.abm);
@@ -1846,7 +1846,7 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
-	if (!dc->debug.disable_dmcu) {
+	if (!dc->config.disable_dmcu) {
 		pool->base.dmcu = dcn21_dmcu_create(ctx,
 				&dmcu_regs,
 				&dmcu_shift,
@@ -1858,7 +1858,7 @@ static bool dcn21_resource_construct(
 		}
 	}
 
-	if (dc->debug.disable_dmcu) {
+	if (dc->config.disable_dmcu) {
 		pool->base.psr = dmub_psr_create(ctx);
 
 		if (pool->base.psr == NULL) {
@@ -1868,7 +1868,7 @@ static bool dcn21_resource_construct(
 		}
 	}
 
-	if (dc->debug.disable_dmcu)
+	if (dc->config.disable_dmcu)
 		pool->base.abm = dmub_abm_create(ctx,
 			&abm_regs,
 			&abm_shift,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
