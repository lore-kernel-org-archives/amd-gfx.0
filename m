Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927A7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F02764D9A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F02764D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809B96E4F3;
	Mon, 22 Feb 2021 08:44:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648BC6E4F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 08:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO5qXYfQT82NOHe0H+nK/GegORRaTtBnbAcqY7Gx7Nan7v0PoRXFPUhZyZe/2DGHHpyZYPuQx0cpGfzzqtRK/4ivvGxTaxFjctTQ1+yyHN78e17vPuTbC5V3/tTA+APNzf47+4cPfhmXG+Ih+c9FCDAGDqYYgQsZ3faydG3JhWucG33xMkY2OlkMaugcwz+WWNxZ1LULKqLTb+gAB9ZlymtSKgpPLhstvj9oEAR7oz8gE04D4+knYRO5irftcK+lZdnc38qMQXXXv72ecqEPK4lO6twkpZmu06I749IEpHdyQcesK9CG+wFy2POP94iK5MAPbRgJ1KUcfCm4s6Fr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd9edpsPsSTyRj4i8j/rKkYcUBZoyiA26FdkghGok34=;
 b=j6Wq3jvIf5aHyJDF5CRKw3Xs0gk0qjUc6G4+hc99UuZ/Gc4Fmws95JfcBRIB9KUnZbVMnpM3XNiizBuVEOeX9tpjHxpImta9bvIW1wV/PF3HpX7KsEsQNPVA67eYvh7LyMK5dEwcptGer7zPgEnxp1+Hsx+wKajh6B8H/f8nWPO+WCdiJ/jYzuL/Mc6RmGWqdbI+YtCeXSnPrB2SgF9gtnAFjc4umAUh5CYf+7obw6ASfbnzZTZFyZMW+qvRCDBiAab97CH3TKgIB/kiS0V86WC/S3M3Gd24F34ZcM3ySCL/9m3NxfH2pY0P/d9qrbWwsrAN1XbAShkWF2OmrrExlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd9edpsPsSTyRj4i8j/rKkYcUBZoyiA26FdkghGok34=;
 b=4dJ+mZZvHR7b5ibwN+3ZkNdJKHxcvEDuVbs5z7q9nvl5yne5B/BagnV6lu8NL85uDophIRM4hzGCtDskHsmsG9GzjPq90S/MpKAsSb5IV4obrZ29dT8qUMWty7sMAt1p0BbTdUuqL9DmgPW1SahIaJswk938OHl5yYoBj5c+DMw=
Authentication-Results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 08:44:17 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533%4]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 08:44:17 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: wangming01@loongson.cn, hawking.zhang@amd.com, jiansong.chen@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix wrong executable setting for
 dimgrey_cavefish_reg_init.c
