Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C9DC3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 10:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7269710E00B;
	Wed, 24 Jul 2024 10:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+kEIgNP";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E160510E00B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 10:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql3NrmBd6Ebt/QrrjU02OKTPGoyhizWJJV0tMpDc3KwU5oyjjRw1PSU1FSCURdbKoBIhB/RQMmotQqoIk31Q6RMHfvcv0Gj8sAaGwj8uvKhuz84i3rYWTumx7XLYYx0jX1gjShgt+yIxujqCwfFR/1sYdEIPCOvUTngWXAnw4nLywVqYzlz14/zb5cyPRQLcaOD362H+A7EytgZmJ2RqOnOgTf/eiuRibvlLnc28nsMMsnGfFT50/WHwthArnZ9ox6ceg3f69MKe/US1TIc397tsc/26Nb2nYEYX/2ndugIzt1llxE/cEVTtbOlxK5Gf3nBbFevWUj+fLFwgIEc+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26mIE2BPg3EfXMUzVtb3KfnFitdVw57pYrKde7U0VLA=;
 b=O/tfURVAfvSqTpdkIfrwoz6Dd2rPW3NTqq/bye+5BhCojC97ukdF9wkJA0y+DrhwxSWYnsA/2kAMiQW1nq3cg+eDNp2fhrdUNbibWvhCbDjlgO1LtGcE2w8IzgJ6Fu3OPIm7Y7dSUaB0LzznIPd8Il0Pj2PthPnpBuCbQ8GLoofjshwBbFDviLQN3E1ykeFZSgHa3Hy3unqD2u2pELE8bVrMHsvWIOkpb0eHNLx8o8cIgFt0izgj/7kodCoT1UTCY/XQ0sh6k1gEDcgo7t8y0DMuDaF4rOniVBjQseqDaXSESFnCPn3dOCrPUtnuT/KUr31yw49EU7U3gZmKTL9pOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26mIE2BPg3EfXMUzVtb3KfnFitdVw57pYrKde7U0VLA=;
 b=1+kEIgNP262MnwrNr/CpQWk+bO6q5a5l+uzBVL6AB2Zdtws40JVUn7QtmdOMIxRU0/vdUaN08W9PLsyeK/6bR8mUioKMbH7mcgLdW3sFl208nHDmHH7JsVTvFEk3D7if23pVKSJ+y5/Nb+sh9DNZi/aW1ZBZOavqCqxYE87OUS0=
