Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980936138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980936138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC586ECED;
	Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF9C6ECD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9fo/jm4PE2FRXLvAQIylFom4/uR4aIGtOHm9lZr6HNo1AO5xiddMUEIVLHWvjcsuY4+qSxMaGp5WjcqOOzkXRktRJP48TCkKXdT9gtztxiT4/Kc6ESHwbOxz2oqjrRqrRfvWm02FMy3lSfEpHXE3ESElzw8Tdio8WatyoZ88MD4KjU+y1TPsso6Oij4QKGw26OWyISKBZGC+B4nOArP6qjspGv0d/VSQ8B3tUBr3bcbILeJmOfE8H+8EiJVHFoyfnhZNdt/rEu3YqBI3b7SwI0/0iY98B4ziccJ1ckmo6CRLhPyFznGFoBBrEkoxAtwXvuVZu9q79d+UoW4idascw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7wFAS+kKODsesOvQkAQmrzDu3O5ur0uedDjRP0x9QQ=;
 b=bIo+l01ddW2owT2kK0YW09StUvWELeonSOGc30MrQsfl1Pz+dmkAGn6dUWpar24WxYt5uo8wa2Cz+HFgVNkbgE2r9TD/RV0TB2iUe+V3WYRhj/4vh6339n6L1Kx2uhbvYhYCR8TsZUwlkwWZIuNEpjx+VaP4ZLJVk9t+THGFqZqLux0jJIMRMec/uikQ1orXiVQwq2iVP9mADQOtdRLML9E8K0JI0B7pBmo8LNM0EiiZo2dzTWntcIOPzUIWEDHD4wrZNqlyAnzoEhd8/zNdHTC4fIkGFJGL73qHSn0nQBgFkPpVmf2BU9clMQ0YAJyJaAjqJDep1FjStMoOZmMHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7wFAS+kKODsesOvQkAQmrzDu3O5ur0uedDjRP0x9QQ=;
 b=WuHishNHZQ1Si1vJDl6e9Jc8AR/DoHQQZPgG3B5agCCM0HqdlpV+TsUxlm2RrpKQiecO1Hb41vydw7OvnH5QgK8DaAezfr05HvF1y65k9V/TCY+TOCwpjg6YIOPRpNfTzkDLlWaQeOY43E+BdkpFVzfSxhHMjm7OXBspLmdCr2k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:06 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:06 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/21] drm/amd/display: Add missing mask for DCN3
