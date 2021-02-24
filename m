Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9021C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702DB64EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702DB64EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9536EB73;
	Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5396EB65
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRY8MOJMCPxBEnlNuXtHLGe+z2J6BQPIAqYvGoPr7NnZ/+4TXh4KQ5ZUOwK22kf+kHfArFgtHToqIeDymmZn2PV4qprdFyM5QVKA3E5oKUBV8q0pjEAxZwtu+Q4ZWQ4UooSV3SrVISsJqovOZu1ZCBo8GM04GkZE3SuSH3DvnSlivjatHvWLIzb9+4fUhjPTT1SlbVPfErVK3pB8ORw0nREw/W9nRg/+DEfqCd4qyl7TLYfx4jZ4RDmiZvYgYf6+rbBVf1ocMMZXWTZ2rQXza3YxYVaDuls9wRzc7InrfsjngNoM4nr8V/jVOpAdyqmegxKoOYEXMwuETaR7xrTtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8cBARCNipn2MBYSihOaZSAD+zh6l5k/NmKPKTstAeg=;
 b=JN4edJIpD/2N+zgWUmJk7yBP5UA+O8k+YCRV62tjMAheI99wJrQ8CL7jdotY3tyjyG5H0XzMd01or/CUrn4YDKbuQvRLg3DbJ0Ukkp43Z2RUOBG+yvWEoM9LJRu4MEvM4l6gTslTUnTf/lwKufb2EI4yOETzwGtGyMaC2keg22PsXW/98g1Bq4HfMwDUdhCHewi2ZnQdDDdXVxEAHEd4Eqb8LjNLA86oUF2e/BWQwfy7kaiYBeeqcrIt+oef2T6MpCcqeKFUSqZRPevOMdI58Sj4K/Pg04TUww47MAiqxLXf25R/4TkIY36A3YGRbCn9UnIWkb3NT6ZJ69XtlI0kAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8cBARCNipn2MBYSihOaZSAD+zh6l5k/NmKPKTstAeg=;
 b=CcDqKUG4zIFStIaH9wvHppjTKShRXACMcvbjk5dYf/WO6NZPToBhWGKVnqLEeuSsRdCiwSjfoPir3eghFPdHev9+HE+2DJJRvL9rqy8SdtiNwwVtSie2/k05a4NdZc7Jzk/dW5ELxiGpAO7aKiBE05vbI5TrPcfW8dTdZ3v9HrM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 098/159] drm/amdgpu: UTLC1 RB SDMA timeout on Aldebaran
