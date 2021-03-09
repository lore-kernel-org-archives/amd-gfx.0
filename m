Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47E7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A7A6523F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A7A6523F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67186E908;
	Tue,  9 Mar 2021 15:44:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B67F6E908
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 15:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH/tFY5mAAolWHKVCfiHaRq4xDF3kpvNC8nY9d9vTUfi7HP0ZRcD+OT6L+YW+jWH6Cs5UIsAuo1SBWJGYjxXBk4BA+AkBK/2JKZLJfkiw92wZGy9zXEcVl91iatghNjrgX8UNJwsZp9aoOhS8nVVF0rJ9b5UWZuFIqB8u5qub6+gX1bBOPOHKc3x+PrViDI3nVGz69V7JQ8A+e2V0ODn+m5ES2qDHWGIpoq31MdxzgG+pGxA9o5pXd/9vfvBIXkUCD7hYmYmaBRNPwYsoKq1GFk5yfeKgXxVPzvYQnzQIk/es8odpx7t5ai1JUX8S3iir+A2aZKLoCRrpY2uurgUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAKGyq/M80ralhUsLW/h7VXP7Q9lSibDhtSE48daW7g=;
 b=Dzp6ELSgHXdtpr66RsihtkABQRUruf9z63kmaXqcRFDHFhM4WNpN2JalYw6LZv/lhAL6I391KldNZs1MwJScJG9zBdx1x/E6r2hilCE0s3+BFvO4s3OPPusaWKGfLxfqeleK64dBPRbyknaxyS9oYZNQf+Rgi6Kc9KF4XCQPIef/mFjLMHZl0epEMgS4wS6oxJtOsM2X2FPvcdzTvKEBLyH8qqsl4UZu/V6dKm8Md9/rbwwnm2YCKPtqQ8obNndLlrgrgqCCNQ0eS6MBmINliaCs992CbMkFMEdLsgjDsK/4/VR0ouvKmxYaUmy7KcSwfw9hhac5O7xFtbQI8v9rXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAKGyq/M80ralhUsLW/h7VXP7Q9lSibDhtSE48daW7g=;
 b=BZro501F60OkRN8nhQid4d3SdEFtRURbzzm+E3NRWd7tGt/EvKu+Q2GkGKXeGR0f4XSPlRaJyHleuiKu4ELiu9b/AbAdivmO/Rx0n4AHhxdgK9hqsIKTDXEhrtPHSukjcQXzwM/KA6NhrDbPLYfDO25ctee5Y/AASRestWFmRmQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 15:44:29 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 15:44:29 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu : Fix asic reset regression issue introduce by
 3f61aa92b88c
