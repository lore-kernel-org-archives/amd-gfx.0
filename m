Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD4AEE2093
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DBF10E19E;
	Fri,  6 Feb 2026 11:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tEWw8Tpq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C9010E189
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTlwi3JaFBTDKTBPZaVhg7UhtnjgFQF1IJ6tmuoDzThj/RelZR0QyHQyBc5ZCHK9VPeZEyasSYO4qz/vvFjFTRP67LoS66WfJBCwKpt4Sx4c4NPn0hgqbliIsu/tAtvgC9FJAlKfe+7QLCOvnGigtq5SnrwOoCNsrb+FMdcc7wZ6pK1xMgRoJIhbBu4YGpqlq0UQA1aCWcd21T2u/8zjPXbMj1vhEl+zkGaCeQ7f7GaWOzS7cbXXJU8ka5fHZaLXFyYXppz+VZHKk6o8aKmvNdCcugGDV4NfnF2YOK1Htn4IXnDJoFjaxHZkQp/fyyjM5vnBUPH+vyfweXAXLMWoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNlvO+w7sJmVOZWTqxCx+lx3aRAICk4O2YtdE8CQkjc=;
 b=vxl//sDUzWIF/2Zsx4k7ClOZqFFEwBxVi1W4vFhHJs2DNkQ9i9dK9ijcVvwLwHC/24PM4ZIfsF2ntSpOML3C63QtTaJQdIsqVO9C6KQgki9BRAcg0GoOhkzDZ9oU4LGtS9Mm3GGinN7jEvBTk/KcomYwqnOzG2aj6js+7uGBCB+p7Q5rVjTRuxlNgCrjiw5nbQjim7LaSmeFr+OTu0/jmUJeQEYgTZSNuvuY+gRmvVNMectAjiTfQf4VsmBOtn90odkD2W+Aq4Qgnysk8KXEFYEO3v3l59odnbFLT19Twdj1PufDMy6+S4oFzvMbt+GdDlNzN8CearKo0c62P6OS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNlvO+w7sJmVOZWTqxCx+lx3aRAICk4O2YtdE8CQkjc=;
 b=tEWw8TpqLg8DiShXKmAz9IdpX8zUZEy8r2choBD5YtyK2j1WKixDCYRlIQpsZe7HwKDVQipOP5TbS2lwO1jmidGt5yN3UDTCplFlKXtVl5t6MD4e1KFW06tLBQyllxwxmyDE57+eKICibLPWvxhkJ36a0j7qv8IGdSt9V0zY5H0=
Received: from MN2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:d4::17)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 11:25:15 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::c2) by MN2PR04CA0004.outlook.office365.com
 (2603:10b6:208:d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 11:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:14 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:12 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v3 05/11] drm/amdgpu: Fix set_default_dpm_tables