Date: Thu,  1 Apr 2021 12:45:20 -0400
Message-Id: <20210401164527.26603-15-qingqing.zhuo@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96f534a8-3f34-430a-f331-08d8f52da4ff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46194916AAC1DC13C1708878FB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRHBmGFt4GVyOenRoAaMjJ72nvJUS8+6zfFSyGZ366QahUR4BRJTOPwMjlyP3+5vrdPSiuwim6V+CkelPGkFhTsZ9uifjX2gJT+TE124aH853wfOLTMaD6B0vGxuceDo4zvjEtkYb/8rQ+yib63j9IO0701ZG9h/w3G2As25DS8OIO22zVoxtskFI/kN1b9icETURAz2upuynrUx0RFOapbviOP+NBBb9xyj6GMeuCUDvtS/Kr5rJKLk6QV9GWOxKQvkf0d8ldziZJ8O/7XfWyYprw235wHH7XC10/+2vzS5EFvNpJnX/YXN7B7vHCo/rcwnj0hboHb+c+B6DnVU+HoPPjQ9q3uFnnzLgV6cDM3teHJ5SYzLcSP3pFVYrfSe83MNNNiDO+cwEKkiYeaC2DLCgsLol1vSHdM7v1GhcfwOpMOhF6tqTO3B3pNIGsXGEZr7qPOIiyzUmCsDar/DhwyY8ZdUsScCI5OGzqgWWGl/beZcHouodii5MPrU6gozwp4eg5ybvPTr7jfErHOLB1rmbzySfTeJLJUNp9MEzL5iVdO43bFXO8WC9IFnj2BzyBIX7NtWbswiI9yImbyCWSRa7nIiwxosMvSoWqpxHfS7aSQuCAEDfh8FqoFTMc5qqi3RQwePNCQpj9FbeGV1qUqjPgJZdYC+e0Y0viErxj2EVleS/Okpk90YzfKhZTG8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?asxlx5K+pG/ZsyuE8zmwTv/A8Ut1ypVIVtva7NdZyj6C5hOeY+IYJivW0ZvF?=
 =?us-ascii?Q?dRrnjav59qLaEM9MaYYay6UhVo4W6rFSHTtU1ewD419XXp2s0ZGffHWuLWlg?=
 =?us-ascii?Q?4wRH3aEeHjwqH6PULTcg2+tBugeoRTtV6pen1sV+KOgP8ONzJw24PVjU0Hyr?=
 =?us-ascii?Q?119f+Y+PM5/4KKKr5ahARLXpHPquR/KHjwxkGuBDJqMJnfp9NmRgRH2t2lu1?=
 =?us-ascii?Q?anRKFNqS9FcfCVBdLY68Q0ITH3z7xSBZe4SBkJje4uk4vJvfTy4pD86/6Tfp?=
 =?us-ascii?Q?6klGq+EdBNwDvCFeCNNNrHBXfQLV0asa5iFGeFv5D6iTpaiXo8/c7F2oAtWM?=
 =?us-ascii?Q?5T9JX2bG3E/v8gqVYkHAgwcZoGjIZxAssNEWPem30aTxxJ9K2o6GKxqIDuVp?=
 =?us-ascii?Q?Bp5GZQKfsc1bRp7ZcTFBMuwUpQ53UnyiUL0U4YukUkDLm6GiGnUocHnu2ISY?=
 =?us-ascii?Q?8Co6AIcOksBGuDkusSGlJ4cp3vPgwHAkqFSmRoq54QV+j9/Os4bhrNqn3Q8s?=
 =?us-ascii?Q?DYky8XW+zM8flRNgsRcbCr0PRoaqWaqZcII5gq25CB83xLFNKIisbxj1nbrd?=
 =?us-ascii?Q?7E9TS1g9lSC/FhAbILDD4qp4+Jvo3fA16XTZ9shP4nPorqagziUl+Km4xBaa?=
 =?us-ascii?Q?PSLsm7jNPKG4sXZ3pnLnEeHQEBF93mvtLfHUxNELoJXQhi3/NwTffoh2ojN0?=
 =?us-ascii?Q?IncPyAGUim8cREO7CUG98YkI0eEUFMF+auum5UlO0d0aqKv8JaWwSL40fe9R?=
 =?us-ascii?Q?s+3ICNAG00X0vE0XWoeJNSjc3d6B63ZFfCcE9VVPcn3MMo03cU4b/YCpCGFQ?=
 =?us-ascii?Q?46CPhW+0qQoKxsiRiojyLmSYiGk2lkgIl/PVyLhcMcrjdPI8i8xh8kna0s14?=
 =?us-ascii?Q?n05mhXgPW7yvQusLhpLWjrHBbvuHacZTXBiK9LQLmUyI9xojwj6Bx/Il4KS1?=
 =?us-ascii?Q?pUhfuWASsV06cj+clqnlyixC0vNMrJIo07XCCOj6P5lXA4q5irbs/6pityaV?=
 =?us-ascii?Q?lthtB/0lEXg9hTxa08vVOwdlNEwjp9O2FYMKvHpVc7zTJhLd/f5BdUbMr3JZ?=
 =?us-ascii?Q?SPz8L2/YFF2t8syAGc5v77i5qzOhtyCOrn9Y8wqx7nhp3+vOBDWeDRYLoP2H?=
 =?us-ascii?Q?UvdzFAx+UPJj0+bbZKn/494W9QIgjt/xTtdMKNOn9H2dSs8HToGifv+0M+38?=
 =?us-ascii?Q?A8Z7xKFwRGbNN2LwxgaF+5Jko/q9JG41nPJ09J7j0NR5P7tmtr/pvRWoGSnC?=
 =?us-ascii?Q?icYeA2+ADlx9IOG3ysBaxfWoqty0j+5UK9IlmrJzhCJvXR3ckxk8MUrlhWxQ?=
 =?us-ascii?Q?TuZI64qdtRJso2Cpp+Q3zeM9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f534a8-3f34-430a-f331-08d8f52da4ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:06.5724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCKYgqVIekibNa2Bx2CNpGD1WwZJ7+qp+n9xRROHmcuf8t9vCqtPYc2oDeRL8FhI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DCN3 is not reusing DCN1 mask_sh_list, causing
SURFACE_FLIP_INT_MASK missing in the mapping.

[How]
Add the corresponding entry to DCN3 list.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
index 705fbfc37502..8a32772d4e91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
@@ -134,6 +134,7 @@
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_EN, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_IND_BLK, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_IND_BLK_C, mask_sh),\
+	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, DET_BUF_PLANE1_BASE_ADDRESS, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CB_B, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CR_R, mask_sh),\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
