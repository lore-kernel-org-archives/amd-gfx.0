Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F4C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BA964F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BA964F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D636EB34;
	Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F016E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO/+UlUKYYgZlBHx62OaRLjqg9VNTvNvYKH5YsJx5tyD0JbJva+i/xKqBRhWRtth/Ivm53bp+qmAhX4FW79WuF7quyx9ZgDflspr/XHzyUQKD02mv6xKE9LyDmj32T9sn6+5cg6RicGwnLkETJu0XV+ej4TWn9HxPyX8i3qEg+S9jKphCmrcMHVafgRk4za0bOluqCxVBfRcyZd5WevYiRaqFyOLpigi34hqZd3Pfl+jQAGYyMNJzuHX7aoLPyQRoB5dTxYrHzy2y5dI0zn2B63iiTl+c62a8JwUnNu9KYd4GM/iu1QW4w7TO4O5VOO8HXhngXxQssGxL6pfnIGA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7nZ1pwojyd9V0bt7nH3TyvAhRB6/0hhF45WfqYInRc=;
 b=HTg80kzJZF0ntDd16XdK/sfBTcoF3ahqsAQABXq1+UNN4AG7kQjJ/QvyWgzXS2k3HqEKt0r3VUB/EKHRLtwunvHl24mLEjCANroKpPeZvZPE+WWMcjcfwfu8AsVAqIGjsLMfXjI/b6+ikFrXCFIWA73giAOq8hT/a+QvyOq6U5p61tpCniFLhJx8g7B9ihv4iw//xb2N99Zlf3yzGhmFUN4gM7h4zr8ECSfkrHN0MBDMmMTk9woeNyj2iBsK0KznAyjJ563zAx9r0qwdGOVjrLGtcTM97aTjSLyPLz1bfuZAJZAEjXh3KUNjKownVREm/wD6X/oe3TvIQvtyDKkk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7nZ1pwojyd9V0bt7nH3TyvAhRB6/0hhF45WfqYInRc=;
 b=lnMPerVFTK6lU40Sn3/6gHw9Gxcnn1BfdaIXD7zK4HjParGvWvRM3mbeTZg7bpIDpKGe/rGY5wz1tSGq9il2jbndDlkOkxtc4+QUaz21XN9CRoDWfM61EP5H+sG4ZsjMKKgPbeH6Wg4MQSlA9tTrR/3UilpRmYPt0yG7nNL1WZQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:19:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 034/159] drm/amdgpu: bypass gc_9_x_common golden settings
