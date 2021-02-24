Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FD0C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD35264EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD35264EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C6D6EB5A;
	Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FB96EB54
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2+QGOUxKFDSdKwm2aUTHbn8COrn+kpeMVmmZCsYrdJmfw9stMKgVUomHdmA8ILqai63U+gNt9j1bwniWhTxM3FN/4LKDwieC7Mot6Z40k8bG0S6RAvzQ32kF1O1E8ZkwWjEbmgHL7xWt8eKpCmcRnVKzhvaMMhLeFiBNDGzhTg+/qKoUyaw0+Q9yTMaVhBYE8xSC2l2aVRGeFxA0Wy5Kk6hhyt6nwtuok6lXcU3quKcfeGR2yx35PrjnrCHSZNsWcBlN2oEWKGyCXjTdK+V0uTJd1yqdm0HrXGqKeoKMOpKZ6u1baFHj1WXdp55WQ7HloNmQNIudz8pCdQZXNcf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flXwspTN64KJL1QzRMtR51HjV6ic7OTU6NLhMPj/kPc=;
 b=HBNN/QksIGtBVm7y1qnOVmCMhKxDcrSMTjAdQ536d01/XHcSjcJUZzZRdZRfVqXL4S/CB1efaEg0znsjL+z8RZODfKtYrWch5ppfonCgYJCu0i3ft7Woi7lCdxQJ2E+naprZ5FqieBOi34s0uziJ/B7ezBExNdli6v7LN7GFgjWpXt/B7QHjNsJrc+THZhDTuVm2njxdzd47FIDMRVUQH/X4PbjFseheJQjTJJYNKvGatGGNiEhwUIX5bX7YkOyZUPt/D047srhhFzQxGDs7eIaoSmQGiY5RUdod8hww7fd8ihuFu+yRscjZM54Yyfyj6Lh8HbRJRBzkMTi55U8eNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flXwspTN64KJL1QzRMtR51HjV6ic7OTU6NLhMPj/kPc=;
 b=NufwokgPV2t0F438y4EPyMFBNMIenwp/ZWl0pb3Xt5mxb4ovi3wJQ/A/7MYfyj4oKlAfOWkmVBqHlkIh1eAAbFQxhhZou+Jfuo28Di3kZYQ1ZTVMoh/x+srq7JbJJZJgye/YByfj5rVftGivsvODX57MHJQIDO+mSG9eoPmpqRU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:02 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 072/159] drm/amdgpu: init gds for aldebaran