Date: Mon, 22 Feb 2021 16:44:03 +0800
Message-Id: <20210222084403.32486-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To DM6PR12MB4650.namprd12.prod.outlook.com
 (2603:10b6:5:1fd::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2PR02CA0131.apcprd02.prod.outlook.com (2603:1096:202:16::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 08:44:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 793b4f80-a5f7-4c69-93ae-08d8d70e0a1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB381799227431D1F16F62D3F4B0819@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D86bc53h6akaCsetzI7rq60fGl/9/JVkM3pAIzH56uGemYe3sHRkx8D68TVp22P2dLgTVA8+mQ84sdjH5MzprdpvfOVJf3oS34R4mOKxjtEVKe+dPhXHRpYwTBFR5cQZitLfgyBfRBn+KvIjbYKIflLFz/0MouEel/dTZWkxQ8JM32p9myvRJsqo/bvSzeMw0W1vYw9MjUcSyTKJjUAkwuVqC4RhEse1YafHDX6FsPhNBcPr4WWMYF/qui7JcO0L337o8OHSNceCeuuKHSn51Ftn9sgUi9OmguomZo2Dzn5oAeLYYCRb2XJTpmV/EvHjR0zKtvevkC3X2+Z/WS7eoj6b8IgUDRsE/3gxS6f2JfuK2Q2it4+9gIPswwvrTuX9IhTUKl11H0sdWxzQvCp0qv5dHCICAt2tp5CkrDeOYEgnMLTRXcyrBaUdgB/zDP/ThX4bTRSWg3/TyCex3F1RkkUhB0qwu/xo1syGn1jbf4EhLXqBg8nvqdGtSGUj604HXkarTIPRxeRxYuhH4MwTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(186003)(52116002)(8936002)(2906002)(7696005)(83380400001)(86362001)(4326008)(16526019)(26005)(2616005)(66556008)(36756003)(956004)(478600001)(66476007)(66946007)(8676002)(316002)(6486002)(5660300002)(1076003)(6666004)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KsM0hbR14iqPponS5iPmDZkE46zjppKGKN+pD3GHcJ6GnmYgmQ1V548EQAIS?=
 =?us-ascii?Q?XldYZUziJ9fjaLWrgtAD8wO7LgTMmhnsBaJYy3L1FPvrrFI2v0RUbiamGV5T?=
 =?us-ascii?Q?ZHJeZe60fLZOaZqtw8xIG8OQULwARBgMu7YO/G/iojantzhC97qW+QFw8AJ0?=
 =?us-ascii?Q?ffhuuiJQTpjLwpXWJC+hGWkwCj+0PgUH3hRA2BwRh/T9eg551v6hcnlmZcJj?=
 =?us-ascii?Q?JD8cMOmQv7PhEdOBxmezVIfgpGt3opXP27tUDsYYCEkXAvK5fVXWR9thUU+2?=
 =?us-ascii?Q?m7szR6Pd79phMcLj05TnxWaTa5B+8PI+0eQ1K5WVYiBH1RXpYUgUENNYEaxk?=
 =?us-ascii?Q?9D9yGRKLwHBRCoeenFqc0GtWTHCRfQtxQz0XqqV4bjSfIavo+jks+kk6j/0N?=
 =?us-ascii?Q?36Nd/hRHDNVlVPOjnB1G5tEe54XYR1VqM2/75TqLlQ0ghHMyZ9JfK8M/NG2Z?=
 =?us-ascii?Q?zrNtSthVzZta25g5v6XB/hMjRYgxFqaq3tAWqB6n77HJXLmdwDTkPDTUjwHz?=
 =?us-ascii?Q?bkQnZgnouYgE0/YAftqgzag+wiplQF5xOyfvoeJfcpu25qOn9BIMUjE3zwjp?=
 =?us-ascii?Q?N+6AiNth9+RUMazLaNRgkXff3xC/Trc+n7gnfrAaxPGsRqrEtwT7pbDKxOgK?=
 =?us-ascii?Q?t0n9S5eITEkYrXc3Ahntlhl4dPEzfqKZ9jCHskHn0EucEjz2TGbZnDo73Tpx?=
 =?us-ascii?Q?pgmE52o74mtsWTvBHsPR446n48Hz+ZrZr6Z7Rzn687b3Ka71VlKDMok6Ytsh?=
 =?us-ascii?Q?uZ0Zr/N411zd/sKXZHuK0xiRic8xIEJwRTuEVYtTBzogPgA0OA+fhHboFicS?=
 =?us-ascii?Q?ftKi0VEvjno1WxGtZ7KIvWDGvCcGUz4Xk9Q3fD3q9AkVxAoVnSDgXCgqW4V5?=
 =?us-ascii?Q?D/q/y2XC5tt5iukPNqY8L0BzEPveAwXMfT3nVyIbEa1Lz2M780iZqPuufQK8?=
 =?us-ascii?Q?KxRzAXaFFeID5XXPJVqdmAh1CXsrTDcOYjTG0I+CDKF/mfoi36NO6JEmfLX5?=
 =?us-ascii?Q?f4R6SIt9+VJtx17FDgNNm75/d4ul12obMRGx7K6EpuIqxX5r4DYEzT+n0fM+?=
 =?us-ascii?Q?2DsC1u1ivGLpx+bqDk2ddw4LsSV4hjemcmNsDMSmJxOQznXlxcx1WaTPqOjs?=
 =?us-ascii?Q?ilflm7skCL6SzNw1BXhxo4qOBdIZOyusGJAo0qqKHOeA8vqHcfh0f3noUCh6?=
 =?us-ascii?Q?bGT4jYlSI/MCVfNfjgXquaPIe7iyu5Se2H01enRVpmLbSLNvctNX1rQYw+5/?=
 =?us-ascii?Q?1QWK9MRt25ZMCPJ2cr883H0/dVeMsfXa+NgDHg1Sg1EySnaMI84OUuzDBFRO?=
 =?us-ascii?Q?7a2UsKo7afwpBK1D/zqiCiAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793b4f80-a5f7-4c69-93ae-08d8d70e0a1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 08:44:17.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnvVH0b5BvITbswmXBssZ9jC3aiysUXoK0dVMHsKFJE7ooBG0QJTZ6iKDmiokm93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

Remove executable configuration for the file.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c
old mode 100755
new mode 100644
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
