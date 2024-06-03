Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77748C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045AB10E0B9;
	Mon,  3 Jun 2024 08:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XJ7orZRc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7228D10E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1IENpILPGYrkMou5Mbpz1FqKhlD3qhe6hTdfui1dzW70kjEgpJdLNPxbEqk7rdbWIRuHj2FcWUvmVDWJhoWtRSokeNREcXFmf+tNDW/WXoDyXnjVyOCnLmoQU2n2CNvU9Uob/jzkjY3CkqwJv/MkEWE6X/E731fvKWJlTozHhniUOkf2xqKinYUscwS7p3UXi40PfwL5wZE0fmVWZrn7TfDi+1RXifvNkJtcqvc+zWMgHEu3BR5NnxE/yLXp4KPXQ7FnLsdIVfqUceLxrThG2SMn2/qM63x0xA+W2pZazaPIpE0o4wXHm2Du/pOm3S6uJDM4DoLRsd3/i/P6CuxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSPFqez91u5A5IeXndJ21krk8kjrMfV0a495eQdkCk8=;
 b=a/QYyMvjhdPPQ6yrvQBE1sC1Zvgip+dSwOCoigJ3TYHAHKQ21gQKZVxw4/IT4WOz+8vSn6giHGtcUx0LTZ4wVWNThR7P/bW+87EIrIgLsoenVbdvPcSw9QfLQQOMZMkZVYv9u6mZ5fN0CS4rtILUqPnnjjMcQaLod/GGgkeLWtxglACcWTWJmpWU8Xs/kih9Zr8yXN64PkoFpiRMyqRcafjeObbH77CtYf+oG0ZQ3X3RBsVh2hwihMUV8MAukLBKoBeQ6RalxgGQFppMrapHvxoypJjYo0JwrT8+w4NC8qYkWC8xk6Qvlaz/MAoTvmmt46En+6CEnsjSP9aPei7nLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSPFqez91u5A5IeXndJ21krk8kjrMfV0a495eQdkCk8=;
 b=XJ7orZRcLE1ageM5OZoRVr0zaMU/c2XuHSBf8yEjiUFg+aJdyVoXrZzYYXRZGu/Df9pPPtCus1bpAwaTbRqL0bvcCspCOVazSw27Igjs7qgRwLRqs06rwlUO9p5m6s8kzLVWaW7/kdbtK+NHJelieKRF3RBe73my6wDjb+XSFHM=
Received: from PH3PEPF000040A2.namprd05.prod.outlook.com (2603:10b6:518:1::56)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 3 Jun
 2024 08:47:45 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH3PEPF000040A2.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 08:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:47:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:47:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:47:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:47:36 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_levels
 and navi10_print_clk_levels
