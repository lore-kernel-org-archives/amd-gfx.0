Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E31C43461
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8CE6138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8CE6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1F96ECE4;
	Thu,  1 Apr 2021 16:46:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1569E6ECDE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaQ/HuRVDY7W4Xxg5WDYaRzwHScsH5nB4qa9qKq8ekuE+L41wBi6KnCyeOWoO4NWk6yKwyT4VZuGJKYyuc2dplYog6QRjwuYwltyMHom8tDhMggl0RLFpUDZRHExKPj/3C+6DeBisAlsA0zskq/RdLqDtnmDg2nojsFTNAsQrSNaAfYVxCs7yS1bs2m61zisaxS5tUClojrWQjAcPuZ7ZozLNKXvjIxxBwEXnl4viZO//xXfVQk5mMPMoky4Ei7R9p7gLCQvEjm10dTdcvdO6/a5EiVx4mQMuqGLRpCJj33wRlvFQOscrMMyi4neJNQmUSvnJuUf0UCzHKKvKqnksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGyKUrEoyRLyhCQGZm2OU3piuTbEKZfYLzznw9HPpts=;
 b=frU6Kw091+uG3hj2x/dsBN7g781fF7tBfWjQ+Kpm+yX+vdWHusgXIXJjVkoxzxGaHJcSlYX7XFOHJ70xJcnrR+JbIaoC3zzyzuvoI7THU5+JeTFpQvjDzSy9/bKpfulhS4x1O+EgXL9/BO6krYlOCE7wtPO1D7lGXuvjEr1M+rgR0sphY4Rih+fwsITEw/YJZNHNNEe1GI4dRcuZbniewmXuUO5t20rFlTHKazYLI9mFxNdINuC4ay/g4WJA0ih3l4aayvykIngRTmq33+6on2LjPhiXSxlRDFgdfGcJpL0bJ8bFFHxSmShLkobNtCbAyjT597T1HRQaNrpN+Dv7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGyKUrEoyRLyhCQGZm2OU3piuTbEKZfYLzznw9HPpts=;
 b=dYfnzNWLI93jBFIijNi/ZFPSd+0ZQBM+aSxgsRZnZanZE6tOGG/64C3gsBb9hPScxdrL8qJ5Y32GWTrwfNj19ajmmsEwSzo7mRBfNIwqgeE4GT/mNtmdlzNhY8VWnE+lgJbM5bFWbVsq4Zqj14oh19qSaerhxGAoE4h+ejmf6qQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:05 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:05 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/21] drm/amd/display: Tweak the kernel doc for crc_rd_wrk
