Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B101D13588
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 06:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA7310E34A;
	Mon, 28 Oct 2024 06:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6XA/LSN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920EE10E34A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 06:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXzQ5tf6G4sdKCIEU0xKXjeX7COrC7BCvuA8XT/SAVHTBuJIIhLfNmN7jfKclY4qHCkQ7J5CrvXwN+s0lHPPcZ/si7iW3cjBXaPlW3NzjwGRqk3M9AHgg1h/Y4sPbsydVPXCtkEXYsA9w9K8qI4B+ZGuooJJ+NsH9f7Cxr2hp8LCKDL6YO/L4ktcQ9RLHdK8SDP0Vze6WLUF2KHjkQLUeDtb5GGi3Pu6CdaYAHKWKq2kzeGKgXszlyRXVJQSyuMLkfc9Xbg80W0A3BUbhoBMEfG3xxpDsxN8p93XIeb8CeaSpXHoxdem4/kuDfvQYoXGXa0PsrnCYKfLtAq4ormJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF3Nc/I5XB0cwrqjQaw1yzGZlTwjakk2BsntFZyCkYQ=;
 b=RW55CxK3B9pBQX43cFvezpoIJBlWpfj/AyVVAfsTQ+Z7VSpbfgzbWcL4X2vY9M6z7c0jAy7qod7TGnOnpy3hMxA/wKdM859TU3+KNyir5dcVszS5SPkwpzXRnPVWHDishb7DmM1epMwh25s3JWQzH7/mRzXwK3cM8ooewEqaSzWzNE2NnfQSR5PVmxEc2lQCHvqWgZE0iXOZU1H+SHZ3MLFTMYRXQSSIF/AKVHYMtSlXRnHQlf+DMp8o9QOShfyw838UHcd8bkcokZGaeJWDLKCiYVJS2+3fEP87ahZRpt8Nl+4MD3SFKCjyDZr4mE99kvMn79fLLPVlRgQOiGLu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF3Nc/I5XB0cwrqjQaw1yzGZlTwjakk2BsntFZyCkYQ=;
 b=b6XA/LSNHXBJaovumHZH/etWVuH+UY7Yfrf6yYZzjof605CTQguilcs4/rewPMof23OmXsNQ9m8ksHGJTKrqzv8wXDtfntlKVO9J3tBYJv/SnjjRBwZ0Wxae5UuiC7DpYwk83WQHJgdPOa0zr00qpHhUUWEIZyt4A8y4IOU7dx0=
