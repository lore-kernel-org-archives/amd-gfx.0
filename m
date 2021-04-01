Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86616C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529336136B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529336136B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08886ECEB;
	Thu,  1 Apr 2021 16:46:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E866ECE9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePZu9FrNL7bCASZ3DZ9q3c3HztceGEyDBUusIK6nMb3cAMByd2IoRxgts+pgvAld8Bz+Fx/2ImNKwjrVLs1XW5tg02UJnodPJYQ2mJ14kX6O6BhSqZfPku/zF9v21nxZfOD1w0JwwRPuRBJXbYnGcws8QvvYdu0rEel7kGmYuzdyHcBpmx4S3BeoqRlgo7t0pEnMqjprlLyui5GFwzEpMeL399woKeQnUPx2Y+q9ydhGfmkkJJxCnnp+++ya2QE/MpqX6M0RfNT1vUkiVFF9QQmNQTAWW7TxZF0IPwJEXhYhcDS85xGxTRqRgcYDedGuqATvW3/TO3e6f36T7B+YLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7uVr/+17SMYXHXgx8QjjISDr91Inydc9CCNTq3mSSk=;
 b=Z5xAO+siIm3ghSNVsW2wGe8f6Bp56olx+ViPyyrktcRvditBJX5GXIJF1gVv3zzF44wZRlcrIsuqZqT1ECtuowxI6pPu85oPThtnrE+RWCzziB1ukdFucWd1bY/AnQ2VjEaZzrr1J8WPJhJ28xUIweoGpEd0R/8oVf+tYRPzGq/MMoTiwi9ADUXxKWtOOeb80++wTYofpb/BCUTstkmFvwbck4AfAYNq6S555K8A8KmTyZG/wm/nM9AXsQKB/ScCXqgsATM3IwsTK3sVe4fiwdego3eFb+tEyBmr0YFZix3EwYuLF+VRXVpMBixx5/4W+pjUWC0J/R7AXtVEo87xxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7uVr/+17SMYXHXgx8QjjISDr91Inydc9CCNTq3mSSk=;
 b=Jzyl3UKMkWloXrlFS3CaJ53MglFkqkhXdkiPVDcARZZ2k96CvxYs8S0PvQ2/TStqyE4jf4x1u5yatUWZ218WxPTJT5AcJV5cLH6PssVvhXsh36ntMJwhvGp6RaTmI7kQWwV3ZdeuIkx1m5bj4x/EPupZ/di2ovARQaVfTxFYmws=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:04 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:04 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/21] drm/amd/display: Set initial value to a divider
