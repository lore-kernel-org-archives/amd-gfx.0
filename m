Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C7CC2B9F2
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FA061417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA061417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D146EC6E;
	Wed, 12 May 2021 17:31:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1AC6EC61
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF8x+5Gz/c4BduEZY/ZzBu0YRSqkFlPitEJLf+alN0crUT0dAiHYUhVGmFGUvNMKoR8TiWcz7vcrngoHeUZ+PJKQ0KiqF4VSybAZZ7/5biD4J4pE+QuLUxhHF4lWeYtVu+tl96j34kTLmjLAZVSVqpO78vJfx2UyGq1VsgCn1r2+lJGsjM4xjD5v9RjrOuUCAx8CdY+CTloaGFQmoFPKmGcZsPfJ3bdvjPOJ+MxldldPLbED13/PJ3DKs8j2e7TvELlQRMK6f817W02Zt50kr7Dp1Cixu1XPOi7pCiIgAtB5z8FA7dmVZaVfa7tBZbBfxBkZQfRKzqeWEa5FE+cMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odaDmENR/Xv6umdE0EHQ2VNrSPnU8F5cMT+gMiRTdSM=;
 b=CleJOteTBBWs9Q6MI/6YYKJBd2zzOlRJQvJXZkLpArej9GdLGJrn0njXRp/3MJjlqbz8JCkhTpsDRayptfVBjSKn/Dktssim7gEeiplA3HBJ0hLNfzRG7hpf1beSu3bf8fbaV6AfhLHY0NcLdYxJWR7Qmn3CbC0uD6WseNIiAFHORWPXnso8mrjV3UKq3zDmz4bENOX2Nm5OGt7ZvGxH2jqbf8D5XyKjXNbTD8VLgKY4UFC8mV7u7EM0Cy7hl+MwY3oKih9mD6NhfyxknBsEdYrVDjXWroEMTgZf5S4Mj6JdCCjmqYzCh6ACIvGAN+XAAIH7RRDMSru4N+QiWCZJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odaDmENR/Xv6umdE0EHQ2VNrSPnU8F5cMT+gMiRTdSM=;
 b=aCM5tBbNs0/lkPRtIEHepLpq2j0aY5kdPOsqbgktlTvS2vgNz+NJ6dm1WrElQL5ZRIwBWEUVh8rG7oD6/dwE2i4faxzvzA5TAaPTGjSZ7liwtT/P60JWkF4ZRvf/OLNBBqPu2e/Yrd3TPbqpWCrQWVJUsJ0D0Ff8oFFo5b36SLU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/49] drm/amdkfd: add kfd2kgd funcs for beige_goby kfd support