Date: Fri, 6 Feb 2026 11:24:43 +0000
Message-ID: <20260206112449.45381-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dbe80e-8490-4527-6ff6-08de65726603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rjohBV4cEroYorj6ulbTuB15SB8meiOKMgKJpFn0TLC3HLnc826oEym7iV4q?=
 =?us-ascii?Q?bsInEiSwsurbKCDbAi8F3Hd7XGQs3MOtYu0sLMAOol5peO8OuzRRuLHocBiW?=
 =?us-ascii?Q?yqlFMpfdupNArmU6l8ROhKUu3r5cp8BuELND883elky10x8Gq0iTCygqoOuJ?=
 =?us-ascii?Q?oyzlqvl83V4gZetLixVt96hGjkJ0LsgT0l2+oxEbVUBH+tUhC6Pr6TH00dVg?=
 =?us-ascii?Q?i/M9NFnNFUggue71ff0FvT0GdZaeHzr5GrWYNSx1Nf0GjwIGPtrdnH1eFhKf?=
 =?us-ascii?Q?Wx0C8aHdX3qffn8l92U/EsWMQIFINXI/oEpj3puP+mrNxPawFrgfIbJxW3f8?=
 =?us-ascii?Q?9OiTK5zq/XEdNhlFPyNieH7HFqp7iytY86Ujq8JPjsELBv1V1fd6fbEjTNE8?=
 =?us-ascii?Q?nyZ+mpH4hpXwdh/kYuFK7UblgPzXHUM5dp0xhM4+AMioTgNtw3gqJQw8P/O9?=
 =?us-ascii?Q?RrVn/zDb2Ka+uUySQIdLDHD0jwJDHnoIvW6+R5hh/oKh8Aq7WPckuq283ssh?=
 =?us-ascii?Q?h38z7OyFadIMvkJd9qrjMbTo/tQFHY/LBI/3iM0pibd2xm1STTPjuqLguhcH?=
 =?us-ascii?Q?YMQlMPDrHdZPFuueWK+LrM2hce8Y48XBfBnbAf4Xfzsg9USbRJ7RQB4FRydR?=
 =?us-ascii?Q?sGQ8G9YJduplnFNnBtL1+K6HnwglSwZiVnfPZ/Ucc/Ms0u0DQ57xmq0hausx?=
 =?us-ascii?Q?ocI+LcpVx+9K/SwNfuZALQmO9G/6KkmBt0U/S/m+AvwCdY+FNMIy5l9JN+aw?=
 =?us-ascii?Q?qPuIgA2mHyhIHkMopk29B0LYn98VR2c/SNpSX5VHjEMMOwAyc2st5IgR6Uyl?=
 =?us-ascii?Q?+xoNWXlR8WAxJP3LdTgLIUYOecXBNYfWEm6Ef/qjYbwGV6cElrCVfv8JLs3z?=
 =?us-ascii?Q?p/Yq4Tt4Ub9ycQewdlNRADMET/fZNOlww6WhhwykeTDE0lUOnZgdfPuzTtmJ?=
 =?us-ascii?Q?x3wuf3XPb3i05wDCAEPVBcUtQHtg22cuuAIkt0tZtVZxSNRQ86jLqtnuJ+pW?=
 =?us-ascii?Q?D2QXptCJXj2n9F0IRaDA+iADSBWcbWZfWlWW1fxCt4BMHW22rMhEOJRs+rlo?=
 =?us-ascii?Q?3AWNbE1FMCyRiggKAND9BkU6f6H6rpYv7UpvCYxi85xTGWodGMTYOBPl04TA?=
 =?us-ascii?Q?9SG2AiYtJqWHeZk50QsdzkLymocj1zNTNkkfRTF11eDPi7F8e26y3PWGG12l?=
 =?us-ascii?Q?NW8hxHj9E6D7sbIVcuzy+V9gBxIPVlRgDgUtDGFt8ilPMXp3YlpAo63W4Ba1?=
 =?us-ascii?Q?+Q8IE2Q/Sxt3mea7yJpIVc9ssy+CJZATQIAy+7ib4gG2zPHEJBnMGIO2mav4?=
 =?us-ascii?Q?ux20vfpoWbyo7raYAqm/m/j9dryOpsOZ/lHWnRpGhZoDF+ht4ZBrIJe0eRCe?=
 =?us-ascii?Q?sCi6LA2PCeJ2dcXK50nY0NUotI4lV0FaOBcoHBNrt04CNG1Bz8cVALOqpyYo?=
 =?us-ascii?Q?Pai79JJ4pr7Ql6ioLH0q2XT3o4XwfBRe7lA3hlpS05ML0u+26TPEfUkJyi9S?=
 =?us-ascii?Q?kooXKb/SMr761NLud25/axWDRtnbr+rZaQ1adKHfeHXjL+npU3PPq3s4SUvC?=
 =?us-ascii?Q?4Lx/n91l0BRjlOmVhCpBWllpgNDOfgWHOw1TJL0wuVtbV84Z8BN7cwlDzwh8?=
 =?us-ascii?Q?Ox0Si/0scTGT4dcacfZNLXaRM15zoFBjXWW8KJLCwavMwjDgXP0qMbPkB2ms?=
 =?us-ascii?Q?Uu2nvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4yBVgup4/44vDUtAarSu/7Zbkz8HeOXV76VcawYSjzE1RgduuY70iGpgi/dr544Z7WVijH8Pc2rnz9Fp4/NWNM/GalC3moKILZ1NoueiRCHLdNsAgz/AcH5PgUvjL+wj0/8yqsxLwT/oIiwh1xokYNQlzdRG7ZePJjYM+ZBVgN3J9Y5jrcTQPCpP+bJQZq4ebVZp08wKveCNXXWWnnjRT/SvueHJnyvGNv5vCOOriOkMzFUBadLlk5PxZegYF6QUi75ZHEqnMANoJaSz9jTNYxYeKoJozJpoIXO3ME3ZZin94gq713D5/y7y4LHGKnEE/PXb8LJO4SctxIi5voV+/ldvgonNzGoH2fLOz2h435J+TkxsASLmEt6xCpjFAbfMpNDi8NFE9T7HM2BOyeBAvNO0xFECwDoWDu/eXu6IbjbzR21pyibhWS0x5PV1qmTU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:14.4989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dbe80e-8490-4527-6ff6-08de65726603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use smu_v15_0_0_update_table instead of common api

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 22d0a543a0e6..57cfb4af2e5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1794,7 +1794,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

