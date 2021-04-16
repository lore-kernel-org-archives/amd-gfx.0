Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC7C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC936137D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC936137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59ACF6E0C2;
	Fri, 16 Apr 2021 22:31:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AC16E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 22:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8MqoAxeM8k2LJXnEbxV26s9wP4/KZW4v6CR3oyDm2CfpT10BdS9nVkVm7tBE5/dc8K0ePxCIu0Enai99zh70yE0lIDWig5NWsFJ3MdjRmbZw0QslZp2CH6hOZrJpNl2ps8wYkRABvf6jXgqb6OmXFPN1lvQWezMIJ3RniU5iEfByaHMqAS+HXyHiEzPqDWoRMQ9iUcXIYgfvMQ6d59kzWMP6ftcsNDWK5HkhypEKcAqraYYyBQrdiG9gpUnEmjSbR4y7Z+Yk5YIG+zoykh6HZ/FnaI3ZaKG0o4AkB7COoXkdXADgMIwy4+xDXPoxQMAubL2TLYAZBzO0xvNDUCa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv6SMfbiXrpQUIlSGLOto+fmq+8e3Nc6KLqnLyXBYFk=;
 b=Pl9gnn/4M21pkiNhNMh3wF0m1iw9fWPTvs2hJXgyfSI7hx4LULQ4364GHW5pKnWjPaC5XNxx29G7YA/UMbgCK9s2E6fUerSxMarZXef9Zf3cC/neCQWaER6PWQHhFl2q6b/Cir0F8iJ23i43tetmP4V8GHOyB69SjkKgpWlunGR3Fg//Ep4xnIEUBD8dp8E1mCL0VZh/QpSfdyFiNWAefauNDH04rTGz8LStcIZnbcihC1R1tIXRyN7AU8ysDpfU6BpbBBXsYe9PNeOo1X2a5MQ3JHwIuC8z22vTSz0Ra5AKHipHkG5WpXacfqrLU7SPPteEPlsdIEXcXHL/6ubCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv6SMfbiXrpQUIlSGLOto+fmq+8e3Nc6KLqnLyXBYFk=;
 b=IUxegwxClxW3cRhm3PUzPYikLSzbeLzGIASRHIxPg7KuOt/HwFH7C9AMs2ybE7MD8JgXcMLUuSK57F98Hv+yAu6O0hw+b2I92VHx1ndWHlGKKSUUiS5SNLZlqWqd+m2FLG6aoYgxDOOyhB1qVjGLaOPOhxL9lWqOju/mn6yA2e4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 22:31:04 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 22:31:04 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and
 SIENNA_CICHLID