Date: Thu,  1 Apr 2021 12:45:19 -0400
Message-Id: <20210401164527.26603-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79fe0cbe-4464-477b-b2e4-08d8f52da47f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148AA9749B1158AEDA126CDFB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMON4rIhv+05vEppE4JQ9iYE/2fj9VpOi5FLhVxy+K9jA50AhCTgI8vnELx2lYPsRsEzHfCcinoKcjzzERqZ8I5iZk4r55O6U2OMtSEnKB+sKPLFIt7pGok7HtqCPe4J3ADoRbWedhAWFXoQlUMSQpuZrd6hw35jfFhTdHbDyK0ss4VuwKRnX8ox5hItl2Lit6WbHR1QY4DO9xsP+3pA4uoJJMaaSakHjxVrEXfRIN1+V8Ns1w8JIOIxO1+K/a3e/gHRlN7vtEAVY/+sPoLR6LWufHBrk1EhJYGFZ94uvEha2B3txsRlTSLjAX5x6b1krzkjI+jkJ5y52690N59xqhdTllW7wACeONPXj2cM8AO7HpUTvujqRxrqGkC67tiX1FtxdcBsgJuLfLsicdEw14PuC+siXkF7uf2Ho8Ikqqnh2FOXQUCjzWrzefERj4FjT5fR0JOnvI4vCCWBlXE66xS1s6hXAIjFb3ihw5XTP5gatqSx0wQLBehJ2jIEMbGrbE/OOM6bfggZDgm5RmQc4MoceiR/2FgwrUBkMKCPtggf5yXrpo1Dhtf5XSbGXnySlCLqi4ktINWc8pn+ys/5YWmJyO0XngUYDcitFBPy1lPEA4jYZxsrKAHYZMPv0sho4d3zLVhxaLnmsSHhoxaDXh1Gb9V3gsyHPqnHzyZJX0osT+D+T9UESqVSnHN5sAAg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LdBG03k+hia7wukPTvwS//T6Lxtt0FV8HNm6llLkcGNR1aJC/XWQ+rt5G0am?=
 =?us-ascii?Q?2wNaij4iGNzs91aKGggArwgciu1NKITS0Cl94G5CEuU72VhFiSoWdmldZCUV?=
 =?us-ascii?Q?wTt/uQS9vC3aeOL8g2fxpFgwsSFwGGEIrY+SYQ12ilWWecQXa5RmxCH4Sbhm?=
 =?us-ascii?Q?KeUI/MBoFoVk/j5qpZzR5mnZehqlI8NzeeASQ5rE2/zQ/PE4M+MDGIsx/rke?=
 =?us-ascii?Q?SE/pQJSXoj3VCQmb3dXMhGZ4lgcEzAKr+bXa6bO6ZeUvm/orbT+DzlPLj83F?=
 =?us-ascii?Q?M4mLn1Ka2uxbStV7eShT+q2P+x1p7NAxcffRMZZEjXBaphUcOljvsalfL9TT?=
 =?us-ascii?Q?Sd6WILYs59rzYMEKkCFPLHp9Ur7kCjOKgvrhZb+oe65oS3/WUpf7FqfCbHrz?=
 =?us-ascii?Q?5SYmWens7GgKxP+zRLhXV45Tt+ODL00/XZTcQCPLHtb0k2zWDiRSvOkPqbWU?=
 =?us-ascii?Q?yuV2LB3WifJs33TQ5NxXrGWOLXqfwuvfaHCGh6PlvPIZ7f9J4AJKx7anMgGk?=
 =?us-ascii?Q?67EBfGYAxDUi9kPq8Mbt0GAWtxUeBcbjCc9RxL1PwQ5cGnxqzOGEjpYUkKOF?=
 =?us-ascii?Q?sDvOkZMmhw0S2ls1uH9SBVHd0iioilpE8w6AelPygMJrfmBa5DZHI9Tr0CzL?=
 =?us-ascii?Q?a5dthg6aPmaiillXg2c4ISfVRCMqhgO7Q7AzuUVWla8an28qI8n4zOVOtm1t?=
 =?us-ascii?Q?0UxcPUxw64LSz0y08NwZ1kYAC4aUxaxYC2/kw3eSz7t3/Ff1r0k3lmBGv1rO?=
 =?us-ascii?Q?nkRZseGSgRm7upFg1Pxb4j9y75+PAa0ZVmKugDIk2h8mNpaxGupm7EinKP19?=
 =?us-ascii?Q?96X2j/ehzR5yuY+UmzbuiMpLRLtv0SzYuvE0PnxKVxicnz34mwmxW0YVjk9N?=
 =?us-ascii?Q?qqX53fVdQ8NKOvKjmRcgbmw1OEAxqfbJDbtXgcploDdsNuVdMZOCORouRA8Y?=
 =?us-ascii?Q?yaskyTeWsrf+O/h1dSW5+rMHIiyNSY1X1Ai4mvCStqLdeBD7mgIEvHClsoeK?=
 =?us-ascii?Q?WGwlcaC23xidvpNAMp+MFw27i8UAMAe3bvbWy2QKL+La0NEdFJuxf31RYzMx?=
 =?us-ascii?Q?0gGOvnaK/XsParoVf24Ex2xDtjwFxN4CtKceDcUIz2LW9YdAwSirbIJ5R9TO?=
 =?us-ascii?Q?IJdhTgHq+TD4R0Bn2OgOjOUH8IYuQ76ohohO1deVGBusykqeadkHDmd2fdyA?=
 =?us-ascii?Q?eOz5A3+l0gzuBKtL6Vtz91dIatd1vt86ngxZ4mj/Sk94LdcJLNkvb3CpOXUS?=
 =?us-ascii?Q?f++xLToh+VApqe2RcQKh8RkYhaySQULNfRoZLPZGCrcRV7ZWDBae9U2zqRMk?=
 =?us-ascii?Q?YNNKdDkYg4ESNo80vta7HdFk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fe0cbe-4464-477b-b2e4-08d8f52da47f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:05.6949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OssXsmlMMoWY5OzcNVH6qICmrg/OM0hW/dfy5WR/oRhWO8yaYxXegfe7X29ecRYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Commit 04f6f5baec25ce76b8b6e1af63c54b6042c16716
("drm/amd/display: Add kernel doc to crc_rd_wrk
field") adds kernel doc for crc_rd_wrk field in
amdgpu_dm.h but it's incorrectly formatted.
Make htmldocs warns:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:398: warning:
Incorrect use of kernel-doc format:          * @crc_rd_wrk

[How]
Tweak the kernel doc for crc_rd_wrk.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c5f5f62cf591..13f3db14b265 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -396,7 +396,7 @@ struct amdgpu_display_manager {
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/**
-	 * @crc_rd_wrk
+	 * @crc_rd_wrk:
 	 *
 	 * Work to be executed in a separate thread to communicate with PSP.
 	 */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
