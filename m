Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3B6C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C1D61246
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C1D61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04B86E90B;
	Wed,  7 Apr 2021 13:39:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3906E90B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 13:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctm1xkatJvOkCkGJc6CFtptCv44eVL698pFEP6FaicgW0Qdnwvee6rxubuiAJMYSsFUA+WhPUH+YnpJgOogCkTsJHhkcXcP8DQQPUksWRd4Su4TV23kf6zVsR+FRb4CB8kfL0ER2aDHM59ou8rvXhoZ2ZjFD56t6/bh3eZvC8FTEV6VslcrsZKZ5UEjvQ3VwbH9Grm3H567iaY4cUbkZSvnxmOUMK9g6L0rH7yuYJAOzqTSkN3c9UyY2DRRl4HklMvCFXL/QGeV6CB/NMCKCa+Q36aJCgenaOgZKiepOGVKzuQzhxvVpHnXtQVIANzfuTLj1BbMfo77UecgOu0hm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yBiszDomqpu0kn/m1HFTD3dNzgF/ePbf71aUrKfP0U=;
 b=PSVCStECOn629LBAmd+jm48Fjve+l9nz937MUeAkmciV2rIcNUeR3uHRf15RfV9UvGGp43Jwttm7xQztcV1hy46oiyI//6fNva3tMDR1U7OM9YNv/3gHDCA0HfoOrvljRXOpQSFmlJqUV6dd+x8b6xBnE5GQNOmdICMEkvWjAFbI9sl06L9kOlDcGfs6YSmfHSDqzMyuPuzQKhC9lphh+jsUdXoc6zSaonvWFgN0UhsOREaWJNRTt2/FF2SMaxzKn3P+6AUTGABplTGZAoyt6ZZcwJJ51uVrLP0tnT5RS9bbYIf9brIc0RXarrshdKcW1hQakkBj09by6LUb+2cyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yBiszDomqpu0kn/m1HFTD3dNzgF/ePbf71aUrKfP0U=;
 b=NMO8WDhDq0zw38GwSis94b4z4LJlzuFZ4N97xvfNVBcYoRzHFpBW0pVifILQ7N6I9oh9n2oekPbi1N6tgJ4DBzn7SCjPFJjO//uPoSTXkxbf+9vXnzcpvtC94hAl3Vq3lDr7qTd4pkj8YQC+GfDdUbM4DSsz0AKYKomdidSYFEI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 13:39:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 13:39:36 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu7: fix CAC setting on TOPAZ