Date: Fri, 16 Apr 2021 18:29:55 -0400
Message-Id: <20210416222956.4580-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416222956.4580-1-darren.powell@amd.com>
References: <20210416222956.4580-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Fri, 16 Apr 2021 22:31:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60ce5c0d-db56-4786-9f88-08d901275240
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB345220F319AE036EBC2B2C7DF04C9@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j6PQXz77doH60rrzGYACfGF41GIUU3pTXwQmDQYih24NIo6rxhjRFfrbPLlWtdF8H7H1lZ8QdHJqcegnbD6N9c/ROZ2y/dyhNq0ZkWHLt5CM+/ywB/lvLREtSbPSTwGwet1Oe9641wHFh9xE5U2PYmCZSf6stRjz37cAsLQ79IV8bubC+T1A2BjG3oswFLtCjlcjCp2jU+l9p3i249ARKkMlV3frnRJ5DQdlWLcDHyODFae8tL2iAkEGMVguM0Mo8HyYFXW+OPFoWp5nL3cbQagdheesFD7wdt07YhOjRJAgmCHeKslP+BbHHRzFKM81gYirNGAR48VQfcWZseJGTNdccMoxxpxZp4derKHmTmCki2+hBoxk7tghuDu1m34LvtG6jzBWekM7cH8AW/SYXvAIY8YypIe0Fn93IQ2OLTryX0GyzPRvZxh5E5XTxrgEfCYqvDqGpdxjYLHhrO9Zf/Ktpzsv61uwCxr2ou9iNl3cNKQzOlDSENOtVzLG01S3/yx0cgtWNHXs1vtpczjrDcNupEd1RmNafjzPgzn3wjNIt36KbRKaltYn/RFdRbEWJVQ2H9QBKFzhkB8n3DoHprqxBejV7RSaKrgUMj7zEdHBu3YMKkp7h99SiuqkDK45KbQ30Ul8AbsKsNTr2NKjrO9d8xaCV6LoumLld8O96Baks4D2tCACRvGxdL/XUDm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(6916009)(69590400012)(186003)(86362001)(6506007)(6486002)(6512007)(36756003)(8936002)(52116002)(8676002)(478600001)(66476007)(83380400001)(2616005)(4326008)(44832011)(956004)(6666004)(1076003)(5660300002)(66946007)(38350700002)(316002)(2906002)(16526019)(66556008)(38100700002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JyG+LKzKWVO1zF1zswnF8l8E6NUZW2i+TIizFfHs5RTXpulSpK1v9xvU9nKG?=
 =?us-ascii?Q?dlom/x4dckHW9ANKoOtXK1ocn6e16W18GmCZa5tRYIz7FXQFXkJ8ZJ1vKH5Q?=
 =?us-ascii?Q?7DGqFauImBZs6jX5AsfA/BcnZeU2IcTHdHsnemOyeHrd2Cm/23ySAc8/Z6HB?=
 =?us-ascii?Q?J2xOMP4g0Zj28rVTPe53R1A3x+fI32vR0pqRglu2ng9VeqSD4lbhWOxe32I6?=
 =?us-ascii?Q?aH5FP/hu75sVXDWiPtqHRBd6PY79BslQlyRzseEfS9piD4ekTwashCzqE1bC?=
 =?us-ascii?Q?I7ObFiI6Hjkio/exBmfEd6CYlrxjChYTWD1Wvya2a/0CrvfKXh6ocKLJ1HLH?=
 =?us-ascii?Q?z6vIJul0ex+1lzUSXQXZeGJaBMGGXVlZtPFkBn1DLoKacuLtdD4oAvGrTaqH?=
 =?us-ascii?Q?VKLHj5fKVqIgWqnPE+x6gkct1uglneUQGx6VqG8aWbofY1Xbyk1+WU+ZGNjx?=
 =?us-ascii?Q?G/pVSXjyrc9TSJBuvkpVh2lu+PhQNX1pnIQj6PQppNqEXzrYQX3eCYD45KJR?=
 =?us-ascii?Q?pmIlB6KWpvJlei7kmKiWLJZ16eGY1qkXw4v4e0zBel8JErHnfdjytaXlosqZ?=
 =?us-ascii?Q?EMI6L1/Fnwl1xZnw3auCV9swEv0N3s1ieoqbsJokvmxKGc16g1lbDsDCZYF+?=
 =?us-ascii?Q?BNmjhKf4E2/MhookQN2z+m9VkAd9xDjLXTvZDnPJa3c8wTXeTCvx0Wr7a31Y?=
 =?us-ascii?Q?dboP2PKNm6J1NkPlfP+mbtPazUVkGMS2mIrDTkUjkHcTEIlAp0s/ZmRqTrlr?=
 =?us-ascii?Q?ZKseTFMA9gB+z+/D2I8niKES2arRDBFh597PHDqtoqRF7HGzI+AVxHXJM/D6?=
 =?us-ascii?Q?IQX8RwGTui/uWWiZqZ+5TADrVEQQKCQv1G7L2Qxpq30kGaH2cZN1K+dJYcDf?=
 =?us-ascii?Q?H0L07OjxZjMikz/+Z05EvqjEaaMQw6NOYT/OdBmkUE/Sv0Gy1PBJoDyf7GC0?=
 =?us-ascii?Q?CDmJtEX/vvEa7uy7OevPY1GFCPBbkHE2wCNqLzdN6esAzqROXGlTV3sg0Yoq?=
 =?us-ascii?Q?Y8ugwVMuyLhO3q3P3BnNSqp6bV9HjKt9a493AUbdrZuU8LO1cLDw52YRJ5fo?=
 =?us-ascii?Q?hMb6FTnOhr8xkEOmK9Uv5Gzbpd1UoKerLP1n7J175fYrlBDYAyedah1X936C?=
 =?us-ascii?Q?94Z2zmNChZpqcFXkRi8/IxK49qPRq6IBeTupNeIHzWsZq6FR2gkvIKiSsFFw?=
 =?us-ascii?Q?UggLkGNKwcpyrydD/Msr3xTFxXUmDjT+h7WEYFkmPRV9UawE2to2aKSCXb/E?=
 =?us-ascii?Q?LS7WnR3KJ6g2X4aVG5zRRvj0Ov9Q9qQg3wta8jMjD0qsaZ0Pgg+W0aTn8vfR?=
 =?us-ascii?Q?yGpONusSJQp2JVeqcNL7Gv/L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ce5c0d-db56-4786-9f88-08d901275240
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 22:31:04.6354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga8rDoe1gRt8AEAp8ICcEumCfwoHJ/TXUvB1dIEq8V+I7dOuF61Sm8eCblV3sP18AXI11jj2WTjIK+jHb8c60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Writing to dcefclk causes the gpu to become unresponsive, and requires a reboot.
Patch ignores a .force_clk_levels(SMU_DCEFCLK) call and issues an
info message.

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f827096dc849..ac13042672ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1443,7 +1443,6 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_DCEFCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
@@ -1463,6 +1462,10 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 		break;
+	case SMU_DCEFCLK:
+		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not supported!\n");
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 72d9c1be1835..d2fd44b903ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1127,7 +1127,6 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_DCEFCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
@@ -1147,6 +1146,9 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto forec_level_out;
 		break;
+	case SMU_DCEFCLK:
+		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not supported!\n");
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
