Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A8C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 16:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C1D610FB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 16:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C1D610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F186E462;
	Tue, 20 Jul 2021 16:18:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015996E461
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 16:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUzA5tH3VX0zrHxgQtAAXc6Co03tsUdyADX2FSOfS7UPBXrAD7pLxvT+2mGm0fp3ouSXp1v0MhD++mm5pXECgE+WmwIGJ17IRDKW50W9lLrIa9OUzt1NNSL0755eN6TZ/MyECaQPggu0IBV0gkQ0zpIK43TvuLeDPcWxqiRJUMO1+plkstFWGTU6t44BAf6eJ/nO4zVyqpxKiazwS4YRkt5AxrEXqMOVmDjmcgE77ze2q8GxeBWE73uAXOmwDb8vImEk9ULPC4lOWS2WZIkW9kwmRLzrrsOKCkRs0csAIhQ56lbjpX04v9vm4xtZIsYIdCbPi7FYoF1/pnKPySYawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3w3PI8qWwrq2KrOPIoKIyFWg7UbSRfVE52UTuqQu4c=;
 b=idKzObJsFIoy8SiYEYPQIe5k+mfESu4FtTHsN62jmYj8FBIWuWZC7pQJrEyBSW32kjisRzRP+dbNNeJtNuOHtJj5wnWnKF24HWp43TxiKcuceiV1VEm2u7RkZaqF/I+fejWMxOIK502c11GCEIZwgqgWrwCeCfTZTjkJpPZGUKwOoA3ky0Glvj9b8LySiIywpm2nD0oGRlnqqDquBAPQUBUlUbH7veEkWFqgCPG0CF2pftCId15gntScM7rLPhS/aC6yR/x2TOgffjn4vIIQam37DVtWCZM//TMuHgsiPXzT6j4aa4MxaLDJy4GMbbivk1Fz6oaZNOBw3U86kY/ZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3w3PI8qWwrq2KrOPIoKIyFWg7UbSRfVE52UTuqQu4c=;
 b=zG1z2A2/MKslC0viofhJ8dsIZCJuEN+cF5XEcE9mftE+Sek2CDwvNxvLRT1yQSOSSo+77YTWQI+eFN16rMZByWz9qLDOU3BeDf3D8ryEBquMdIxImcWjOknQzTJ8v3A6MAP0PTlCFQBo0qo+QeOpeMVXsa3SibYXT8NPqRaB030=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 16:18:10 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 16:18:10 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: Add information about SMU12 firmware version