Date: Thu,  1 Apr 2021 12:45:18 -0400
Message-Id: <20210401164527.26603-13-qingqing.zhuo@amd.com>
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
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b41c8f61-019e-43fe-200a-08d8f52da401
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148C6886D1F5E1343DE098BFB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbZzxK72kWzQvr/7bM1xc2d0xWxxU925ev97iZ97GjCeP928poyAtJvuxld+u9HB1guspkM1IFsRtP8jLtAAyZtC7LQaRWG3BwR9qT3zsPv0GeJKIQZZOjmUi3L4fTH4++QOGL1X2wCaBqEb2r9x8aEKXWfajnngMKU/oYLJciXc7d7VRjFC55029x44U7Z/YPhrQc3BRFVVT1EWd80JRqgxg4opZ/RjRawS0uc94XVS8owiAZDO+WrKvybBpoxb/l5mr2zWEH9LJFnQOnwa7YqiDGIj1k143Auig9BRNFcGuSN5iHI6B/4tEs84trBJPAwVcfcEqq+Z+jB/rOgIzLjuzspUTbMi/mBuqkj/5MAvHbQ18I7mXfFlCoh7exVGtd6B03jo9txqEnHXfWn3dL7PyQU8Fm0ipeZqaRxgKCmJ/E8emaTftMuSbAQBrwd8nEGaA40/AAwMZ0VPWSyspKpvYTecjUgcPRPS5J2Td+86tUGZ8amLEb2P2VVq2qNVcSb54KB+CgQ24q77eWAW5XWuyds43Yi6qWiM/fUeiOxEtSxr41bzFuoc8Hix7NKTc1AmRbBDFFWnaeTDyhsY2B649kqIrGITSTy87L07AGCdxh/v+4xNAC/gjsPg/1myQ86WbK+HExOGoGPUt5vDR4elpVz1F9/HhkWZCALtzhfZC5bVUT5uVAj5n9PYEZ+m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u+EhVxKBXeaBRBShKjEZz1LFW2vdebmXAtUldi7jbuhphWv2W1gPXJWlIn+U?=
 =?us-ascii?Q?1KHEPwkuDvWqKqLvsUGCN/eh2rm+qqotxo5yNeOMcDIhVt1rjRUmAOGAwxgg?=
 =?us-ascii?Q?Gk4nghS5z8ihJunUPH7NMb4K1GmxFpxOwddxzV97bag8Y4nHuiUvPSCIRRbq?=
 =?us-ascii?Q?/6vjYgM+an7nr1uQ4B3npyyDSuip/mUa10j4zu5ycMEm8PQrvCt8PoVVUh3d?=
 =?us-ascii?Q?1OI54QBWc9kzDisHRC9XV5JHhfSWCYaAOrtPj5ZSxyLciZ1fGyDL3Xx+MFt7?=
 =?us-ascii?Q?9j7f3gBnuXGBhsNMvEUwMHxHPKmsNM/Yh/hKVYpcWySHVtun/73SDBWi/EFZ?=
 =?us-ascii?Q?9w0BLbGd48GAfWfoML5LWo2vQxQ3IO3WGAC59+ldrHub8nue7RmhbdrxA/pY?=
 =?us-ascii?Q?9HhMxu347xgUO9V9hShDB2BT41D7Yzx4xEaB+dJbFGlgZSM+5UtNLZ8Quv9H?=
 =?us-ascii?Q?PXWloEN77m9iro2F90Ze0qQSvGBD6ZM/yk1fO0Irhf6b5iazaLmkNEiXByVb?=
 =?us-ascii?Q?ygUXT8f7hLqw4EUDTcMKHDcnHvKbBtMDTUbBum15sEBxgGMWg9fQWoSn5p9o?=
 =?us-ascii?Q?khEHmVEOQx2guv9hYGKZw8sk1NlaNl+u0p3kg8GwKtdT1Tr9/1xnBi060cuQ?=
 =?us-ascii?Q?YVjcC5MmKg9TUHNkn4P9Akt6pr19epXEIbBgTc80mbryReZrzq3hUgpAltwI?=
 =?us-ascii?Q?dYsWWrLKGG8/WJIXM6yocae1Bry36q4l7Zs9yjMClkJfkRitBTEPzYgfc3uB?=
 =?us-ascii?Q?4G4MqZkMAYeTOailxkd87N9/yRmHgDYnOkv3iKlrLe7MnHjJGpznfj4E91ke?=
 =?us-ascii?Q?v+iA/9n76xmQ+LDXl8srwRhKNrEAjlCw1x4V3gCmA2HarYC3RgAGgAbH3J2H?=
 =?us-ascii?Q?g80UiQ0GdJR8n85JvYLC0YlKlaly+0mh5pKtCmPaZujODSNlwjKVP97KSOq8?=
 =?us-ascii?Q?obXeOvPXQKV6Ko3MEUgRa+7qH9Hh9m2TLH+j2DQ/I39F0s5oTfw733na7HM3?=
 =?us-ascii?Q?5M2PNGBzbK8xWieCapT3/lueNX8yC5us1m2ZtlyJsXe94SABUEyCGOU2Imbg?=
 =?us-ascii?Q?voL0NDyHw4W2aE+Baqy0meShtgKNVw9b+mCI6GJJdNz3UjicJkueiYVN/F+5?=
 =?us-ascii?Q?ATY7TDfRsNy9yRZLzfVFOpP8pr1zeqfvD3T5eHVmofAiKqQ7hhO5+H4qGdTj?=
 =?us-ascii?Q?GkVQkQ0C4H44sBV6u3RPnj3KIFCSlwRLf84H+reFL5wLIfDYw19bV23trPVS?=
 =?us-ascii?Q?LpEZltMFCqiZ0vofyIttwsSLut1U6MDzfh3V7IAxk2xSy3Dn9Gd0Y46QWZ3Q?=
 =?us-ascii?Q?UIhUDACPIHQe+X8x9QfQxs85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41c8f61-019e-43fe-200a-08d8f52da401
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:04.8284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOsdXWDQvU4HTdhfPEtEX0tANOndMfCQFtszdGcXA6sYZbfsUygVyeCMK7LTBFLC
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why/how]
Due to compiler optimization the values would be
passed to the division function uninitialized
causing a div by zero. Initialize the numerator
and denominator to 0 and 1 to prevent division
by zero.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b2b6e26f160a..29bc2874f6a7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2891,8 +2891,8 @@ static struct fixed31_32 get_pbn_per_slot(struct dc_stream_state *stream)
 static struct fixed31_32 get_pbn_from_bw_in_kbps(uint64_t kbps)
 {
 	struct fixed31_32 peak_kbps;
-	uint32_t numerator;
-	uint32_t denominator;
+	uint32_t numerator = 0;
+	uint32_t denominator = 1;
 
 	/*
 	 * margin 5300ppm + 300ppm ~ 0.6% as per spec, factor is 1.006
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