Date: Mon, 3 Jun 2024 16:47:30 +0800
Message-ID: <20240603084730.2569970-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f13ff6-0cee-47e5-3fac-08dc83a9d652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AkRJEIQPhWgVtpKsoJPQHYX7OhVIviN2W0EFt1Y4fARKZouUME8KEAxDeYVF?=
 =?us-ascii?Q?m8E5ppBlOzDJGRnRavNSBr6igJXq9ONe/UltVClgRsQuJD6ouJn9Pe7DSiOJ?=
 =?us-ascii?Q?vGDxizCrQEY11jA+LQpqSbdLXXA6pcAsMRlFm706bcCenK7iZJFTzFlkdAJJ?=
 =?us-ascii?Q?Q8YMRubFPZWTgRQM02nXvZCVYxXht25Z5cNM8VXieyMljLcVpZgndVIdF3oS?=
 =?us-ascii?Q?s80dmqaZ9Lz97dQ1OdZNQqDrgsbokwebvC8b713XCXKXHUE/LHt7ZWYaK0x1?=
 =?us-ascii?Q?v/clHBkAuwHzNc90vRidJU/9u1QJe+orghTCADSTJ75xH23xyXbwgtgR9o1u?=
 =?us-ascii?Q?+oGWZaeyTyeYmDwFw/lVzqOMRIlvuBizVpoewE9oYO1X/47TX/gRmSevmPrv?=
 =?us-ascii?Q?bq8PKsNgnhYPcAXXM2BSzee+WYmntxaHaNqcm5F3qTtMy5Kc2rLlZk3Nsf67?=
 =?us-ascii?Q?7qQoDemk2/c1sghhuedPik4Fhv+/dRUqcjWfmjyF0V6IlY3yWov+gqjotL8N?=
 =?us-ascii?Q?g/Y1O/Dlfb7rNlERN5ag/ZX2dRoa6lay8I2sTi17SNDJesRg1tbZns95x57n?=
 =?us-ascii?Q?p2s8aTNyDvvwY0nFV4AfKOmpZ9/4h7QrsxoRqxrGkk5hHXUD6Pt2TnTkN+l9?=
 =?us-ascii?Q?Hk/2vMlCHr/NPi5ZPJpdCI2vOy0KtsHNA4RHwZWQDEksYZwxi2YS58HbrQZO?=
 =?us-ascii?Q?wSuxe14BxpRx6TrsKj8sSrs7jG2I9aEEfB8BC6gNQ52sEgIdyiOpzUPJoZt0?=
 =?us-ascii?Q?0GuOOeKL/BpLObw+FiSzbWB+d7SWGbc1+u6HKdPu+6iys4S0UWLR1vEgnSjP?=
 =?us-ascii?Q?Vgf/GIFBP7OYUUlqVl7ZdynKH4X9DQA8+DnPT6xiHN+VLFgeboyHcXzMQQO8?=
 =?us-ascii?Q?ef/KLMKdnVnsgFkdhHB0CIAoraRoOA7jQ+shqZEkN7KtIEd2e1Az8PJ1nXl7?=
 =?us-ascii?Q?6pDI3+y1POyZrjMAf8tgTVTxPf+dWuYKnd/xIPW08C1OEK52JMfYw68oyxeT?=
 =?us-ascii?Q?At7YySjXxFwSLgpcfDufT69CKU0XeLdqsQscZJSXHOVuwYtToW5kfpPg/cut?=
 =?us-ascii?Q?gjnOeDcq8sU+ZRY6BuUx8Q03XAFJ5KcSQsdFfSKW4xSkaiYzPpi3O9JivCjm?=
 =?us-ascii?Q?kzFESHyx/MkR76jppp0EblFcjdmqb7yxAmmgqw6+cwmUCO9ivS/B+EX8/7pC?=
 =?us-ascii?Q?jPVbiC6+PwOD6Q3H8OlgRAvSTKNaFrlsbvQWbIbzXtN29LggBnU7iFlXb74j?=
 =?us-ascii?Q?G4OSuYB2sY1B1gfJdT2LHZZ9eXsEMpg02R9QJqUdIjG26PziiD2pKgfDqI47?=
 =?us-ascii?Q?n1oEI5+c0hKeAD1qu0efouLhOL5SFDKO38km5b9y86mi0P4GJzp5kwcAudvh?=
 =?us-ascii?Q?1lgbl4F1csPqfytheDCYrJptlfE+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:47:44.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f13ff6-0cee-47e5-3fac-08dc83a9d652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
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

Since the range of the varibable i is 0 - 3.
So execution cannot reach this statement: default.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cf556f1b5ed1..076620fa3ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1389,8 +1389,6 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 			case 2:
 				curve_settings = &od_table->GfxclkFreq3;
 				break;
-			default:
-				break;
 			}
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMHz %umV\n",
 						  i, curve_settings[0],
@@ -1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			case 2:
 				curve_settings = &od_table->GfxclkFreq3;
 				break;
-			default:
-				break;
 			}
 			size += sysfs_emit_at(buf, size, "%d: %uMHz %umV\n",
 					      i, curve_settings[0],
-- 
2.25.1

