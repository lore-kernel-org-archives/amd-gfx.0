Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1990DC33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E462E2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rH+gwMNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E462E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A756EA38;
	Fri, 10 Jan 2020 14:47:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A566EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYiee7zUTLXM0JopEP8Sohtl649Q6tfSeKRuPUAwibIhCKZfy7RlH6BuWJNMCGxhmOHhUAkeBhBwcKhX5ibhv/TsrJ1ko83cgRi7WA9j9IARE3yuDGeRHnfMc12Qq08vnJBxR4IxqOarHoGAA0OX6A0Mx+Yn40bsp92zr8Yoku51c6t2n3k/pmghCskSEzUyaocbvwF35Jih1SxwdvoejJ08DwiWyhPqUJnLpXeRLZuwceyC9JsIDrr6UHxq5lKQohpZ2DD/kaj4/GFlyW9EGwmKA9yj4xfrFRUuPwdihWlYYZLLsSex+MeKIo/OS8GYsqFqEYrWB7V0iYibzcAW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV7srWxE9BLlYEjvpQQzrLpU+RXhQZsowYlbR//rOtI=;
 b=GS0HMXEPbAZsx0li/Ogdk+ogc4givMGGzE7lj2WjhrDJ3StDS/5rE8n3DQcdZnJTwfWOQ+D9prh1Xh5/4G6xi5xp+gFsKgIUUuTNQtChczZO/DUTshu31t6gJjXSdAuxb9D3I4Gqg4YyTWNkQDxzKKgWao18FI3i4Sgj4uTPoMDi/uyWd73cymeysDIbDmKI7PGOMYwviz/MTPNV23bPilNaveZArK6+zoWj6fQLaE3UlaqA5NmI4g7pn1nwDCt/SF4IQb0juM/Y2dLczSjru4gX9X8L/FZNxVkv+/zaeKjtXb1+zN6ZER8+wa8wB4225eEwKGNvzzlTaWLqTSCDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV7srWxE9BLlYEjvpQQzrLpU+RXhQZsowYlbR//rOtI=;
 b=rH+gwMNNcHZcmO+bvCTaJmnea9BAd7ickO5mfMyVGppVh/8xijAu/vL4sP8HwP+y8QmIMpcjYvjmLrcEciZV8s2/7y0yit1UjTvOfXFXQ1jYy1qlxGoY05AWmzpJdfiLQb4KygeUWj7Wpz9vsZbmGE8jf386U/8vxe7RxBgqdQY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:29 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/43] drm/amd/display: Soft reset DMUIF during DMUB reset
Date: Fri, 10 Jan 2020 09:46:22 -0500
Message-Id: <20200110144655.55845-11-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:28 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dee254b9-bd87-42cb-7e45-08d795dc043e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25241EB47C5D160C0EBDA92198380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
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
X-Microsoft-Antispam-Message-Info: mZb2FSIY0nqukeRsOMW8pUhAiPCOo424CnHM2dn6QlsBT7roS9AVsqGUWSFaWM8WpP1b9/otovOVDjbUcGAST1QCIFgo58mMvLHKPJcS1aSr4ynDhZvJSqEPBVV088xqBGljV2SFAvxzF2Xf6MTukzDcrCVb+GzVBOa/z+amyibUdehoxB/D5Nz/n620QsIgCALn9DfyhZXGLtzFfTjF20/GA/O1g587kJREyC/5B/h6SBEhYf6sxQzxxvAQ+JxfCz/YXpmqisk01m6BRRvEB2QsMIVW6kRbUHbSazDc/xrnU+KSXDcxsqW6X/w+Rx02/DR/2ccC0npRIijgDozDXewdgCKmyz7YgJqphOstcbp4DJyR851UeofCcdWPIwetWFSQSMVTBYVGtKZNn6niJX0DZIUVvoN7Ct7q3smGaXtmxFBeNACI8Sqjh3y6wKmr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee254b9-bd87-42cb-7e45-08d795dc043e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:29.4131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlEBTUI2uDpzOgrq2nhQYa93YI4OSDh1hHfZHCxaJPlgHqxKGRV2ZSAcWgsi4kuq6hIpmhF5+U8AOdMgijUckA==
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We need to ensure that the DMUIF in MMHUBBUB is also in reset so we
aren't generating requests while the DMCUB is in reset.

[How]
Set DMUIF_SOFT_RESET=1 on reset and DMUIF_SOFT_RESET=0 on reset
release.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index f45e14ada685..cd51c6138894 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -66,10 +66,12 @@ void dmub_dcn20_reset(struct dmub_srv *dmub)
 {
 	REG_UPDATE(DMCUB_CNTL, DMCUB_SOFT_RESET, 1);
 	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
 }
 
 void dmub_dcn20_reset_release(struct dmub_srv *dmub)
 {
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
 	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
 	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
 	REG_UPDATE(DMCUB_CNTL, DMCUB_SOFT_RESET, 0);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 68af9b190288..53bfd4da69ad 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -91,7 +91,8 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_SCRATCH13) \
 	DMUB_SR(DMCUB_SCRATCH14) \
 	DMUB_SR(DMCUB_SCRATCH15) \
-	DMUB_SR(CC_DC_PIPE_DIS)
+	DMUB_SR(CC_DC_PIPE_DIS) \
+	DMUB_SR(MMHUBBUB_SOFT_RESET)
 
 #define DMUB_COMMON_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -119,7 +120,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
-	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE)
+	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
+	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET)
 
 struct dmub_srv_common_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
