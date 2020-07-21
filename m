Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD8C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 06:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF6C20B1F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 06:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nVkyyB1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF6C20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E11A6E454;
	Tue, 21 Jul 2020 06:30:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B0F6E454
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 06:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQJgbGyn4FvRclMVs560FdIixqi7eSMkHs0mJHQUyvyaYJF1VltJj7kYeRWVSWazKCDXDW10TZkpwKCvup1pf/3OYTsvjlc5zAdIn89q8xkBzoU8dRBDZF82ltwaWQOvf+URXuJNb9DJj7rhTJsf5RfYinpzNxRrraixkUyX6gOkRsj8Yeqhu+yWoUERncwCjOy4EHNxZ3TNp3NYTj5vr4iOr1NJMS6CIuUhmJkOG8fQRNG2J/e15xJaAbp52Aj8I78hot6AQSv68zR6dUJ0v1wrnE6PscpnMyZ8e3tGiGMpsVaRN6W1oHk8a1YCVLGGGX6rsK4nBk5W6ITnBwITeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNPj9efWz8tvgY0GQcMOZ7eBceEAV1Dgl+oxfzBrCrI=;
 b=WehZBUbvFLocT27oaIdeA4kyWOfDGOg4FLCgjHR91foP5INB7l1ST2XdXY0eo+KqKRvJ6tnjPGGcPEPjQUS8NdUONNa13qkznTzknDA5GifPTTk10jc3Hlnpi7EstJ+1sztJxBIOPfr4/sVMTJHyz/PJT2JROlYUVO8UxYg/leEUEuMcwwvxEdDMwRP9U1QCeYTWVqSBth6wZAvBjwl/P4T4iek2kKHQwqL7B+d6qOT23/ATsPnXKYxMMULTIp57VbElMvhFErq2fahcMlxO6GW0VHSCwx7qwlPGutcsCAnabD4CyaqigXMrkEQ8GihFI6mhCiyV/uqkonIWe7zAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNPj9efWz8tvgY0GQcMOZ7eBceEAV1Dgl+oxfzBrCrI=;
 b=nVkyyB1WtSZA9KMnuYTfLNsa8yGaa2B625ijGCUZA9J3ZvvEKqwaY6WCV10WUVS6yUiQFVhxxSryX6Q2Z8OWa1DX9CsEWVw2hglEA0XPVrtxLdWzb/dlyIButsYaOT3QMeiugRjeFd3NQl2zUEXvVsGwDE1pyipzlmwxXxWIDjg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1373.namprd12.prod.outlook.com (2603:10b6:300:14::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 06:30:12 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Tue, 21 Jul
 2020 06:30:12 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1 state
Date: Tue, 21 Jul 2020 14:29:52 +0800
Message-Id: <20200721062952.1255025-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:202:16::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Tue, 21 Jul 2020 06:30:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6d0e46f-8fea-42eb-77af-08d82d3f8573
X-MS-TrafficTypeDiagnostic: MWHPR12MB1373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13733AB0B7637D1EB94D5AA6EF780@MWHPR12MB1373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZF85a1bhCqceIO+NBnXdRoxzLrtDkAT5KG4GBUk4MFCzV2fMBtDBO8fr6QppEbCwpVjYgcXy3BTi+pP2SVPblN8skq9fR1YEtPvl7RJaYSCXVyuwHXcCRty3rIyIb6YprM1m9MYyWVqwNAyYG+zZB4hB5kYBdvrdsRV42wckb19Ak+2PZWuwWd5V1ReJUO+CCE9D/T68Yc6k4MW0NRWLb5ktuSr2WsCghHyh6uGB5P2o+1hay588ytIfs7fH8r3BuWvGOv3VbQSwDqVy6qkoS+zliDM9N2zjmdgGILeZg1+8bC25gJPH1FMVISjTG1wNN5L/WKtAYliGMnJkVFn4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(83380400001)(54906003)(478600001)(66946007)(8936002)(316002)(52116002)(86362001)(66556008)(7696005)(6486002)(66476007)(6916009)(44832011)(186003)(4326008)(5660300002)(26005)(2616005)(16526019)(956004)(2906002)(8676002)(1076003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TcoluD0j5CJu/Oo9sg/bD4X/EkIAbRF5XItVAIrOF23pMNIgj3OhNRWu8kE3TAuM//36Ivw/ch0ayJt+H7D0mdTWf1epSGQHInX2Lb4li8ONG1By6cRcyS7Q7uHL5r8kK+QQFX/+W7eYqqFsijEJKjGZl4A7uONWLgWfge0zyYwaS/30bYx5ui07JDKr2809y8TFgr9zWKrVz7PVCHYqTyCR88JXd0GxPSjHL5bkw1IP6+/GXUUe59cGvDvGcWzwHivBIQ0efXlxSbGbTNFNbCCZ0FHQWNi3HViXHy6Ein7vtcA15+T2FEzYFe9TBYxcS4GzO4sxXTiJQUVOXO3hzw24qqEeWVrYaINbPYge6WBp2BVSa9/dqdGOc4L/q7Ii1vNyUQl2phjEZetJQStPuSg92ppBttB2VXslZYXwFcKJ4pBN+s1cf2uE9OETiEbEi5OJCoHVwUk0MJ2mGNurKDvbBjQ5po8DZ/5Y7biyLa85e8jmWxZStbziGRo+sC7a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d0e46f-8fea-42eb-77af-08d82d3f8573
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 06:30:12.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiIsgCneuDTrjNlflC7zRsd/AYFUCQQkXeCNKAyOXkpzT+fg2aGhC0AJ6P2H0RXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1373
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
Cc: Likun Gao <Likun.Gao@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Some asic may not support for some message of set mp1 state.
If the return value of smu_send_smc_msg is -EINVAL, that means it failed
to send msg to smc as it can not map an valid message for the ASIC. And
with that case, smu_set_mp1_state should be skipped as those ASIC was in
fact do not support for that.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I31b40b87532a1d7549b26155d4ec8145b5e3f101
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b197dcaed064..237d8ab8b40d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1590,6 +1590,9 @@ int smu_set_mp1_state(struct smu_context *smu,
 	}
 
 	ret = smu_send_smc_msg(smu, msg, NULL);
+	/* some asics may not support those messages */
+	if (ret == -EINVAL)
+		ret = 0;
 	if (ret)
 		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