Date: Wed, 24 Feb 2021 17:16:54 -0500
Message-Id: <20210224221859.3068810-27-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2b5c563-01a1-4856-f7b2-08d8d91248df
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4865C36135BF29AE87BC57C2F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCYvKv0rFGrKXfmusqGocgVNkehhQ7wQVfj8Yq7YQ+hANuj7jfLIUO2eTytLnGgV6RXeN1kjjdFn7r1yNs2ppL0KoLWKdMgtegfivw+3EHmEeyfLVzkuC2qIq+nyHyfJQaFQSw90eMBdU/eXCyMLiHw2ZDZstTh5BSr1l1CwnTgc8CK8D9jw/+rq4oWW/mOOeDFZRflyxob0Hd2KgHa7MS35Nn+Fdnv8UMT86LLIGNzjVak0jzIFMgAmkAiPV6esqd73lQSxGt0kD7tTsSlCIyy04cw3ZqKuAywDCVbsY7ti445pgSn1tuPfmGechlT6GTs0+oayX4+yOWDH6rYfHM6mYAnAi/6GVtaO16YJnyAgx89+BOmX6yqcKfgSsbv0FxRgATm2Lnwug7wql1Oizz5uXvNENueTuWLBQaWJkRRze6wRH5P30KUe78xbMkXwGvOC6jmPVZn+SwPh0RK2UXwAYOCQ/Tj9Ys/k8WtP65wleuxQWl2r9/927dDhS1BQ8Mls1L8OGFG5w9aKjeCPsoU8KcDxQVoHIg6/Qa7CN8eKQONY4FTjmAb12/JCz9X0bB/2zRuWffwDiVKF33cXmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(4744005)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lB4xCqjfJeN+K6W2c/ys5L8Zt80Z8uXucii0FK9Vw3Aop2tEVc7K0fc/5nwZ?=
 =?us-ascii?Q?jtfIH0c9VrjSY+FLDtCB1Z3aKqLoDv0PTO35EShy5XiDmfUVgEEcl94Ldvz2?=
 =?us-ascii?Q?R6/i73ie7pegGcbUAVGrBoWzZlBSnTiM0HbFSXtg7kjDqvQagpn6pbtE2xk+?=
 =?us-ascii?Q?72kFcT6mqKHydL58+35t5OuQddTh/7Hw0Nr0W9YJgA8psQfaLbG/XBN5IvQw?=
 =?us-ascii?Q?r1RXaw0CRACaqIgnfR0Qne/vgzn0mZGm16QKEqAp4cp3e3CnGHANEJpC6RLq?=
 =?us-ascii?Q?ipLDQcMDXLoUpu4QWhflDZCnubQHUd11ViCkV5vjopwbmLAuoKMY74q8Hmjb?=
 =?us-ascii?Q?7mXTGBdTZvywb6yTDXkK7wPeDWQfZN3EoqMPMnGmL9QAkOL3It5olitoH/4C?=
 =?us-ascii?Q?RHodudVQ1Jm/6+H0u+dUC/Ifw3sDxxgP9VTK2NAdcfFiftt1ggPtu8tjkYmL?=
 =?us-ascii?Q?PNiScyUAsNmVwl9AGQK1Sj1+1HYc0sMM6SSHa/PxBx1HfecV1C6F8dvx3S3K?=
 =?us-ascii?Q?MYuDsodMpzrlB5eaaMMN8rf1QvkYcyY7ybdzfPE9szYUA+NsFLiw91d1X0aR?=
 =?us-ascii?Q?RmunUWfjZ8QZ+AUv9/zzOkcmBsZMHELaZz7YLbLzO5BdrFhx8RY3kl48zMJL?=
 =?us-ascii?Q?pp56KuwwJm+rkiRKiOgYaN13+uXMkgYELZTBR+17Al19imo9AnHFl33MWz23?=
 =?us-ascii?Q?WaKPAn9NnD9PIOlJVAYK4alxDz1PIiYlYoAEJ76Lk5dGhoOFvnXxDXqLCxmY?=
 =?us-ascii?Q?Y3WAtllbfY+pmt4kQRx/gjKYgykARTQUvNE5K0rab50zzdvbEvGfJ/oCDP4A?=
 =?us-ascii?Q?Ghli1BUe9YEikpcgXWD4DBKYSXKuxyGw+PybZZio/NI3dTv0mt0bMqZeoWvx?=
 =?us-ascii?Q?0vQktWTRsK/vq+qMl0sOa4AjdpBpmH2mshY4olcX4nc8eXc4hYiFWe2x6sqN?=
 =?us-ascii?Q?DiP/brsvRSnuW2C3gWldgva/dn1kqJ3FeZEjPqdB4n0LbiDYiDdvfQT93/8s?=
 =?us-ascii?Q?BmUicW8V/QwBhs7+wLABQOPTUdXNIOOT5AluHS7vGxO3Tk5Xw9OqUAoaLc2k?=
 =?us-ascii?Q?LsvZ1zxZp3It0X07lex4IQKXinHnE6R4mCLYJEj0THexAki++CIftOHHT5BS?=
 =?us-ascii?Q?PGxc9JJTL3LodemW485zr9rXu6rHkSXS830s+4ez/vZ1KWBAVrXaoubHaLMB?=
 =?us-ascii?Q?ZCQtvcshT09gBzh8Tx6d7AzluEOi2KqjRTSoZoybyCnFJ2K+koIPIOh8pyq5?=
 =?us-ascii?Q?va4gLFmZpPrKqTd8bRfeiGl2dv/4jNtJJ5OuVoSHSHHPr5hjWdhaNy8D/g6u?=
 =?us-ascii?Q?JO+H8zkiMn/g64HLzxuGXxYs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b5c563-01a1-4856-f7b2-08d8d91248df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:43.0142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrwM9Qz/YK6gZNtXc2eniQR2gp7jvrAsJRCQeP8gbVAQFSYGvAPc8To7gGcY4nuHxKGQoq2U3w1ih9eVudufjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

ALDEBARAN doesn't need these golden settings.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3a2ac7ae908f..cadc1e383d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -987,7 +987,8 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS)
+	if ((adev->asic_type != CHIP_ARCTURUS) &&
+	    (adev->asic_type != CHIP_ALDEBARAN))
 		soc15_program_register_sequence(adev, golden_settings_gc_9_x_common,
 						(const u32)ARRAY_SIZE(golden_settings_gc_9_x_common));
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