Date: Wed, 12 May 2021 13:30:24 -0400
Message-Id: <20210512173053.2347842-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac9e8f9a-1ade-4a0c-ac48-08d9156bc48d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23405A5B8DB4638118E7DEF8F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX00q8KRZZeXPUlWtyq7iO28apycsPp/ncn/Mf+x+f7c1DAQLzfzcP3CM8YDbCQje4huNL0QXRKSUxaaXzW4QZ1bivavzaCojQuygKsQLbiDAgLkA1wSSuQ/2Upuprq14bZa+OuT6F0aCJptfY1gLk7GDE8zHrRbt40oEyCjsebWleXhkj85T/p+bxUB3tvZT6hp75Oa8AJuIUKh3P8NPJopYbKq20CJIdK5DXpOrNf5pKb+GgVAn2XhUtchebEl1ecNGP1iV5v3WQ6lR9f0zEXGjdBTtxtJMEOREct8NlKyDGPbBK/6DkvNhl8CoKpLK9kz5ldeNl3XpUJt5b5DP5Ia1lqB+6aNtx786AFYOOBg9l3HfBifuQ49BhokEAQ5yXWXn8g3gCNu9JtmRDlYTeHF9CE6/0WDhb+uYx+juPqWdxCMu7uc1OpIuCFCmWCjmcZdzbnG+AyUjrb6AohGWSjfDI2lJrkEezhcOYTdrK1YhCnN0t03NYT3L7ZM8nnKcvVkPGPFan3FoRF3gwnuHIdJARg3+jiTwN0Wyd0KxLg+Wb9nDB5EyqHcgoACe2JtyPNztE6WcDJrQS5BKhza3zJUL+ukZPmIjJBHUOiz844pR+oFnWfnrIJUaft7kX1S3t75yXVGuVYddI4eoVsCYrbRtlXfDrVq83F+UNrRoFCvSv/L+fqiaofly8sIe4DH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(4744005)(956004)(6486002)(8936002)(16526019)(1076003)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?04nXnLnPdAc8uMlPjtH++VX3Vl6Bk282jCzNbYw6+GAcymrhIcyuUgCJzRFx?=
 =?us-ascii?Q?lpIbpRiF0zRaoXcgGtDAK17tSCQAz5BQgIQ2f4hlcFO8r15LjinMe7/I4aLX?=
 =?us-ascii?Q?LNyeF/sbk9ZFol8qcOpS7x8m+y7e197ZNYIdc+jU8O2cZKrireeNAB1NFxn1?=
 =?us-ascii?Q?Rt2WMc02HPvXyNCFmEU0S10urK4zP4Rd4NmvVoyLda4A833T4mC71X2zoXza?=
 =?us-ascii?Q?EHcNHecENWfAr51LKWEHcGCEYTzS+DbDGZFZ0pCNJMHSuCYvdH1tKrhkFvwD?=
 =?us-ascii?Q?rz0vZRi5Y9k2Mq13y2e4SNMsrJf00kfj5RScKMlkGucaKKkKmYDZTPHaG2t0?=
 =?us-ascii?Q?eAewKKm/fKLYpoTUbhrXraXqi8uzSSg/dmC+Oo0f3jcL+klXS+JFuJJW1o4u?=
 =?us-ascii?Q?vTw9zCJUMB9KwlAG8SGKzW128xTCSj/PA4JiUPuRSnfWhHGAFW+pU32Ge8Bw?=
 =?us-ascii?Q?tymST6vqVDhuzPjiYuXoIAnnlRQiM1gJ4c7zeATY/Cr+HVFJv1LRKw3XX6wG?=
 =?us-ascii?Q?1nvGbcynUsREaLpDOnnEeaDe33kpriOP/OsBwCyjPDuc5T9JhXARhcIEoDjU?=
 =?us-ascii?Q?/u0hqhab6qGKKwEO0SVV4ZdaRxOjD6cwfQzIm/3YEd+aqi5sE3CZH5pBrMNa?=
 =?us-ascii?Q?oQfnnQeoTso05cMrG5S3dtr1s5WO8wrrDVDvuNStjkEQSKazzcYlEDwmlb3z?=
 =?us-ascii?Q?n4x104ZCY9ULYBDVm7NZDcLYOreCFa9TzUso4azRGg3xtFJ4eFwRhCAdhTSN?=
 =?us-ascii?Q?+FmyWXi7GA82ahvnjaMsf6hB9oMnlq7ZAAm8g52LUlkjSPolGmNDxbdi9CbN?=
 =?us-ascii?Q?el/vcDc+uLlPDPNpTrsT0j/WidPA3EL7vvhBplkZeZ0zolWOkkkT4Os2vGKR?=
 =?us-ascii?Q?mLJ4AtDY6vXCNXLphkh/m8i63zfpAHkDnY3odwp+pGpNQq+GpRryV+0LDP3O?=
 =?us-ascii?Q?FBRFZfZV1pjwX9V/1fx74K031rZl9wLbfOBduY/fB/AbohGVqmZcFyC2A3As?=
 =?us-ascii?Q?BgwaePLZ4VBklEQNtUWic77DVIGHI9oPzh9W85dV0/vgxBlO8IcF7dKGwYjB?=
 =?us-ascii?Q?WH9G8X+lZnlX02UJHWPghumrEydDXBKhVNb0w9K6SDk6/HoEIQxX2y1CMGfV?=
 =?us-ascii?Q?VE24fwcWv/ZnhhD7B5b+03ARIHvKgdPhiPss6o6PW4/PuyLPlh1vcwkyePlr?=
 =?us-ascii?Q?jpz7BQdXuJAUli0RVIY/B6aw0NXiGk4llreXQra8pFKfAacxpSIg6JPWypZC?=
 =?us-ascii?Q?y9QqAn0g2IB+9Ra7FPWZWaDQ92arMuVQXsWc/NzGw5T0zn/mSJrX+gx+cD/f?=
 =?us-ascii?Q?nuuvmHguGZSshFUQVro1EZEb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9e8f9a-1ade-4a0c-ac48-08d9156bc48d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:25.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4iFwyRdg3W6XTrc2Wjvyxztk0yfhnEfloaz4KQf/0vSw/YlHRqnL2noHd6oSSnkoR7FuFYs2v0hWr4cAr3mVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add the function pointer.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 776333a10bd0..d925e5ffa41b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -82,6 +82,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
 	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
 	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
+	[CHIP_BEIGE_GOBY] = &gfx_v10_3_kfd2kgd,
 };
 
 #ifdef KFD_SUPPORT_IOMMU_V2
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
