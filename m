Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CDBC5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E185F206E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sUhdv3g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E185F206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243C66E9A6;
	Wed, 25 Nov 2020 13:12:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D200D6E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 13:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnkFkhFmGmveLGjQnyr3kNOKGzgGmozvtLd20EyIFTzZN7vQ0ykCno2+2YyOgo9UPFOfmNUU8Z+As+ZaGiaw/ofRkX8CPUGnXmjbGuUV3BXaFdsp2E8UA9kLyGuMaOfAjLWvtrRLHj+3etcGDu3DPCRub1SGj289EpSOPhxGoIGBsKz0sGoPb5jjAJq0dv/fFOSqkuBxIemG0/ayuhwa4MeB6FsSsyutWGXTvvC/G+vubzn/FIIRd2s6VGDRYMAUAqwzv6sJh2CZ4TTs+BqRHxDkkORiIJPkC/8kCDRDgCGTVBtsVScnRru8pJfgfJdBrOo8t90P0rxYv3gBo++bYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaVDggBYWtkbRkr/jM/JxHkvYFbG32bcAfr0wxv01X8=;
 b=BM7wCb1ifGZZBSgwwizpq0V0+cqVy43fY08OeiCItwiBU9M437azZD/lwkPnmu0O9U9yAK66zmlA/ClGwOFX5ylDiLoXaLvb44+eGBUxq98HQEKVPkelvy7rj43174+tkflFh3Dn5jn3h6NXvBeXLdS/nav2sPFeWUj6khzKhMsQwYmmvuw43iUlggUOI3BtkUr8KJ11mM8ooeTAomvTbTaXPvoYYw8CjCaMXhtOjvfz3jN7MYLKTy09JRRycoGybQMgjEe3bSPZtKR21UbMe/OA2jPDRp8JqZwEEKRBD3soRZe4hWrpW18KgstUciOyBn7z4LQ12kFEOmASBlbvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaVDggBYWtkbRkr/jM/JxHkvYFbG32bcAfr0wxv01X8=;
 b=sUhdv3g30lof+bcyuPpP2D8iRf+kIU7HvRV5wScq+c7kqz2pokpiWTZ21taHTdQYn7ttbje2e7JIykctfOkuwXyiFrgP0Er3BFqADsIWMTSjYpwrhzfEbRoUHlHW3P8gsK/7ZQeHVJq7r8CwlXzRTssUFnlftZONwDbGdJ2PpwM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB2493.namprd12.prod.outlook.com (2603:10b6:300:ec::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 13:12:23 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3589.022; Wed, 25 Nov
 2020 13:12:23 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB
Date: Wed, 25 Nov 2020 21:12:03 +0800
Message-Id: <20201125131203.224292-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 13:12:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a13c3209-98ef-434f-0998-08d89143beff
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24937A203D1D8288D54BADFCEFFA0@MWHPR1201MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bgLAKPJetenDaqkRRDn9wSgtHPTB9x/Ek+WjuCxhXICpY/9hogVUntrhm6UttIk0+3hxuzlsRnpHIRzsUFBX4iiTTaLIGuweZI2vGyb3grLGVf0INScdZoV0SpoTK/B5DiJWyW31MSuA+Id4q4tb1pMAgmG2fqCg5tsiNGAwp6CtHulCw0aSF4Bx2QWCOioq34GTPLRjqA0+4dt/0CfXqStDutfHBe2Ro/yxsmojLpNcBktAJdw2zsymi9RN41AoowjDaEHHkri3Q/fGeIm1Po515wkQpAH8pxRd7SM33tWTzS7O1D+6vc8KGMsXKsVXTYtNhJr1xHGzS4Hm3y9sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(86362001)(66556008)(2906002)(8936002)(83380400001)(66476007)(54906003)(186003)(44832011)(6916009)(16526019)(5660300002)(8676002)(7696005)(52116002)(36756003)(1076003)(6666004)(4326008)(66946007)(316002)(6486002)(26005)(956004)(4744005)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7axLtf6V7DmfILIUXZtlBG38WIEfZo+bKjmZqyYzE0N0giOQW5UT2s6OL+QQ?=
 =?us-ascii?Q?8k0C/8Y9rY1e2VwdLOW54RjOAKxqeizoMN+Qrq5jElrIN9bB8FSu4Fe6WQzi?=
 =?us-ascii?Q?T4Uz5S4KlMY7eJVGdM6nvQTNElbHx2cjYhdttxwkDMNAwbbN/EDYmBFN1aXd?=
 =?us-ascii?Q?0w+lP1nC39dON7NeKt063xfUCqTnZD1GeqwBHqOLtovoLwTEAUsMN+pWOIB/?=
 =?us-ascii?Q?Ti0FjfPArya6PtP2pH6rsKOz9nZYj5brWfZ8SNVAJMfE0upeSi96pCCwjFWl?=
 =?us-ascii?Q?6pgMlIxDW1pxWf1cLixtYF61qrlbq6M3yKU3Q2twtaawtvJljw35tpv/AAox?=
 =?us-ascii?Q?C2OVD5NP0X9UaaL4DZPDhNpI7a9/djuIxVCItqKIsoUqIk030R3A5KHF8wdc?=
 =?us-ascii?Q?ZYthyTEIlvEVkEz7yeBZ96uM9wttRtqUyX9R+Mi6ax6MD0VzuOL3iIFv3d5x?=
 =?us-ascii?Q?lGio0Wzh84G4vjbitnrjHjXOJr8Lkh0S5FLUaXp/8uOEsl/tknq4ANcELeOC?=
 =?us-ascii?Q?oPIVbrO2mxM0ID7/mUNkeK111qjzqs2EwuJa9LjQ/0aIpfzwGtH9gfFCFcll?=
 =?us-ascii?Q?2tiF/dZW8XXixZqYJg40e6+9Q4PpqjAIuNNGjEiOUQh+4iXRpuY2rgOl5W1H?=
 =?us-ascii?Q?8WdOA3ctkmALORLpNTaKc23aQAvq2WWcC3bbtHBtpDQSgUueCCrMgU8i8dLr?=
 =?us-ascii?Q?eoaINVUNDjY2dy5fBT2316SmLxpmOvFml7mCb2vhVzDVrk/uYERLu8Ty6+t4?=
 =?us-ascii?Q?IWCSaKmyFZFLOhE4o6uZBm9UNxdQP+5RW2KrmB2YhOjo3zpARKZSb59sXrM1?=
 =?us-ascii?Q?rMmGasgfGkrVp+YKT1W+1RgKLQYE34VSnUewc3Kd1SY3oRKAlfnyec4+x8dy?=
 =?us-ascii?Q?CJj+zp18bxXRojsb922RS2qgzgJx95hNenWvL/Nqdu+yoafPgl39QqUiqKUU?=
 =?us-ascii?Q?344rHuclN9kUSAatYkrrQxt3urc0gLpVHLy2E+5aP7ORqoDu0OeTPEwPnEpK?=
 =?us-ascii?Q?9JZN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13c3209-98ef-434f-0998-08d89143beff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 13:12:23.0114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Xro5cfbpS6c41z4/RNDfUPd1tl+HN8BIgjDdFI+tqwfx27syoFADEeCvjlVvJnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2493
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

4MB reserved VRAM size which used for page tables was not enough for
some condition, increase it to 8MB to reduce page table contention.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ibbc0c14a75bd0e57d77e30b7140a144f4030114a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index fa7d181934e5..1ed130d518a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -104,7 +104,7 @@ struct amdgpu_bo_list_entry;
 #define AMDGPU_VM_FAULT_STOP_ALWAYS	2
 
 /* Reserve 4MB VRAM for page tables */
-#define AMDGPU_VM_RESERVED_VRAM		(4ULL << 20)
+#define AMDGPU_VM_RESERVED_VRAM		(8ULL << 20)
 
 /* max number of VMHUB */
 #define AMDGPU_MAX_VMHUBS			3
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
