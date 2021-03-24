Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE82C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DFF61A0A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DFF61A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687136E19A;
	Wed, 24 Mar 2021 13:24:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8876E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 13:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRNpHZwwAfNqlpdD87LuGdj09/Ek1UvRDQiIJRGGGLRSP80zOIUctcFGsEyGZY9yWxo8bZByX8IkACCEr/HNpPA0Jpb/RJuU9WOXgt4VwsAe5WOVcJmaEhq/9U+XnZ06y0w0OksSI7agXtdKhxslnQYVDKv1njlaYz/2dk6fN/1G73UiLbOPBz7tVNCjkU8OHzNuo5sV+9qBxCtVtpzlzEN2ZO12K8+hZb3MPcigaPrEKIG6SIyBGI4n9Q71zv9ye2wVGkKNtbkfdto6riqXzbeK4MOBQDOKzfcdcX2G4h4eLjVIgHojUVhmZog9eesjI0kqbIZav2vhbZ1Z0tmfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtt4aAqATa1Bnt7nLA0AUGaes1KjxLN8kCyfr69YHQI=;
 b=XQr6gH3nwdQqvEajI7/Ry5eakL6JptaHT4RylNT72+ZpiAy7o9JcUcaMLHRzpmQYqZHgHoZJTpdimjvgg569FyldE4kqI7nyNdbA9pqaWIoR6C9IbLhnVbbH4Z4qAvjEflbQYy3duaTbgcirH/5NaZjHpYOMxNNORwQjfFgI0RQ5MsQDiK7o5Z/76b8no+Yghscgo+zJqVD7ajxiuIc26jeCXpF2zypMJknbOEeEagYRI22wnigPI08hcUJvnSKbrWCy0yjyNTpWiHA+McrXQqdjCeHJkGlG3PczQemNpW1YXG9jODICKwoSxnhVZc9fH6JwMkpBUqUh5QTMSZjs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtt4aAqATa1Bnt7nLA0AUGaes1KjxLN8kCyfr69YHQI=;
 b=DOhjGVZxpYJvQAMdKvGe0mKBFmsZzkpT+GVwPEfi1NUT5nK02oSxZ0TlEGfwbY49gDpztAUaC59fg/CFuTC6q6vu2Rqcg/HUwhL09wcAdpvFfMnzko6l0fLPlfCI9Y/ytCWQGFDsBP8xohVxD6shGWJMkya6RHSVGZzQKbn4aZE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) by
 DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Wed, 24 Mar 2021 13:24:22 +0000
