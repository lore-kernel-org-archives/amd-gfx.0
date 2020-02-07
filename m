Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DBDC35242
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE74B20720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gd3hjSxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE74B20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613BE6FD12;
	Fri,  7 Feb 2020 15:50:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E175E6FD0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2Vv5V4WLhJyvaxxQw6vP+/d/W3vPB71bVDWsSFReXXF5PzJtpLx5On/byOEwVg2hOOv0md6KLI10WBIx7gE9B94975frDjDZaqLyzEfYzW5Vs+beXsb9SMzXTzJnxZWMXBman0wUSaiPrQ2wSn0md/JLUAuvSGCQTMDbFjcL26LgZnT9SVCuOdPkaXasal4oGtjW8XNrF4v+QTUvDct7f8PGNitVBnq/659oKfme2UKjQcfCzLEW8OKquxNQ+x95ATft21St6ZjMfgtMAP64bA2zMFxbt51CgQ3F4phQuNlF/0EXJriKw6ryMTdu+fxSr82BMrul6bnRdVQTi2SUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQVWC2a9+uyvS07nFk6JfROT7nIKyCV+JfLVKn3Tnuo=;
 b=A5Cz5efGhtVQefX6qmmLzjo3T/2KR5MDt/6RZsa9olB8ikivCrCb7ki1yy/ICt3PVkB8XEDPQL8QvQdHqyNqxFsOdR7WCgq8OEvoMpS8+ifh53DAcBt2PTzX1tz6tdJ+NjL9XL4SGt6f5Ao7xV50/nBB8nkhCSgnokqAvK1x3QJE5DuYCE2tx+eZANNLwjWBquDkG5IVuxLirVCozr90DsKZUzfI3p3pSiVnZ245V24+fm3a5ci2Iakq9giulePOoGw25EUWbEmhcAyzPZkfRt+jGTiW2eDw1M342fqeO39/mqczd50SadG+nH7Oif0xwTfhCHldk9zpk4ZtTt5WwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQVWC2a9+uyvS07nFk6JfROT7nIKyCV+JfLVKn3Tnuo=;
 b=gd3hjSxHXiembPWCSbh9rnr+JNCa89tr1jQLB6sEhMGghp5cNzv47z5vsvzZWoVkZjylgLscoaKlehzSsENzd4lhFwYIgiA+ndHLkPlDuyNKYu5TzzoP/2geWKPLmro5o+fpLaSKjCsvkSdXY9B6DcsWBWndGoldbUE4TIkZKO0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:48 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/17] drm/amd/display: Update register defines
Date: Fri,  7 Feb 2020 10:50:02 -0500
Message-Id: <20200207155010.1070737-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:46 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c902dcc-7334-4105-b2ad-08d7abe57f48
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24405123FB8378CF50DDD8A7981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(15650500001)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/9uqV/ro+3CqoKqCrTCsyKiZrHR1nd0TG7Kg+AyC9++7aaN3sWVWTmS793vN/QtOl15xPD85lp9bUKhemOXGryvMLKJj7sUzHhwgXR2yX0uhCOoHYdLIoqPcgmdfX1HKo7Utckj9JEtng7Lves1gakIUng7LDXv+G24nJnM4cm0wzSTVDvJk7blScOXDkegxVpLQ2/yFtrVvm87QM707UTOOBx/v2rAvXUVVUPQVIEpPaMxW/negYlHCpO4nP92gzD6l+Wiqiy2d5yd2sZkFIKUg1KJomDL4jX0N/wrKkjcutV6WnM/wQWnrz4c5x6HEZ9egWmdIkcQbx/kgLIiVpwFiQbho3hCFYsa0jVWq9wrG4t0SkySTI86XtRQ+z4ECqEZwfNC9dRcTgpwLBPblWJMJ/eqiWOwD/L7jD8sqcs2d8PTUUNUqLBsWpkRpl2n
X-MS-Exchange-AntiSpam-MessageData: uMWh486lPelXsNivXVbYqWvYTHqA8vqhVKuCHyrx4y45qbLNlxJloqTdqzTRabJ7qdrl+yffRETA7zcUOVUQ4PD/ubhlLHR62iEURPNyHxgHmcBW/ePsrR9N0JAR5mAw9X2H5q1Ym33pPoDFli7WWg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c902dcc-7334-4105-b2ad-08d7abe57f48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:47.0064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaZONK06OxwsbXSHz6Sv/TjPyRXZW/pKn8WJoABtRm3qDp5hmjlrnCqtfaXbCQTFAD8dAn6fDtpARLv61LToEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
 Anthony Koo <Anthony.Koo@amd.com>, Wyatt Wood <Wyatt.Wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Some register defines are redundant or updated

[How]
Update register defines
Remove some redundant defines

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Sun peng Li <Sunpeng.Li@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_mmhubbub.h | 20 -------------------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h |  7 -------
 2 files changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
index 3fccd5eeecbb..7bcee5894d2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
@@ -36,26 +36,6 @@
 #define BASE(seg) \
 	BASE_INNER(seg)
 
-#define SR(reg_name)\
-		.reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
-					mm ## reg_name
-
-#define SRI(reg_name, block, id)\
-	.reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					mm ## block ## id ## _ ## reg_name
-
-#define SRI2(reg_name, block, id)\
-	.reg_name = BASE(mm ## reg_name ## _BASE_IDX) + \
-					mm ## reg_name
-
-#define SRII(reg_name, block, id)\
-	.reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					mm ## block ## id ## _ ## reg_name
-
-#define SF(reg_name, field_name, post_fix)\
-	.field_name = reg_name ## __ ## field_name ## post_fix
-
-
 #define MCIF_WB_COMMON_REG_LIST_DCN2_0(inst) \
 	SRI(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB, inst),\
 	SRI(MCIF_WB_BUFMGR_CUR_LINE_R, MCIF_WB, inst),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
index 02fafb013fc6..f1ef46e8da5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
@@ -34,13 +34,6 @@
 #define BASE(seg) \
 	BASE_INNER(seg)
 
-#define SRI(reg_name, block, id)\
-	.reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					mm ## block ## id ## _ ## reg_name
-
-#define SF(reg_name, field_name, post_fix)\
-	.field_name = reg_name ## __ ## field_name ## post_fix
-
 #define DCN20_VMID_REG_LIST(id)\
 	SRI(CNTL, DCN_VM_CONTEXT, id),\
 	SRI(PAGE_TABLE_BASE_ADDR_HI32, DCN_VM_CONTEXT, id),\
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