Date: Wed, 24 Feb 2021 17:17:58 -0500
Message-Id: <20210224221859.3068810-91-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f436dee-b409-4e01-3542-08d8d912655f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47989240152AE22A486F7F21F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZJ81qcDhFC/1MwucWZ4cqXH/C7A1dAAVq5xJJTI9nFtu/cOZBgvFOB9jwEL4lsZQo2FEZ4A+QarRt1efHQnX2Hi3TvbV6DGnuJXuiPVmQRrCQ80YfFtRMmj7POPcHhpBUvVFv32KN1V+4QWOoCMJMAjVQE7iN66PtRjq+hz/d7/zjM89wqO9T+H2ZvNT+0yfQ2fVwAtxgYRFDmXgYvngX9zX2mxL8R5GoVHF7quMXc+LfoqrJRWDB1aVKkMydHK0KLtiBLqC5l58K/BQqvhnq950OS51e/fpEw4qrTHcBjoJKTY2iDHnCD+HI7PdEvvCyLEBkJejNm3/dXsRjgxyZL/8TXwU/dlBpot+vAwZtbCls09H1w5ShFJPVH9CDlsgWXPY3ADqL01cxSOyFX5oZ6qseQKc4gLzxXg5mJpDg9/ThaunvrAwI+igWGJD1I/g7c/AtmZ2tEZU3GjSB5C5OQS/6aWPKB18/OnY1PoojUwVK9iAbMbGF0KPtg+ED3ZAwKptq6Mjfvff5g+uGgyvn8sB/gGTxKrmslDEP98xcOCdaV5XdEtF6JZZzihyDi4hRGRWbn2Gz+sdFbvhtyBDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dLZNPc7eLxC9jcRkPohc2NEgYUwb0XPsUDpkNGBqdioYALOXHb12HDQfpILC?=
 =?us-ascii?Q?w2D/J8TUm/i02LymOiA81LQhLzLON387Kmu5vqxcM8eFtYplzyDVoNHQQl98?=
 =?us-ascii?Q?BvV+mb3qlhUMccEt+4tIE+I68MRoMySAmgs/ilT/AgAFkBuD/c+P8kY0R1fH?=
 =?us-ascii?Q?0RvIQ6+PIdrqaZ4xJlIQ7Tkgtufos3s/EySs2i3XeJ/b+NybjWw5CymwLuGc?=
 =?us-ascii?Q?tzeIY22DRjVuoTMCBAv/cEbIEZPlPZWmT0KbN2zjwR6AGaR+iE2RRhNIDkvG?=
 =?us-ascii?Q?b5RbTgCFtWns0SmkgRlIZxvOYDfqEq88ZQv7VoDXo6u/Iu7eKgT8bHe3U+yJ?=
 =?us-ascii?Q?SlWn0nWzPzKHNVUXnPObZFg/jR/a7moZoFoQWD6+C1/inzzfY624AkH2rC6i?=
 =?us-ascii?Q?83OCrP6Y+/D5jH0SF7zt9ewIKPsxY64AuCB+4Ri0UO7oI4UB9egijiaUx6i1?=
 =?us-ascii?Q?Qzjsre3fLWvEyj9m+ePquDj7FEgt/5xRHTc7+we1HzZ6Hh/ZftR+mpKdR6CM?=
 =?us-ascii?Q?YT1k+V9oOi5HWbeOLqLRgv3pph+ngkkZ6HGY0cHI46a8NOVd6mEBujo3WE+7?=
 =?us-ascii?Q?nYBnNIyrdV8EAiHW6tNKqKIDvTncvRDitvK9gEZ5pX2uimRugZJ4WkVDbA3q?=
 =?us-ascii?Q?15ufEQlLhOdeIUEYFKgVPtl/OaFpuY8cZdXxXZ4phQB4w8sMUqia9Lu6ZP3t?=
 =?us-ascii?Q?+ae/rNuXBlK3FoatLdd4+YV5nGFErpzddLBaTpWm8hvx4BtZK5iKVO1CrYHt?=
 =?us-ascii?Q?kKsqwd1u4TWCgAdwWy5HZ//SLEAyOhKLo4bHgEMq5TB/fVqyZbsjAybdx1F4?=
 =?us-ascii?Q?AzbCsTF3Pk7VAoOtuyRb0GUB/mv3wnu5d8jZYi/MPxQmlDwJ4HbCuctyWu2i?=
 =?us-ascii?Q?nVq9eclUCPjt8cxntx0SpyBggntgpgf3ebE91VA6Ks8LbgecIQWE4T0DBMFu?=
 =?us-ascii?Q?guneJI+w3WZvRQHg+FargUkqNu35QJM6KC+2R3QtLDlnJpoLysAAhsUHngX9?=
 =?us-ascii?Q?LZb2CIMOfcVZQ0L+1HkOcG2sQsrZq6q5QBkEu0bIDrX9gzyL6SCm6oWqx9JK?=
 =?us-ascii?Q?kPq8HvC9NbkRwiXeylAyZJT7XUuxJ0cBt6yvjxPzpDpXxTOujWsRpNn4yJZ3?=
 =?us-ascii?Q?DiqCJKNA/ZQmX++Nqd/ncQxliPPlXwjTLfPO0HsdX0sf8xSnwL4eXTlt2coW?=
 =?us-ascii?Q?+IW2p1CQ4O05YySOcgiqPMQcaPbD7WZyaYY66AC9YeetIfBjd76KXAAoHp1Y?=
 =?us-ascii?Q?9RPRhFrnSyY0uyNk9pmEIfdcphjVIKRvJj7vPPaIktOXKil8gojNau8gGx01?=
 =?us-ascii?Q?a2Jg4GXNi5573kBNwsBk9ET6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f436dee-b409-4e01-3542-08d8d912655f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:30.9169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMnEsUYp0lpZpaOrrfHeoACORJZXxTWGFPDbgWlpdKaNZzNOMJXZJba1WaQsdAwgOyPHaseVkOiU7jrSXqaDpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

[Why]
This causes infinite retries on the UTCL1 RB, preventing
higher priority RB such as paging RB.

[How]
Set to one the SDMAx_UTLC1_TIMEOUT registers for all SDMAs.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b2146b4a7682..8e3bcdfe191c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -264,14 +264,19 @@ static const struct soc15_reg_golden golden_settings_sdma_arct[] =
 static const struct soc15_reg_golden golden_settings_sdma_aldebaran[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA2_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
+	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