Date: Wed, 24 Feb 2021 17:17:32 -0500
Message-Id: <20210224221859.3068810-65-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da39cdd7-80da-45d8-c054-08d8d91258c7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2497C5749E3E5D671E673FDEF79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaIk23ubT2wmz8ZLwr6G2+n7+GVGTHIRxOdbdrXFj7PL4fmmQFCiXclC8SshlxFlcIiSGp0GApmz5CKXPuhn/OVFurU9uUcwjD+r6wJD9iSefQ/trzvL0jib1r7+w3mOoUrroEtSLltoo+JaqKoq7W4+8t9nBWTYUzzXFUd9mMJUjsH0mQ5VCB9YDekzejBziUWBpQaDBbSZISgzUOAGNoHOZTyF7YA6YPBwJLmGGvtaQqOR13pm85Wj5xTIpBaR/0fq1dgZtYN6e0LyUPwjoapAMX+tO7yP6XtjZ/d+BNi3up1EJ0x/3QYp5MKEsbcevzoyM09FxaS+o+BFzgMyKo0tG7UD5t+06o7RSHQNK9QcLmk1+R5W3vccTbXhjT1XlmE58dFCyX0GZOWuUDbtFKJWxuvie+RukJCV0LLCOuTv05ua/rLHrZEC2TCuWZkjhqgOni7mLhRj7UIVG4BS1tkpAupSX8LRPG1QdjDnFPfRbKcnPzcTVo4hFtvbt71WDwV6wpGfxoA20MOXWrbyX8bCmN8mvELOeDsP/c35KSeJqsD54iXyOUr7owlbICARH12P7l/qXO+HMfM51BeqrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YhWy+R2c/zuLqOjUSL8f+Yg0YSWft4le+5C7ltiaT9ToI0KXW4lyI7YRDF38?=
 =?us-ascii?Q?yu8Okfq5IE5DEaGs+3fK6hHeruBBN1l3kFSv+6EBCinikomXmTGcdkv4AytC?=
 =?us-ascii?Q?e7Kzq9KU5ZZh/TuVyFqt74EP2vjIpyAlMmCnumabK1CtEyMWkC+sYjv5gBe4?=
 =?us-ascii?Q?SGmokwSf8wVLVyXzVXW5zTXny5Le7QepX+g64BHFqKlVGDswr4Gz1c7NaDu9?=
 =?us-ascii?Q?tUFJN6b8cc0ANhZwUNrO29wZIgWN0SGNycg2G5k/Z31IlQYJkKHyMWMdUNEz?=
 =?us-ascii?Q?ysqx6KlDKRJRf3B9+sYaLd0DW97Vcuw4/ultKwEgAuT9+7ARAUJYUPjp2Nbi?=
 =?us-ascii?Q?UZU+T1ayloKvVnNOOI2+0qvWeiu8EG5UJjaDGIC0kqd4Nr2iOJbxuQ9eY5W5?=
 =?us-ascii?Q?xFpDft5KnOAybhF+I5u5/RQTfyoRyrYsOz3hn8tbYYui1ULUur3umgfKEVRV?=
 =?us-ascii?Q?kve0D17wXrbhfi2NAcQXgAKMwPoyBF93B56X/RjwTNLi3ik97DQXKN9+d5b0?=
 =?us-ascii?Q?ThqDc0aH/TAWtQNeKWr6tdyt9boKj6Z+02iWUpF0PWbl3NHhJIEqw4HCP7sO?=
 =?us-ascii?Q?5MIpgJQpzlZfpDx/grpc/2mfSOv4OT/fnaNITJoBczHCtxyP7QqxK/Q5rx+P?=
 =?us-ascii?Q?BXqd2DLiJf14cIDclGEbZ06Ea2xcanzvSvi0z71G+m+M73cSnGBjYvH4TXPu?=
 =?us-ascii?Q?kIrhNBz2KHDXB7Nq1RpwnSrOFUTmlqpqMV0BJf5xvbj/cqlBzBx+yeGXiYh/?=
 =?us-ascii?Q?njewd77J0azNVoDubtCsSpTgB9wk5a1gwAvlyqvOCQwzdMeY929j8hgg0uZ4?=
 =?us-ascii?Q?g6u9BUlkIwdo+7LK4DdTqjIeDv/g9wmp8l/XxlVx2xn3lP4WmDcbR/+3mtXH?=
 =?us-ascii?Q?TJ9oFViLlYHPyGj+rub6c2UJgszjlpKwVX2Jx5SXclfIr3S0wtFkFh42mnSN?=
 =?us-ascii?Q?WxCnGqa6MO39233SjkHnVkH5oTL7vaip/RT0ArEeJxhkStcKmtGzkbmZEFwM?=
 =?us-ascii?Q?HnFYMOUVF495CmjtOk8ihogDeREcWLrLj29EB3q5fhdhOF3kdheFoUlKFC6o?=
 =?us-ascii?Q?DMa4iRDD6zVDrJHoGhv4NIWGz1ddg3fYCMtMw8OrEc3AIn7X5w+JNKxUH/0s?=
 =?us-ascii?Q?Tzv+VU8R8J6e/Iv9cw9mX2dkOhbUEu+OPPW1uXjOtRnpWAPbPAS+RdPC5K6Z?=
 =?us-ascii?Q?OmK6Mj+L8+jjQwqvzzRHd/+cm7AXFqLfsE9Nfg8ejV36Ak0BuaYa9MeAur3T?=
 =?us-ascii?Q?DjIDLey6/y8CGLzk+yvub/L787d4G68f2FJfJR9IzYLo7AiRf/YeWP4nVtTV?=
 =?us-ascii?Q?wnj5mp84hHSwIjY6Hk7X8TYl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da39cdd7-80da-45d8-c054-08d8d91258c7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:09.6762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya62SKa4vqFF7qVa4+qOOzbK4UOleE+8lpPKrILmRrMpMIXmhNhuqapfl0zA1POQlcJHOoFutLF+MXmvoQW0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

aldebaran removed gds internal memory for atomic usage.
it only supports gws opcode in kernel like barrier,
semaphore.etc. there won't be usage of gds in either
kernel or pm4 packet. max_wave_id should also be marked
as deprecated for aldebaran.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f8816ebd431d..91da6561cd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6974,6 +6974,12 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 		adev->gds.gds_size = 0x1000;
 		break;
+	case CHIP_ALDEBARAN:
+		/* aldebaran removed all the GDS internal memory,
+		 * only support GWS opcode in kernel, like barrier
+		 * semaphore.etc */
+		adev->gds.gds_size = 0;
+		break;
 	default:
 		adev->gds.gds_size = 0x10000;
 		break;
@@ -6996,6 +7002,10 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 		adev->gds.gds_compute_max_wave_id = 0xfff;
 		break;
+	case CHIP_ALDEBARAN:
+		/* deprecated for Aldebaran, no usage at all */
+		adev->gds.gds_compute_max_wave_id = 0;
+		break;
 	default:
 		/* this really depends on the chip */
 		adev->gds.gds_compute_max_wave_id = 0x7ff;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
