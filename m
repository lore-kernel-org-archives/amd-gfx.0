Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA78AC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 04:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D0C22228
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 04:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="38U6a6x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D0C22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8693E89316;
	Fri, 27 Nov 2020 04:29:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4C689316
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 04:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO/KPpIEgwiReBiuhPUYLpKElzTpwD6/4fsyl88XKoWCSFF1Rk2GCexX26sGgrZlFV8hSWEZUD2xi65ThU6TFZRLLZlMNxo5sTnEhJ9AZ8unOsG3q/Q8F5M6qUwCfy2y5YlDkIVssM8mCXBFI4SHS/beStWD5UAEk9eyuh2T3zq8xqOGuEQKDz7QX2eoGdF2pKBy5gjgRASxdthIM+D+gNagHtwTxrZE9fuuPsx1RSFRMC0745yYwbzo/1XAMtd/yRaFMQ/lDDOXJ9MoZOEtf6scuius3HYz6i+2jI8hqhaw3iZeOpAxn7wb5QCXA8ZYhWLVeLFHnEBGVXnZl/AWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPCktsf19t0D0Dg5MtRvkvp5+ZG4duo4LOmhYTwefQg=;
 b=PAvwAVOBeOub7muEzqMmCDPdYAg2wlLxBrAElSyXQ58HmablIb3/MFvis6yoGvJO5lfc6vC2Mi1RLYw321yck6NOCIXN9Nukd3qaNl2DQnK/cog+6Iq/NFs3pM72SCjX0D3gkyvurDU9DG/jo4btNfx5OcHIX6nZf2C04ZmGVao5gi4kCeGCuOvYfpeX8Tco0KRJ46VBMlcV1AUzs8UlIxXLBTHbWWA8DDLIdnbOQryqqyfQu3hKC9VSso6fPWUfDJ7/u/E3u5mCRSyg51IRmhLmbWWDJXAsr+8fANemqfkXxF8vaxAp3cZfCQ0yLqfVnTBgJJ9XPrlFZc2l9DC4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPCktsf19t0D0Dg5MtRvkvp5+ZG4duo4LOmhYTwefQg=;
 b=38U6a6x1B5v3ERYrlxyx60X0Z1iJsHHoCof1SLSG+aq9OQ8qKv7Dx1wiZK/qxGHMCSzVIxafR14nN9jvpx2otR9V5KYoF7YuM7XQA9bR80OAvG1LyF+ij9yCkAN9Z8LSqMHbJ9mBDWVyk6wlWEeFv1zFk8oY61eMjOrtOxD2bUw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB3665.namprd12.prod.outlook.com (2603:10b6:a03:1a6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 04:29:36 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 04:29:35 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update GC golden setting for dimgrey_cavefish
Date: Fri, 27 Nov 2020 12:28:05 +0800
Message-Id: <20201127042805.765-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2PR06CA0012.apcprd06.prod.outlook.com (2603:1096:202:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 04:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72d3b6f4-5f34-457a-0d48-08d8928d0b72
X-MS-TrafficTypeDiagnostic: BY5PR12MB3665:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB366518C06FE3E58C1EFE0116B0F80@BY5PR12MB3665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9aPu6POoHFlnttfU9+vxhH7XxxrZn4rjG3u6tLGy+tZdv4kRvsi6WbT+dYfj5sibJ/6k5C3bR8rqDiFgwpJGhC/tiarc/AngARidAQYv3t8zjiTfrehJ+wNBeapa1x7yW9ABhbfZre3F/BuKn/bYrhXP2kgUiZmnGSbwb6Fo/8U1Rck7ZHXFKpJv1YVLUz8jJKRW1pIe8VWINMyA6j1hS0VfotEJkxnS70nOYcD02j+v2RSUSwvyOms1yywVDQ3jHihwnJ+F3SRx1JkQ9X0vC57bk/0hSaf1Fw4yY8sZqcgEgsNtiHiF11Chvs716Vzz5D5cTo7MDpTMs/zBTm19w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(316002)(52116002)(86362001)(1076003)(83380400001)(4326008)(26005)(5660300002)(7696005)(186003)(6486002)(16526019)(15650500001)(4744005)(956004)(66946007)(2616005)(36756003)(2906002)(8676002)(66476007)(66556008)(478600001)(8936002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5j2I70zQVfeTVXq3rlSjJWlGcqCZ8hW0r3nAhtixBTYi3rpbqspUxnrdcdJp?=
 =?us-ascii?Q?WkdCxNwSBAayEe6y7zW9tgzelZtV+QL/gLjnB0U9/0uysnT+sLk66ZpyLPLu?=
 =?us-ascii?Q?pJqSrMuvfntkFoc2BlmYl+7wWSDnlTLkXfruZB3OUob4D4pXg8h2BQlJUl2g?=
 =?us-ascii?Q?q/ja37yic+elqhO2iFEy2Ihb1PybuVJm+/S7xtiv0tD+aOhEt8YFoZ/k43CU?=
 =?us-ascii?Q?t1FdW4fnx/qp34A8TWIPZihO/ArnPwH7N80Srwe2juj3Qto5xzUcqUtatVlM?=
 =?us-ascii?Q?aF09+ubpgmuSapaaD2tVtyLRDWvjrLdVPzVwzphFm+jx3N+SrPSlJuDQNrvG?=
 =?us-ascii?Q?CY0wIbKwEPT4it0ZzhfFdK9G8PT1IZQBuz2sO+zO24VDN8ZPLT3ff0u8yLCM?=
 =?us-ascii?Q?aq2fZpNYEQFGm6RJbjM9tZ7Q8Yu/SlLLa7rqVnRh07JhFrgMpdCA8KgYB/fO?=
 =?us-ascii?Q?QHk4qGaOnGwMUHCXKfxVF7beI5CnWOmvxj85HG6/u/8D+gUX+kGU6dDbJ18y?=
 =?us-ascii?Q?t5BUxiqauuHO1hmsE2/N8p58Bgt8eFAiX3NzSsBUL7aF7QS+sphq9bMgA0Ls?=
 =?us-ascii?Q?aChb1hWYXgl7/8XZeYM74/G9yygKaQ0i4eE4KFoKMuwBx+onaWQtOye3Bcyi?=
 =?us-ascii?Q?fSUb5qsv8uNgSA6EcKFEMeLW4goMGhXLtBJN0do3dirV3GwiUL/xsW1EFAbo?=
 =?us-ascii?Q?9Mwef4PezJ59L7QWFXBCxXZVRdq1uVqiCXIIvwwr9qDeXWC48ZtD6fLT4IUT?=
 =?us-ascii?Q?Sigo6Yg177rU28xqOLiDrCwnAC39uLlS1kHx984Uri/XkDZMJXOj2anJGu92?=
 =?us-ascii?Q?1p2imsJsjhV40isFQITZRna2jqrjzPAv9DHEy2eIpKk58oPsYtuhLldq1PNs?=
 =?us-ascii?Q?Av26bqa7edgzweYSn0vnBelS/KrEdh/gyGbcVuwdDTE0QUxNuZJZnU0Qiil9?=
 =?us-ascii?Q?wyX94Y8nsVePxzYfmeJfiGQCKeOdPLP6OecNtXdaXWHAHhI/L9SUp/2/pR1W?=
 =?us-ascii?Q?DxGi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d3b6f4-5f34-457a-0d48-08d8928d0b72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 04:29:35.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+uqcipLpclGl7Fhe/zqXhGsfZsbXs2gYqDaDqY1wBmx1Nxy8H+nUltp0s0zKtaX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3665
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update GC golden setting for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 841d39eb62d9..ffbda6680a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3266,6 +3266,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0x30000000, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0x7e000000, 0x7e000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
