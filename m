Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE2C3F2D7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A662073B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AJhmAg4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A662073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA466EAA7;
	Wed,  4 Mar 2020 02:57:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5366EAA7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 02:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kabzw2mTk/4xGNT2Hl0L/qRMM76Pkgnk4Mx54KH18KYTCLymuykhUTgCnDnJGxjtXEoa4vv5LFhdVFjDf++wv7PsLNg9APRmtoDKjlqbOXx2qBhBhpmabnUySNF9zjmcaIg8ET5g5gNAQ8uanzhPow3sd8u3PheupP1yTKR31o37kXotpRStQzeb7o0LaFXbkz2i9RFAcUPfBmZYbyNP9YcXMDDe3eLvg2dYrtnrlYYtvHEdBWeXq5eTiDf6zuNmlMnei72CWt+r66Bxs4eP+DSMT2vlklFIBBg24JM47mdXT091x5aUWCUVJ/Nam0xj18pjUiNH2oEB8diMJm0O8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBRbQYKa+53pXVt/gL0Bc/UgPe1pjUbXqk63NBIaXtc=;
 b=F0Kk7qptIS5f8bN+vIu+EHjxRZ5BowVIdkdrz8wFvBTnpVpcpTX67A5qBUZVOhsfWEkx7gex//JLrwCsclZoEe9JYozyowsGEX55K24t73S8rSdeU4d5OK0njBoyw0/k284/+dMRpHkRtXG/PtFh1HQiIQN+ozY34mDc1GPrVaA3Jy/jvQhzMylSYQQBUVESXWO7thrT343Yux+I5YaEw3biAVcm88dTouRyFsBrLGp8i+vy2QBYmPyOd4+T+nOyR9TzJVavS647KwPQfVJY1owZhs3Nwi0zFkJ18rBp9ENG+/wcODmG8Gf79GOYnICfZgIRrtphH0DjSxNZ+g8SSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBRbQYKa+53pXVt/gL0Bc/UgPe1pjUbXqk63NBIaXtc=;
 b=AJhmAg4fOirIov15xapnF95yJ7arPWa+F8/eV5MkqgqdEdkfmyHPZksgpS3IvsfKK/JmXQgSS0t8qpmJzLqCjEZfYxq4uRwX/ZDsbCl067WmXosK3QSJbN0VYdWhTjNGd38Ior7z7SRI/SgEjLbqdbcQ6y6pZdG4TJWOnTZiKBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 02:57:00 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 02:57:00 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: map mclk to fclk for
 COMBINATIONAL_BYPASS case
Date: Wed,  4 Mar 2020 10:55:38 +0800
Message-Id: <1583290538-30426-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583290538-30426-1-git-send-email-Prike.Liang@amd.com>
References: <1583290538-30426-1-git-send-email-Prike.Liang@amd.com>
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 02:56:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 107322c4-3ddd-42c7-670a-08d7bfe7b53f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:|MN2PR12MB3885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3885778DB0C6235AFE72EC5CFBE50@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(16526019)(8936002)(8676002)(86362001)(81166006)(26005)(186003)(4326008)(6916009)(956004)(6486002)(81156014)(478600001)(2616005)(66556008)(2906002)(5660300002)(316002)(7696005)(52116002)(66946007)(36756003)(66476007)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3885;
 H:MN2PR12MB3536.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/jM3YC7YTvHXodu4HXL512J/Oq2wOH0GVOVmL4G61f3q7ULNu/GZTyOH9aVu+yaaMq9HkFd+yHAsRXLXAmj+TDdLeEan7jyaYx9NGvkrUJdb0/5A0NLa6+m4/AlPqedpH0ZFEWBOVVcphiH4HaLqNyKYgo00drh1Q9fhl577U7xTXgq5+vFe3LXvnPnOTyrtw38BnyA/PedGrW9ZVXK9cvLtk6OdEMB9F8PPh2FWmj7i73U6s+qlhKO9+drkrSQrxx13VdxLv5Ih7Pllslclegy8HeToaADs22NFWSrsNpQWwT7CVBeSBeh0P9PO2mV0xl3NO+HNb/j4IQxNihUHv9eNTssgPyJXOBTbs4gGUn04f9/F6XZmypfXvqu8rf8XGV1RJiE9jT3VxXclHgkGPKch+QOUcE67FO5kq9iAla4/ds1unVY8rxDgJUjvepy
X-MS-Exchange-AntiSpam-MessageData: OsRYENwmyZh2YyXsi9XY2EfWkgNz/E+G2AeQuZ55zEbl5hAIj5Av1D5y0reouw6IUmOqoXEGb8ZFIwWMAlLa3E86T4TElXEcGRcno32D9a/f0IJ/6vm5q+A6rCWzefrWSvBTrM9CFiDAYXH+QXDp4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107322c4-3ddd-42c7-670a-08d7bfe7b53f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 02:57:00.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj32hfXOrCwn4O5+FNdPgPVEbLkSbqtTmWDCsIwL3v/d1CctvrzfkaIk3wAvL5bW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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
Cc: Prike Liang <Prike.Liang@amd.com>, Evan.quan@amd.com, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When hit COMBINATIONAL_BYPASS the mclk will be bypass and can export
fclk frequency to user usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index cca4820..653faad 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -111,8 +111,8 @@ static struct smu_12_0_cmn2aisc_mapping renoir_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(GFXCLK, CLOCK_GFXCLK),
 	CLK_MAP(SCLK,	CLOCK_GFXCLK),
 	CLK_MAP(SOCCLK, CLOCK_SOCCLK),
-	CLK_MAP(UCLK, CLOCK_UMCCLK),
-	CLK_MAP(MCLK, CLOCK_UMCCLK),
+	CLK_MAP(UCLK, CLOCK_FCLK),
+	CLK_MAP(MCLK, CLOCK_FCLK),
 };
 
 static struct smu_12_0_cmn2aisc_mapping renoir_table_map[SMU_TABLE_COUNT] = {
@@ -280,7 +280,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_MCLK:
 		count = NUM_MEMCLK_DPM_LEVELS;
-		cur_value = metrics.ClockFrequency[CLOCK_UMCCLK];
+		cur_value = metrics.ClockFrequency[CLOCK_FCLK];
 		break;
 	case SMU_DCEFCLK:
 		count = NUM_DCFCLK_DPM_LEVELS;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
