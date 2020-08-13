Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC2C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4583320768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ke97fbg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4583320768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50CC6E258;
	Thu, 13 Aug 2020 21:35:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D236E258
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awdJq+CctGyFq4e3K0oveCcw6GeZCKtjGcWDyCdXSjxMNJ793brWzJli+eDapRZlpRjDGuL9JUVegOktK1s8mZGr8AaZMSvqhYCjkR39VQ9BTUu2Lbjikg+XmKmtlSHE3OiuKXh26ANXqqHEGxsAIzpwrnvEt/1k0FyVDz4Ggx5erWmdc6uc5T1kcOSK/ybSDLw/CP/5OvM62r5t0WlfzdjK8yHb8NbplEa4oelYTc4rrSys/n8kE6/fO/Vnw8XU+2aToUQruH74UiWHfarz3ey/zXykRWiLyb+wiU88LmXC6lWVTGA/YzoY+JIE+XnG2E3jxTjaZMvfZwZ+FQ2e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX1b7QtHygLR8XO9eZWTU30oMA0Dzr9BQtyQxmm9ais=;
 b=kwopC9pOG7mIaJBMY/CwNl6FoIBfb/+xbxVrJUKBR2KsURTK25i4Wm2xZDe7jHYB4sCUjQZZLgYVqg8WVgbHhSWqxZyrKrg0wfoJwAgcUKU6FjuHB2EqNj/KGXniZLweZsNMcyO+rcWei01dBStcG63gZmYrDfvQDo9uDJNSw/0kYVvisoDhzyUD4uF67c2KuVEIMPR33cO2QpTCc0jnpM2QgmspGLq4z3EfpyiipVPA+aEyTyQq0WDCZGh3VB+OBCtzdPZUb03vrHpx2wHV9TKj+9Gpd5cy5OCbHV5uYLebcLkaorRLDg54Z2WM6LBRsdvXESOoXWtSayKqYs+U/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX1b7QtHygLR8XO9eZWTU30oMA0Dzr9BQtyQxmm9ais=;
 b=Ke97fbg+d7CDMv09Ds1O3CVhxP/XCfzZymM/7oWj6zd9BCTRwck+MsTYJ+L9tpowEVquqsDHvPzQIo4SQJJYgLP7ZZY4OgWr+KBJt9rejN+0CdczChaAis+LOZck30lDolNhsBK6wvReUF+GMwjtcN++YjxRRg9YFksaBaq1/vU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:27 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/17] drm/amd/display: Assign correct left shift
Date: Thu, 13 Aug 2020 17:33:43 -0400
Message-Id: <20200813213356.1606886-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4433fd05-16e2-4fab-632f-08d83fd0cb9a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355DADBAA87C7484C51BB6398430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE1fhIzdDrDC/6vusGaEXtjM9n8GMhSKZUuDVIZ8P7lV7GV8yVVIJsZDlIr0Kb0ALMTax+FaLczESYCFpA0kOz1tCsOuCejesn1yBZU0hFUzb96nEfhnDkEu/6nFDxrpHm3mxj0UUU96oM56S9lvuSVNaM49bqvzVHt5aAOskGNZzt20UZxBW52q28KrsL+bRzEEAvksGHnCZ8M1zmimnULvozc5XaKdLfY2BjpKAz6gVFhaD/5O/bg4dXdtOSN114+HYOtCzjQ9wwrVby32e/WD6EzG33mf6CFy5jdLMv0ohcZ2CyTS8Pkhk4DiqUJcqdLPv/1plX6oWq1gQ9hjPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RTMpafLioha9IKQt5M3ErVzng1QWbsQbu8E7/qxCp64IetHeS5I9ZNmc5XAlcUE8/0Xc0L9AwU0ATuyF/iIoGP5VmT9gSNMWl05/8UZWnRL4l9NOHsofWu7mdRxX6LLfDyF83urXxGNAUuPjABO9WI+C+uOxycNoOnIpd+Ebhc8LJvUQ17pOT7F+YyK/BvhljjJVrcgxWI1EMDTQLoLX0GbGJSvA/pEZkxGxuWyN/gC5W2HyOPzhDNZobR5uPcDtoqIguPeXlsCNZvI4j+b4RoiVVrTQkMl61mOxwd8GaerD7Ah0SeP6I7cXEG/Fva4Q/PgaGa7luCkCr0Mi5wrYv4l6HcXJf+KsSBdM0mgOEZgqbFpmj/PHIFX1NeRgYGJ6lFgjRFV8WZ/NPCZimJAnz2ndhLe/rDayIawznnD+wm7xY+IQfn8xcwh1f5GzBFHyIGPFVBFAfU1OWmh74REsJKjkH6mHqIQyFH0h792wxYKpQOrSOnNYIntuAKd00TY9x5S9FMQaL0Mo2tW4/f9aXGUXF3/s6gix/w9t7/5grJm36rZFA9m0f+MVPdawtN4qh74mZ01VxdSNg71FO21369ga2Aj6xxzo2bOqzgaGoqS9tqYNtRz2qT9zT/9ag8F1TinbTZkeDKd5S5jfevNOrD/EgP3fmgzpFDLGBWihho2MJNcH4nviaqaWkS5OfeBY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4433fd05-16e2-4fab-632f-08d83fd0cb9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:27.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkzKJZLbs9iKXi6e/iKShRNz92wViGMldzknoXkDM5N/dbrUCnUhx4mYT9gkDQki3xvvYbpC3qNyk8wzxpqhfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Reading for DP alt registers return incorrect values due to LE_SF
definition missing.

[How]
Define correct LE_SF or DP alt registers.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h    | 4 +++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h    | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index bf0044f7417e..dcbf28dd72d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -167,7 +167,9 @@
 	LE_SF(DCIO_SOFT_RESET, UNIPHYB_SOFT_RESET, mask_sh),\
 	LE_SF(DCIO_SOFT_RESET, UNIPHYC_SOFT_RESET, mask_sh),\
 	LE_SF(DCIO_SOFT_RESET, UNIPHYD_SOFT_RESET, mask_sh),\
-	LE_SF(DCIO_SOFT_RESET, UNIPHYE_SOFT_RESET, mask_sh)
+	LE_SF(DCIO_SOFT_RESET, UNIPHYE_SOFT_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh)
 
 #define LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)\
 	LINK_ENCODER_MASK_SH_LIST_DCN10(mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
index 8e9fd59ccde8..2fbf879cd327 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
@@ -61,7 +61,10 @@
 	DPCS_DCN2_MASK_SH_LIST(mask_sh),\
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_ORDER_INVERT_18_BIT, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_TX_VBOOST_LVL, mask_sh),\
-	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_TX_CLK_EN, mask_sh)
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_TX_CLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh)
+
 
 void dcn30_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