Date: Tue, 20 Jul 2021 11:18:08 -0500
Message-Id: <20210720161808.18690-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720161808.18690-1-mario.limonciello@amd.com>
References: <20210720161808.18690-1-mario.limonciello@amd.com>
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.77.11) by
 SN4PR0701CA0008.namprd07.prod.outlook.com (2603:10b6:803:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 16:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8233e87-38cb-4ec6-2d1e-08d94b99f786
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44326C9272E1F50C53D1CFB5E2E29@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DgmFcVwegXD/a+PmrugGK5PGNTvZe2J0fr6bfhBDOtXTvWmF5BbAd+JJXXxrRIQax9fXhGKT/Wf9zAqw5gk4/F4ZDm8vobo1xUft+rzLeEJ3PEXhZzaThnqi6Rr6Gj2WRh5tq5l6rhYVguXFLBn9dm3OGA1YrkDuF2rbpkxVxin8PLly/dX6wy/Mvsv5KAC3yf1ufCIo95x8C+apry+YTrU2PE7z8TddXVSKoIc5ISuVsD21f6OT6+OLg+v7x1BgvlHxvWEBQAdGLR+1TNK/lYu4z0DhvTZkEBOHbdzwGCA4f8zpRvgbJWpS71RVrNYied6NBa6U+n4wL5WzIYx1LFkjr5+WUGO3hsQr8y80PAjA46VEyiuOGB7weJwrR5P7NGBE5UsIItJj3Va33ISgXPD6NeYOi9mkuKuqQAEMG9IvIMIQI7hkVWS/T0ReLR9yVbGhhT3ffb6PK6XixPBB03bFwRdpWJVOJMVukJKwCbWxS/O9EHOaUpJzBz1Zsd8bs+ArlZWYuquw88a/wKX1fDkp2TJu8lsaN4+n3zzrIaawHRO+xjACksaIEqCMkUiuDQNypc2E+BHKo73FWrH3aqhFC4O7C2SG7XT/PZtQZjptRBM3KiKPOfUcw2yRt4mXiZl+qzORotqTp0OiCZhYfF67mMbBZRcyyfc+Be0ord86H2vhGDvJg1BX8TwPAqQO++zBS4FAyKN9myJk2q5SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(186003)(38350700002)(66946007)(6486002)(1076003)(7696005)(6916009)(36756003)(316002)(4326008)(86362001)(66476007)(478600001)(38100700002)(5660300002)(44832011)(26005)(66556008)(4744005)(2906002)(8936002)(8676002)(2616005)(956004)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mb1wVChXpB32iSmm7RDak7Qg3AvaJZRI7YjMSQdUVIWvPrsGWnWBOkvzO2l?=
 =?us-ascii?Q?4K6MdMunWpqsyY8NhpKIHcJkRVAnyVznTeNUk8fdHmF/qE0fsymb4MtEsvVb?=
 =?us-ascii?Q?GqS/m1Ow9imtO2msTjwGirS05JYqfNPyNbxmcdTKMtE0QDfAVYM1x6EBmTXi?=
 =?us-ascii?Q?q7wwqqdJxPRbjf2jm416OHcgYNgKhOpLhdPHgVtLHSKFjP72zMuk6mff+xih?=
 =?us-ascii?Q?IP6Vm4ipX7coZFY1LKAmg6E+ltCcGD8IWuNNuv2LwNHFFzwGmCPT/HAsK+U6?=
 =?us-ascii?Q?rth1lmNz72sz+CQvs1ypFqKqFjMXe0/yc3pmFx4MQgVt0ACx8rY01ovr1JWh?=
 =?us-ascii?Q?GyLYQ30vRtS2jgDjQUHwLmvKkpID79RnwTVCJoQjNxF+qNOAl2W+9gIlGGmi?=
 =?us-ascii?Q?r3j1/1JK/NilChA7tYRjrVKnElJ3q1yNwKXMHsKy0nafC0oN6ERphp4WpDeI?=
 =?us-ascii?Q?cj+n+sMvGAR5fUiRSHbfOXOJUkV4CAFxPko7Jf825mjBUbAPo0ZyRtve/Aiw?=
 =?us-ascii?Q?nLMkx/AxIHNNwys8YWJc8vtsKDbT1+q0sxx7cNYcV7/YYBD9s1sS73/f+g63?=
 =?us-ascii?Q?CSQ4i9CRiC2yBOoRm75ShnO9bmsnT/QnzV2S1WSGIOGG39AQokLvR5S/0Heh?=
 =?us-ascii?Q?amB2CIhB7e0uC39t4HOauyPXl2G8xRteetVr7bjJL+oXiIRYxi/GxHTsReRf?=
 =?us-ascii?Q?psOJaArBD0jE/MvAIWC/QVivAu+Nms+IwtNsg1Qq5fOXwrYksIAxDyrxYCLQ?=
 =?us-ascii?Q?I6zOAk8Lva9LbQFcoLhFwLAaIfaZOJ7X664XW+CHeT0mq0BCXzocHAlkw2E+?=
 =?us-ascii?Q?sojylUXT4i2WrwEthTre8liHRNh8YG8qXgqVMvZMVeufjX5WWXtaR8DQ9tQ7?=
 =?us-ascii?Q?T5Ja+XGiorUwxWnKim7aQO4vhFhbAxQo5lxlU4kskVurj5Gy7+/Yhrmu0YxH?=
 =?us-ascii?Q?NebJYoIERQBBkIsWPqJBuluo369dw0fT6dSmwAPM+PJyEQLUt32cto55pQov?=
 =?us-ascii?Q?lTmOvbqySVgIocSLuFEb3XRO4iVKXv6TckGlUbjtYRiFkDzmCVI7jA7ZZa6p?=
 =?us-ascii?Q?ALZ3cn9AT9rtO6tPyy7nzqY6LrPp4cwMMKl3gmHU4DY1wwQ8IB6eOFXolI6a?=
 =?us-ascii?Q?/45WBKOiFoUydYRQZezhPZ12IRK96ZU2iJtu11lZgh44HB60PmBrPCFDFHHr?=
 =?us-ascii?Q?4oJaDD64LHz8dwxlP9rXdpneC3CHArNaB+lpiPrKAJcBE8COHT3qGYOF0UHO?=
 =?us-ascii?Q?ZR1ZdyHXShNgxF9pM+fA41Sm4cAZ7Ggi8ZLYE+rl/qEmEwjyZwN4RGajFs+I?=
 =?us-ascii?Q?Fzf3u39n99OWgCn/6ifdT4s6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8233e87-38cb-4ec6-2d1e-08d94b99f786
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 16:18:10.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7B0320E4A5BPTPKlxgFAnj3pwoVGXfq5DUJeXMEJLDnHBX2RcvW34phvPIvmtt7G+hwZhdKZ7+9TR2JoRBWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This information is useful for root causing issues with S0ix.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index d60b8c5e8715..00ebc381a605 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -88,6 +88,9 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 	if (smu->is_apu)
 		adev->pm.fw_version = smu_version;
 
+	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
+			 smu_version, smu_major, smu_minor, smu_debug);
+
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
 	 * to be backward compatible.
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