Received: from MN2PR12CA0031.namprd12.prod.outlook.com (2603:10b6:208:a8::44)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 06:37:15 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::2f) by MN2PR12CA0031.outlook.office365.com
 (2603:10b6:208:a8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 06:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 06:37:14 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 01:37:12 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, <li.ma@amd.com>, "Tim
 Huang" <tim.huang@amd.com>
Subject: [PATCH] drm/amd/pm: print pp_dpm_mclk in ascending order on SMU
 v14.0.0
Date: Mon, 28 Oct 2024 14:36:27 +0800
Message-ID: <20241028063627.2809942-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 580a2f29-dba0-44fd-cce0-08dcf71af5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AST1MzqRXKqgOOrNJYbYKTsHPe1Tn84SKscay9c4U0UMSS6eDQtYUWaxMAJ0?=
 =?us-ascii?Q?5szr1By/dcTr9OWqtkyrYop2kOna72dmap3mM6ZKpxL5TFFrVQJZVCfEa8yB?=
 =?us-ascii?Q?tIFzFkJxqxTAbDsW7Re1/tGv2b9bZMZbsQwGo3cNQgUOKMpTms3DtJYFuwNf?=
 =?us-ascii?Q?+08fn01aAA4Y1KjjR/8ZUBkNTGxz7wlGeL9gKU9FliFQeNJT33OEd16IemzQ?=
 =?us-ascii?Q?XDgNPjF6obahFWd2r6khrQMQo+lFDcH4o2L1NL4Z0FD33HZR4gDwoSntykpW?=
 =?us-ascii?Q?ZwCG6yoQPr1XSlGc19veuwNG5evGTplgsL74yeuvvR2BtPEoehPZr/idgXpi?=
 =?us-ascii?Q?V1wo1gZJ5L/iwxE0J2ykBlBDoZWFYdAb2DJJrmWAb9X0mBeEnJhsh9D5jl6g?=
 =?us-ascii?Q?M6W/j1TZriWasuGHg7Mp/WSO524XbKE/AIoeFiJLbKgl1ALhoIAmpSS2c/N3?=
 =?us-ascii?Q?6zklSD4Ks7vQsHjYIaxRElUuoYvPbttB+QFDDpRPIy4mNnngLoEai2MSeUSo?=
 =?us-ascii?Q?h2UEIOBRr3UO28FbQ8Yeyf3SRF4S95SSqn/eRJe6dHSC4lpX6khjkOpUAQ5o?=
 =?us-ascii?Q?K9cD80Yzdv+zRgbhV9hR6Hz+vX0dSNhnX4nAlRAy7oaMOiIlUfEhmjpQCPBc?=
 =?us-ascii?Q?hKJ2+f9k+lc+RLWT1VtgvHFkBCBDp9FXa0l5LDT5hSa435GnyyznkOJT2BsG?=
 =?us-ascii?Q?FBNSjARFVSGSx/WdYleHAoTYBqq2vmQPfU/xDbo63/Xhl4jwHI8lg8HjJStK?=
 =?us-ascii?Q?QqBbMlkYXgAl+UupJ2v/PHRZ51Se6aQGhDbiZaQD8L2Tq/HT7KFw6UxZoMC4?=
 =?us-ascii?Q?0mZAS5dzN5AH55HDdm+sNKia0XNCf+Atz4Pxv/USEzaNQgJ//xk4qmautqkT?=
 =?us-ascii?Q?SM82gUCcvUm+L9wySkgA77VJF14Y1rYG+VEaItlAi9RyjohZh7e4qovhz0iF?=
 =?us-ascii?Q?bGbLm1F9Levo0IPhDB0IIBu2/LZ3d38zqVBqfCICcGFx4SnMxNF3XTq0yftr?=
 =?us-ascii?Q?dwYRDsmTHzVxNlhLzKSyrJ9hpvFOjmO87GZpSMxTmj3p3KD/BGFsd+wsoQx+?=
 =?us-ascii?Q?jhSQOUOzW+jae06fCPdAV+y6gDtZMxS6DTd0OB8eKrpNlO/pCB6fHUrSPFex?=
 =?us-ascii?Q?wcGGHjBrvTMcLpgVhj01TdL8cPOjxPXbqPdU5YiH49R8fN5aatIh+b7Qipy1?=
 =?us-ascii?Q?IOIJAuANWjcfwV44tBtGBvSxBl4lD4e19qjeDyEgRJnqecbIaQjfy/gqSGWs?=
 =?us-ascii?Q?UnkQKEk8RanbY+mGpN/PMdtzVhAtyQ1kiwgVam2FpFTNDVnSYHrqgi4t5j6y?=
 =?us-ascii?Q?RUDlRJN0lTP24irYZXwkWHk/+dIsSGFLnKiuRoeNc56PMmvz/prmx5rBQ6qb?=
 =?us-ascii?Q?0IneA+wyfAalkhGup7FyNJRAvmChzFub+KwoXoMDheGLkhKXCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:37:14.3930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580a2f29-dba0-44fd-cce0-08dcf71af5c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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

Currently, the pp_dpm_mclk values are reported in descending order
on SMU IP v14.0.0/1/4. Adjust to ascending order for consistency
with other clock interfaces.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 8798ebfcea83..84f9b007b59f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1132,7 +1132,7 @@ static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
 static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, ret = 0, size = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
@@ -1168,7 +1168,8 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 			break;
 
 		for (i = 0; i < count; i++) {
-			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				break;
 
-- 
2.43.0