Received: from DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::b108:11dd:c588:8b]) by DM6PR12MB3404.namprd12.prod.outlook.com
 ([fe80::b108:11dd:c588:8b%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 13:24:22 +0000
From: Philip Cox <Philip.Cox@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Set amdgpu.noretry=1 for Arcturus
Date: Wed, 24 Mar 2021 09:24:10 -0400
Message-Id: <20210324132410.12754-1-Philip.Cox@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To DM6PR12MB3404.namprd12.prod.outlook.com
 (2603:10b6:5:3a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pscox.amd.com (165.204.55.251) by
 YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 13:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10050ad2-2672-4a07-1f28-08d8eec82351
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33058FDA29522DCC8792B52C83639@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWvtEvHMr8/QAubckcbO5DvkjyeIf6PVSRXc16oJBYALzCvTjSVa111ZAnKF/85UlAexj+KvBHk7nh/UT8enHzhv3MoMLFuvhc/9sqFKylkpd2mqEq0bdTa5ShFw5KFsP6eqU8ssZ46MuncrRBs1QXD4qEOAik1Ypy9wp4Bi8Fo5fpQTddptKQQMo6OyGVSYRc+A5gAvOFlY10KqQAD/HGsw34B1sutrDIdWmW2vA9lR55+AvOx7YOEqNhcCBHw48fsptOc18erCAVZ/nIi7nqv0TZ18cJ8DWvRMpEWwaFr0PIqGrdFmUiwJ49VG8DY+lSp1yKEoG/KRD/nQ6d9dKodOt0KRQMGWBJeEG8c1YDfsN/qniTRYe1LvrszfI8+OI0fdFv3x9wxYr2boaZoeBseeNIQ9ZI9yYlD0cq9pNUgNF18NUL2jOuagVJsT/k+hMTMGV6OCBmdTL7j6HJhbigLu4hbVcleyO9Bpe5+aDKvbm5kbglmWXnnaAqq8VYdZ7ICr25U8QOkTKZsaId7R5c7LGB3LQfkg9Iq+5fXbuVKr9ocPheJs7OIFVx3OGLLlB4eNz8/fwtZkhWCyJY4h/JO4JvJyJfHH8qzgvW2OjBUAHQjtRkdU/2fwSelSpmnb8esi9A4jkl+BurpFWaaLfXCr8UPkEzjM8g9Q480RlWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(7696005)(186003)(5660300002)(478600001)(52116002)(6486002)(2616005)(6916009)(66556008)(16526019)(6666004)(4326008)(66946007)(8936002)(26005)(66476007)(38100700001)(4744005)(956004)(2906002)(1076003)(86362001)(8676002)(36756003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8xQqfy6wgDZk7A6b/bLdusQo8YePjLPPnczg6JZYyrGb8rFmp+Q9bf5t9bsD?=
 =?us-ascii?Q?K9TqZy2F4PbjsgQjo8RrceunFEyVcRP4UWDUTVdJV4bM1Hzo84Kt12E15rZU?=
 =?us-ascii?Q?NRes6KmzJ93l3JEnyENHK3/yKgRR45tgfuaCGpQg07SMDl6thr7m/eXPJBnJ?=
 =?us-ascii?Q?glWA2Rt6UV5QCrj2wCO0jB53mo/bMAdIJKHFvq2Ybqji7SXjcH2u56JWDxuB?=
 =?us-ascii?Q?FUX94sjBT2L0KWy3BQGM2rrSODOwCIL/oFqYbLBFj0nUsxfP9aeolGNAmDST?=
 =?us-ascii?Q?o481+WVKGsMHtS2TuHjO+D1DH2kiZZqrvIzt7PnazEYpYp+Cjf5YMMk9t+rB?=
 =?us-ascii?Q?5w9moEo/k7uUncVNT8yVarH2me9U6OaFxr2QNS+eTASNjQOQCcLs/Omr4m4i?=
 =?us-ascii?Q?uj8f1SSXesDexwXOWHpai0DCt1JddbFbcGgre2arSyFstKoywIiN6Sk4HmAZ?=
 =?us-ascii?Q?XY9qmU/ArgsKXRw8r3OclcI43GNV/hqUqk+wrr/RQkO3rC4FpJble03LxUHY?=
 =?us-ascii?Q?npIxHp7cfmwwHNbk2gDSVqXd8ZlcgiQavCho0EoCPT+/5z0lnwIeLyOksrUo?=
 =?us-ascii?Q?380v6EwL7KNt0ZO92vTqzYTZS9yEMfuTUllvHni5KORQPP2CBar6nD5f/Tuq?=
 =?us-ascii?Q?m7VZj0ccuhAqlgnqqY2JiLtMUFBYXGADBAdvSZbDShXhZ0Nh1L3k01VVr0wP?=
 =?us-ascii?Q?EuKmnuYtWGA/32nXLW9m+5KzsMlWdg6bH3BD6tQArPaC5jVczWzXqTwfpBeG?=
 =?us-ascii?Q?cnGHtEBp0eew+NQAANNreibi6ggXyHIx/E0Z8dfaD87DjsMTyXSOR5Hvv47a?=
 =?us-ascii?Q?SB7nzbw+d8R/GYpzvPLtRmmbOrtyZgiIvZCH5hjNCJVN/7+WLGStFTHh4JLJ?=
 =?us-ascii?Q?4d+vdV7d84Q1/VGTQWlMawERkRWiorueLrrubhZA+VSiTem1GOpb+VWvdfap?=
 =?us-ascii?Q?Ezi+wiYiIZDvYyFsNShG0tRIS8prBwVW+8MZR8AFuU8cB5XtIppYi8w0oSAD?=
 =?us-ascii?Q?tU5oBESl+jj2Lx4QAlw0kDnmeYZnR+EC3uIL6GKAkw4oQ15hUtH8YtugE8O0?=
 =?us-ascii?Q?X7Pnawwp1dUtPQxoQ3LvubN1Rz2060mjLDFyozsm6I96zO+7GJqj050aQ4If?=
 =?us-ascii?Q?HasySXZ868E270IyQ1AzpsrYUl3pvAIBXWnvqlG+mxon0DFQH0heqQWnO0nb?=
 =?us-ascii?Q?PZvDBvoKFqEkY8sRi9gWHNLPNVVV69JQwR6eRSQ55xlKNu64DcIm/7ZzpSYt?=
 =?us-ascii?Q?xszJlRQEYrUTjcQJbsnP7UtnKsnWWsSwG0hcmadwlJuczoGpTNuCuHb1Ud4U?=
 =?us-ascii?Q?OVKMavnYmMfln7c64aUUc8Ng?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10050ad2-2672-4a07-1f28-08d8eec82351
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 13:24:22.8512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzAXII9PcdV8UcX/RtsaxE4jjd3eUAylE90AcrGuu+80P7hm5VlSxcSf8ZrKX7sr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
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
Cc: Philip Cox <Philip.Cox@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Setting amdgpu.noretry=1 as default for Arcturus.

Signed-off-by: Philip Cox <Philip.Cox@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1e07c66676c2..b9d68fd2610c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -516,6 +516,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