Received: from BL0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:207:3d::34)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 24 Jul
 2024 10:56:46 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::91) by BL0PR02CA0057.outlook.office365.com
 (2603:10b6:207:3d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 24 Jul 2024 10:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 10:56:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 05:56:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Ignore throttle events on SMUv13.0.6
Date: Wed, 24 Jul 2024 16:26:27 +0530
Message-ID: <20240724105627.1543568-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c95873-c7f7-4977-8cfe-08dcabcf4f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jD8YvD7fJe4ZIhXGNJuqalhzK12jvLsFHCDUmroJeevYBlKVgLgSa30s0OPe?=
 =?us-ascii?Q?K0rXjVvkcjKimo2lOoN6BDVayF7nqE70sIrcXshMpM+QNypnOirr5meKYhA+?=
 =?us-ascii?Q?Oh/de4DNO8QGafAx65jK/o6W5iiAKzeV7rSID2HSFaMgNa1JDFu3CsE4NZIX?=
 =?us-ascii?Q?ylMPHygw0rLWr0/gvXiiQkp8GkyeRBvqWVMVu17XRnmfAzIKuiyFAoWU5Pso?=
 =?us-ascii?Q?qdSn4tmioIF62XO3ULHaXj4Bg1ATjQY6KDqjFLUqrYtlmKu4Iiyc0WQ38vH4?=
 =?us-ascii?Q?zVp/HFhnBae01bAceHFpREQI+vNLRCD00HHKIA0lVOG1S1DKsxukvDX1OMfD?=
 =?us-ascii?Q?M0oNHsNo6/nbL4KUqK5k2crkS3sdQAkc/a9KxhyavOix612K6d3Bl2/gJOeF?=
 =?us-ascii?Q?obBaoKx8zuXmR0ecPL9RbFwApy3NlhQW7xkx7FXaBLlWThYd1M3Hl2LR5OON?=
 =?us-ascii?Q?PwsEdJsrWSD2hZE1NuCwvO/4hthXxoVby/j0a+XnfzYnLy7OITDp2ViTp1rH?=
 =?us-ascii?Q?Vt8AXnMtsKaAf7HGS9dt3xUNYFVwUFCCmrln+njud0vFoQVkNNFyoR8KTz4k?=
 =?us-ascii?Q?kjVCvB0y6L+tKrTQLQwjMCHcng9B/FS+X7pJ+jYB2pErbnopvzQnFyMyVp/m?=
 =?us-ascii?Q?VOkmQBH6t5LmyJRlVo/M4gytdcXSXLoNxtHUxcNbs/ujMn46Lrv672dtIzD5?=
 =?us-ascii?Q?xHdGka44duFLRV4pMPvjbGQ2pJYRJqYii/MBtHa/yHY6x3AkPEKtdY60oUY4?=
 =?us-ascii?Q?w5hH+eb0mZslLdjD6sulTZVosFEhxtcydFY5LjwTwkb3y7RMFuCzs/X0mhMG?=
 =?us-ascii?Q?1pfFSrq7aVCMDPf1o8YqlQQNqJGDvTaBZKmKpg7HEe4N7YT//0WNZmuK3uTY?=
 =?us-ascii?Q?P5LK13+oelxOoyp3IzpGNUCMELM69EX2Nx7NhYM0Lzk83FT3ZZaKjCixd2ei?=
 =?us-ascii?Q?xF0Sbd+MYyso9JatNb5AXRZqKXVIeXwpPOq6IKqgmNAbOcCAz6EC1plxR5tz?=
 =?us-ascii?Q?1OhHvzbYJnB1jxKWTcKqT5y0t+QpATKpSm44mEghW0z7L4nJDrUwCxKj6SuV?=
 =?us-ascii?Q?OI4zqbMFn5J0sqNNKV5Gkfx4fudEzaAx3bBHtNAcJC3ywuhuFgN5QLAf2tj1?=
 =?us-ascii?Q?BSNxpeqCftwoGujZ5VGTrIdmvZE0hSqkmUhIR3fMu8w2uR3hbJKrpwxzIxrB?=
 =?us-ascii?Q?Tdb0U7g3C4McDe+NaO4Q9+DXJEa0A/aTT/X785d33AnjKldIbTJF5BkLEEhj?=
 =?us-ascii?Q?zIZl+ZrGR/hxXNR3jXPtJIK9iqieFDQ9y7VI7g0Mlkx21eBxaR+YAnlb525t?=
 =?us-ascii?Q?Y1+8jfLM29oO7UaCd45hl7WRkN9sBzBf7x7ZQOok3tF5u6e22oWUu7AQg7gu?=
 =?us-ascii?Q?mS6vwdpL0NH0gybn48INLJrL5beOl+yFrA3+LRmtwVCKGE2LgKeQdEeNAbpf?=
 =?us-ascii?Q?lSdpCVvHXxP4ubuJj6RPYDTxFuNTCRbo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 10:56:45.4879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c95873-c7f7-4977-8cfe-08dcabcf4f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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

Spurious events are seen, temporarily ignore the events altogether.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1d76916ed056..b2059663883a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1739,6 +1739,8 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 			 */
 			switch (ctxid) {
 			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
+				/* Ignore throttle events temporarily as some are spurious.*/
+				return 0;
 				/*
 				 * Increment the throttle interrupt counter
 				 */
-- 
2.25.1

