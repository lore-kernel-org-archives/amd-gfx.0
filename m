Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9FC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE282082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ZLDPtIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE282082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140BE6EA43;
	Fri, 10 Jan 2020 14:47:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CB76EA46
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyvGixIR2iVLZpWr0CFDx1GmSJwnQ9XEc2b0+2HWtem0ERsdy1EK9Z/89NQieHOfLaNualVWNgSkCbRRqlf7CxTaQtV4Gc0EYTbhHVk1HLHDZ8W0U9frsw+JAM4R6n5oKHPDk6xBP3FcVj4yw32T5q5D/TbweTPRDwx+8j/LUCPJ6R49t8jMXY6LhBNETBsPQwuBk5Dd3k2G1Bgrh1uXBx465vNijPlh4q05+yY/sbbtfGTSXszdERNhyu/oPclXNugv9/TLMvOiU7SNUj8gJTO5rY5sTGwtjxFDhlgSu477d2YY1vDTZUs+KDdtnrHtD6P97n4yv7/f27U5MoaArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XtPa3vgG/gLNUZzAhOVz3dNEKQZlExLCGDQFOsEa20=;
 b=Myg3a56I1Y6g4TB+NKS/qpzvY4E8+vM/xmcGzFB+adcNbTdc7j/bzrIJHw9Qm0v7nsDFqyJfNfcGBwCTmJple4QDvlqX4n6OdKdaOtr1ONo7naiM9g9WhvaaLeJCP/qVpR7OM8wfp61yz+DtS5WPzFycYNv4yQO5RTbBQgh3rgmI79EK+ZoV8yPs6xLxzzSfU+QWTrDG54Hr0IK8Cfj7yBVSsFFckp1e1xyOYg0xDTfXT7otzn7ezElJRADVBcNy3KFf26rgo0zjhptqTsxSoa3V0Bm2oDX5D+4mhf76dYfAbM2AKAGa5SFenYv3T0YsDLCa8gkb66UO3FTYsdYvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XtPa3vgG/gLNUZzAhOVz3dNEKQZlExLCGDQFOsEa20=;
 b=2ZLDPtILp/WWnbxeYXAfCnLJlAzvisI0SyqvWJwaoPdSp8Ae+COItBB8c9rN3XjyF7v8fn5SnDJ6geTm5PNF3QxUlT86mX6gR2qEnsrXpwaFFiGBnGQKmtYlrN6jfSnhDAQ/9zypzOLQq75qQ0Z5zdBhVWosqGh/LaHEAjNsXkw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:43 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:43 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/43] drm/amd/display: Fix DMUB PSR command IDs
Date: Fri, 10 Jan 2020 09:46:38 -0500
Message-Id: <20200110144655.55845-27-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:43 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5b046f3-8b23-48df-2402-08d795dc0cdc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25247331170F19B5B4FBAD3598380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
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
X-Microsoft-Antispam-Message-Info: 41GfrkMIjTPwKNf4FDmPlLioKo9wnuSju1AHumBBStba+ecTBv3efvm1wQqm+GqS+CAxxRbwVZsTQ/DZohC4ZBes9N5CqwIr2/hVqIHTHHiHJFdyNqt6KNy5CDn8Z4fGSAAaDje8MwRB4Jagdb3ffpkZxSHHF5mdNps267l1RO0lULAEkSQkUOc/hMbGsoT52fnqq/zoTZSdsTikC/lbsAazd/9LrLCLNGKp9ttcIunz6SE2+XnrM2UeT4g9ycwAs57ttpNOd869/4fVc0rfEpQZN1W8YOgNhE+NYW1Gy7MWHfGZRNiBzQaV9MjOQwMvTGYo5Uj6H1IP7dFvP2hiOt0x1lmMSR6H595SmdcWegUKuvz+RX0rjUaKh/A9HoUPoqhKOesmYGCxs7XOvPjb2xfNo4m38H7ePmUS3+MOaWSz3LS9e8+RMIpVM98TtH90
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b046f3-8b23-48df-2402-08d795dc0cdc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:43.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rlcl4DyEk4fLFQ19pjMUFe5yKgKWCYntd4JojsNO7bryMLSaY34jxRa2G/iN5odYE9MlqvpRc+gIyagysCoeAg==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
The DMUB PSR command IDs do not have the correct values.

[How]
Fix the command IDs and cleanup the formatting.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index 20b47649f991..7b69eb37f762 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -32,16 +32,17 @@
  */
 
 enum dmub_cmd_psr_type {
-	DMUB_CMD__PSR_ENABLE = 0,
-	DMUB_CMD__PSR_DISABLE = 1,
-	DMUB_CMD__PSR_COPY_SETTINGS = 2,
-	DMUB_CMD__PSR_SET_LEVEL = 3,
-	DMUB_CMD__PSR_SETUP = 4,
+	DMUB_CMD__PSR_SETUP		= 0,
+	DMUB_CMD__PSR_COPY_SETTINGS	= 1,
+	DMUB_CMD__PSR_ENABLE		= 2,
+	DMUB_CMD__PSR_DISABLE		= 3,
+	DMUB_CMD__PSR_SET_LEVEL		= 4,
 };
 
 enum psr_version {
-	PSR_VERSION_1 = 0x0,
-	PSR_VERSION_2 = 0x10,
+	PSR_VERSION_1			= 0x10, // PSR Version 1
+	PSR_VERSION_2			= 0x20, // PSR Version 2, includes selective update
+	PSR_VERSION_2_Y_COORD		= 0x21, // PSR Version 2, includes Y-coordinate support for SU
 };
 
 #endif /* _DMUB_CMD_DAL_H_ */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