Date: Tue,  9 Mar 2021 10:44:14 -0500
Message-Id: <20210309154414.25450-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 15:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d081c898-549f-4c14-1a18-08d8e312397e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659E2239E54D9A676A0B344F4929@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEpm+WOxybVVoxxBIlXYApM7zB3Ri+tzcrRgKR8GpDUcszOFZ8iLIHgNFxIvq0LomCSAxkBTuOP8P2Vu+7j5+oF0AidQftM4I8jyGh8PmHS3AMYMdgpsTfr7Ka8QVT6+u6MkfO4UuAg8HIMG+3b0d/38qqywl2tlWoQ8Wp0S/m80EuDMoNFO7H2hPepxVwAF/j7CzqC8n0KZ1vo736Pi1EGFX8AZaEzWu0aHCu2+xH/zlbiS3+/y0UjfkFCZ1yBIWCP/RMi0kp06wxmTZeYeaUEu2xzLMU2OjfIlvNm7azaKrny+DaVHV/o2HhiXfknzA4h9Z7en9UfX9Tk9VOsJwIBGb1rDL1olmQWUMLbbgmebf90jHyFyLdMFD9UNTwBEC2LZlJOX9kfvxK7d9bnOq5Bxx9ANo5JbJL3faoCVhOURgd0kOURRbIDoTmd9jyrou/lX8zdUeeedXaasn9l+tmCAhc5sHvWru+Pk9QOGOWnW72LljIZXHkyngcCRw9BCK1wkf/B5FKQb69U34HeTuPpsJRWIHSfNOjQJaLVDW75KQOiJjouBs9XxRa6Kq/vQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(83380400001)(16526019)(8936002)(7696005)(52116002)(5660300002)(6916009)(186003)(26005)(316002)(86362001)(6486002)(478600001)(2906002)(2616005)(956004)(4744005)(8676002)(6666004)(66556008)(66476007)(4326008)(66946007)(1076003)(36756003)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t6WmJzcC01xGLbg+Pcc2waQ+wTccZZT5FzTz/XcGckOrfLORv6rdUWdj2lIj?=
 =?us-ascii?Q?idVk6srX3xzYMb4/oY2Z/P4+RkUnEJ1Cgrl3IfPbO79Fi++HOuWKAgokbaq2?=
 =?us-ascii?Q?p6K0b1zVe3+ELGEltMpyinfRqxPsuHlWDC66bUGqR4kxZUXH0H3MQGrQdO8B?=
 =?us-ascii?Q?FwJ5o1d6V+uyI49ab8GbmWpUrSfDClSEtrpRSs32ZQ21nNAmAgv69AVOb/bm?=
 =?us-ascii?Q?dcDsnEJ6aAivDTzwpAlkYKIQwl+H5J5snlHBG4u0WKD+vnqJxb/ZkR/lG7uN?=
 =?us-ascii?Q?+FbeXfX7p40l/2hEguJ24lyO2bZ/O0TqLs+yFpaH9nteHqVwdjJeCAiPBTIL?=
 =?us-ascii?Q?1i/IzujiDGbhu4Ev6bZoy+pkvH9M8cDFrC/q7yG8CzQjPkW31UcLHNiH9l9y?=
 =?us-ascii?Q?sDALanokLnpAEm2bNzb9yTYGuK7g6WsrDkvMW3mk7hzPG8EnT+B8WfyPyPE6?=
 =?us-ascii?Q?jqjs4SBjkPYodVsxY61wJ1RTiVeLplTqRIow6wtNrmOXlbYDH0MXAM9oBLR1?=
 =?us-ascii?Q?JHN4A3f3l2/7pwjdz+puKoSCE0NlaGSbzywEC92Gf9JEB/4Sb3UGPC6fCsw3?=
 =?us-ascii?Q?rySP3CA3K5rwQ0sgwk2MeCqrzW5iZWZY/J5DaNDh25hbBNAmUcaHXGdBtPQ0?=
 =?us-ascii?Q?N0xc/HSUZt4eG7k1KhzL2uIl7ge/vM3Ds+VAsfB5PIhmAIGHJQPla6zUvQ4R?=
 =?us-ascii?Q?Rs6BXuvHVh2X96qStcKYjrr1+0+nI2iNti/py6IyM4Wr8SLqTtAomNZWaoEl?=
 =?us-ascii?Q?7OWJefFTLoO3mAhbsh+h1H5tFLOZocqRXGdjJIooYV8T3n8os/XMSJwAllpm?=
 =?us-ascii?Q?EURsiYjxQEHGKAtM0HOPArZ+IrydW5JwChybRoVGT5rvIVZoLeO962RowtzV?=
 =?us-ascii?Q?A2vyDa6BfGryRsN9hrQkTYRmbjM9dVBTANqAV9Ms2xRmDdxvXouaCkw4EDdi?=
 =?us-ascii?Q?Sz3NwAcaEr+YBhmGMlHs/kDR6d19thP7cYteqUyCiJxcoqSqowTmC7h/aCM7?=
 =?us-ascii?Q?UttG3i40dol5sMnLbl7ucBdoEmdd5Mff58/MN9KMbAnZ0BnG6LnEFO4S43ac?=
 =?us-ascii?Q?r1Of1sCtXbDGePkp8zR9nIYnU00YnvZWMImp44k/uNTfJbz4gIUWCf1X+B37?=
 =?us-ascii?Q?g6Kn9sUqtjvzWEdk4LrCjgUVCH9Efe0u5+fW/fhk79EzMcch84fG9nT6PcYY?=
 =?us-ascii?Q?M7ZcZgaS7fAUjXOZsONCTH7fDHlM26w6LBBXrrTllMALPjjTwEGSlWLTVY+Z?=
 =?us-ascii?Q?a/u0FfDePLKnCe01txP06Mt2Rr7sLmmGHqMpzA4nGHWosn9S7VeKyXEdFWxo?=
 =?us-ascii?Q?S8aFP1iNAOgcIiN6Jx/yg5FO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d081c898-549f-4c14-1a18-08d8e312397e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 15:44:28.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n8cQ0zhPvCqg7OoQf8M6ZZHFttMN5R8ei7g8HTTXfMwTq4DhuxRr1BvEIgkgHwN/cNpNpQ0nVFWexahiFCeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This recent change introduce SDMA interrupt info printing with irq->process function.
These functions do not require a set function to enable/disable the irq

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I595998b107f48865f47820ba2e7f758cc263dc64
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 9ab8d7db19f9..af026109421a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -570,7 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 		for (j = 0; j < AMDGPU_MAX_IRQ_SRC_ID; ++j) {
 			struct amdgpu_irq_src *src = adev->irq.client[i].sources[j];
 
-			if (!src)
+			if (!src || !src->funcs || !src->funcs->set)
 				continue;
 			for (k = 0; k < src->num_types; k++)
 				amdgpu_irq_update(adev, src, k);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