Date: Wed,  7 Apr 2021 09:39:20 -0400
Message-Id: <20210407133920.314018-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend
 Transport; Wed, 7 Apr 2021 13:39:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2ca5e1-b6ff-4677-436c-08d8f9ca957a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4991:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4991326181B818CA40D8FB61F7759@MN2PR12MB4991.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y42gdv2hDNsk91+V+TNGWGAM+HNkaQq5MdXuXO/quW8Hc0pVN53QCfl1UQpxa2gPe8Rnkb+c6QCV4qn6wCeB5mZ87J8SFaGHpFGPoy05zHr86hImxIkCIdNIZ+Kl7jD0ntqCWpdPdG/hj2yBBAznYNH58PYmaSD6uAiWp8yorygh4j2v+rB8G+lCPHH3PWmm2WTTKRxA5Xw1jx5xyzdLcXFy0pxonQOSs4KBeU18k2im2srK5149jWzTtx6dt9W0kLaxNdOGOn0kxc7Yjj0u4G1eg/1n8pWQxc+dEYm0dQ7qVoIcSd1rU7Xaa2SqVBieqw/l2U26TVFE/fTa9mlWeP4Ke/k81gjWIed6QRsvLquKGjZsp4S8TSSlgwcXgJ/ZTUjAhm5IPvO/YKIpvgU8fJ95ztGblamzip12CsTWsBZbhC/k9lZOZD/6I9SX25qtMHTkNrd79KfB2DOnKog3cVF4364h/MNw89KqF6rhI65IuIp24cnPHmKW0Ra37+3T+Nr/gYSi61SyOHAi5z1aSzTChyyoAaLLcSk2qHn+Q+uMIeO9K1cVWIlhzmV1ZJlsy2EZuFW4cDH5gq0Sg8JgAIWq5BAKhM8S6TrX2E6+kYHaMSaloSCqE1j1TBTPJ9VzkJ6oXOZLq6rdH6R04va4QPgNxGM9SjCoCZbWH8mqqC6Vrg+55bGezJ3oPy2tU/2xsP5x8clPi6A75S22UM0A2wxue5BsJYtMAH7b9Ox/x45Kw43iB98MTp/ZI0AIfx1f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(1076003)(6486002)(83380400001)(6512007)(6666004)(5660300002)(478600001)(86362001)(6506007)(69590400012)(4326008)(16526019)(186003)(6916009)(8676002)(316002)(2906002)(38100700001)(38350700001)(4744005)(966005)(66556008)(66476007)(26005)(66946007)(956004)(2616005)(36756003)(52116002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FyQAXlOJezFcb+Qp/C0f7QbXHUmnM4/w9qBUK9xCKED+CG5Q8pO2AiLEWj0J?=
 =?us-ascii?Q?Jww8N21EcrAQaU4WT5Feppf8LIxu+UyRPBP0rTyTJMWZvTbLtPiHYMOwsixi?=
 =?us-ascii?Q?IP9GjHqx6/O/2oIzVXXQQNAHXGnJpF5C5Tv2r6wktdIfPgJyOwlMx+kAznOB?=
 =?us-ascii?Q?/jNh8QopZwMD6m0py6And4AdXoZGFGBirSI10Gv2IGe0uDb4UQu64LpzmPg2?=
 =?us-ascii?Q?b4bJfLi4tMb/DlCTAjSZzKu7C71nCi28aGFinjyRzs8kGZVrxWkys+4m1ZnC?=
 =?us-ascii?Q?JvqBs0esdbMy2MJ9tVICNydLt5uAnFV4HXIdD9y0qZ0kQxsnJw8BuLCdAQA+?=
 =?us-ascii?Q?Syx0Wrqvw1BX9LLE7mwM2ozOp61NISpjxaWiQHStlWsi3rhPQE58k7kNdfyW?=
 =?us-ascii?Q?9t0cyxebcPhDt8XNzGsRqj389X5OFtgGtSD4GBfB5t+NBRe2VSsdvhCKtbg/?=
 =?us-ascii?Q?HnAwcvj4IobMj8sjkprZjmkzBDwTe8LWISiiRIT51DU7EojMjDZUIOOApEHM?=
 =?us-ascii?Q?yY+HB2PQ+RxVlNSs3LVKOWNdLWY8zhFebaTZ/OImixp+nAEFQkhBXH5YEQxX?=
 =?us-ascii?Q?bMLHD56K68S46AiuS1Yiuv2DEsYkkE5RBMyZM2UtXx0WvZkgxE5bOZzvC9/Q?=
 =?us-ascii?Q?KlS6/zkqGv83LJMyCxZZk9lT9xtC83xxqcKxspcLLihFn7qRYw/KM9Z9i5Pg?=
 =?us-ascii?Q?wExnml2LZrHbZ+k3hNTCFgg3Qqjloplyd9DOFF8mv1bOf0dtEIWnO6QWDfTV?=
 =?us-ascii?Q?CmP5jj1DkaZqzfSinJc7XrV2+7RvNNt3pcDSYBAmr8V7GSa3TIHBNAjungAU?=
 =?us-ascii?Q?f9+kBcXyh92dH7oJmt81XYCia7XHxMBTAQxKdw6pIV6R3U+w2w2nZE/RQkbT?=
 =?us-ascii?Q?yFG22Goq8/rUm16j8a4It2Yxd48OvK+JnbLnv9Mgj1bD1B7NFr/gpIj/bKW3?=
 =?us-ascii?Q?lU3v4E5/Vniwl/Cm7GoXpy5TgUcvVQ+ioX9+xLheL5FZjUUhVpM3ziR13MLV?=
 =?us-ascii?Q?HGClj80ldBcAyXnBqrYkqxrYQGSMtnHJ+WW4NRSX8OCC8DWyD+wl+tWWaQy7?=
 =?us-ascii?Q?ddV4TpeNNEskQNbW6b7XcTI5EFXEKG/OGaYMYUnrFNH/u1Al1Z7VxnoEuuIA?=
 =?us-ascii?Q?h8LB/LoZ4BtLCEYfr7wHjE5Isrmt9+J/Zg738LEYRhtY4PnRQDlftsxyyVv8?=
 =?us-ascii?Q?04ngx0NzsNzO9/VvJTWJ6p/yTxsUKQi7rQa8Ux06RFDTBuhCk4elVeEGyk2u?=
 =?us-ascii?Q?XySr3G70KR4efEJkyAoyAc645C+3tmx6tw58B4+PqF+BH6R52H8nzy0dSfLb?=
 =?us-ascii?Q?bdVXZagY2UUvWjNrabp+KN4M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2ca5e1-b6ff-4677-436c-08d8f9ca957a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 13:39:36.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX53WzuSqxTJyG4xbDx+U4RdZt2mznkbKwAo2bhARan7V07XR/kreLMB6HS+SQsKWZPzmEg4T9TmWHG+QsSsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to enable MC CAC for mclk switching to work.

Fixes: d765129a719f ("drm/amd/pm: correct sclk/mclk dpm enablement")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1561
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 301b6769f007..0541bfc81c1b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1224,7 +1224,8 @@ static int smu7_enable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 		    (hwmgr->chip_id == CHIP_POLARIS10) ||
 		    (hwmgr->chip_id == CHIP_POLARIS11) ||
 		    (hwmgr->chip_id == CHIP_POLARIS12) ||
-		    (hwmgr->chip_id == CHIP_TONGA))
+		    (hwmgr->chip_id == CHIP_TONGA) ||
+		    (hwmgr->chip_id == CHIP_TOPAZ))
 			PHM_WRITE_FIELD(hwmgr->device, MC_SEQ_CNTL_3, CAC_EN, 0x1);
 
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
