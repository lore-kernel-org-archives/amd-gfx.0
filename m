Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C89CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0DA112E82;
	Wed,  3 Apr 2024 19:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtxY2ghX";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F28112E7F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz33Tqnbg1ug8wCEAcmAdh77xcxFh3/S2b+bgOXqm4mIrF9XoDvcj/i5nEdinWMlhYCXMKAgnRY9XM5r/LCo48TB4Q1lTD6Pj0d5adLujWbqj5MUlozqkYOtgu6gyGSWe1139i0+zz0d0KD5qVxOtX9VGE3Wyf2U3XYIFy9o0UpvIYs7lRvigNO0VNxfGGr/ke4SIr5aHirobej7DiTtXUnn5+jnEEBa849M/jCJHVca2ciDuR1aBI9i1kwpxdKZxJytPx6qE5Ciuj9QnVpUotWgxL8vDd2D1U4v80xiQ4cx3j4bho4BifmKKYJzUOqmf9w3P91uSe9MtBtwAClM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWAHHTqWDr5BVnvYH6pFPSefVGJrnB0sfrVJn8F0pHg=;
 b=KAkD8KG3TQljcX/obsU6NDaEEVfMdPugYeq/+7A16PEPFjRjQaPkKYCwu8L33Uoaxk9ypkFAwyIfNjm9JJDt0N56pT+wmhwN4lZ0CXEX6NF0WmxFFW2QSqYAHLtdEaUcoKyUaKoRjjOe84wYDQ/zA05q9v/BV73fIcxhKweZR13QYXYJRxozJP9pMsSQ6nordpKMGKnsZrwiwJWDWz1pHclqN316yx6QYxoc69deIwWZOFYEm2IjZMp4wCx4HW41ykiysYKoBncPgx/rQgaL7hE0Zsim5WPH7GU9cwBVuJVa6zt2n1FT3LuP5/jMXD/5GQ/D0hA53gmCfCoRaoJETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWAHHTqWDr5BVnvYH6pFPSefVGJrnB0sfrVJn8F0pHg=;
 b=JtxY2ghX1GCqxXm3wNUKihDHTE/z1c6x0nDS6tK5Nw3HkHpfdYBX9HusoRHGLspSthUNM9kwCF8O2LxjILfvDC4f3DjJES+pH8iJ+LGF2YYtXrBbKGgU5dqLg40EoqDFKRtAqEacQIIS7bMAkIbF5P2OnL5t4kiI+/fZ90xRzPI=
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:50 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::c8) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:50 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:44 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Qili Lu <qili.lu@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 15/28] Revert "drm/amd/display: Enabling urgent latency
 adjustment for DCN35"
Date: Wed, 3 Apr 2024 15:49:05 -0400
Message-ID: <20240403195116.25221-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bc2193-0c84-4748-9246-08dc541780e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3qraQ+DQqkjxrSwMYm85htuw/f2BaBvuziZ9nMVWFkcBfrxrTAXT+9ESoINQWZzm6/lFwSRogR8rHwMQql0MhCq33X8qfW8XzJ3upppnGLdNlJo+AWflyDlHAawGaS566o+DjcXWRPdtXr4TJlQurMO+dDJF80IGmyP26G5Go9lqG9gZI3VUMI8CJJDLjq9wKz1bznC2hT3hKVvO7Z+kZlRIDXcSxIiBS02dHAuTyTttj9R2PA6xO5oUkkLH8V2p6vgur+zpnqczZlDQyaS4D87A5JLk79dbfaIzuJW1kDdcc5/FRx+kYnmv9LPKxwq9H/6TXMMemZas610pQCPYrZ+FH37HSmBUBsAkw2VzNBsXwXxYHGMYDUA9WBpa7mgaT85z61CLlQy0iA8y4+p2C8vUjpXkUk+75f2Jdh4vMnViGEeDAKtbZkQAcQx5Tsm7Ye5tKtiC86YJ5/sgqqPd+GAZAVcHBHzlRw/XRaT4pVkR3TAiQNdCNbPj9CPL+bQMsnaIaTxeH7UdYcgLs/N3OmivArRZtwVEN66Ge7HGweDYVbJ+JKOBB11EB1d3jBrQXQkADiOkKcfZ70n5bkorRjcS8m3oyr/I0IprdBsIL5/4OZvIP7rh83hqAcgDQxvNlNmn1uXAEZUyUxpjaFJknmwvcYhKn2/ootmmeVkkgfMidAbSf63KCAydQzCZBG21CJpR5OpwVabY+cu7DayGUlafoEdxbMhe+HPsp+7jl2j5CuA6uvNotQpKsfy+A8r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:50.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc2193-0c84-4748-9246-08dc541780e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

From: Qili Lu <qili.lu@amd.com>

This reverts commit 5145de86407c2d28cfed007b5014c0d0b40d5913.

It causes a dead loop in dml_prefetch_check.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Qili Lu <qili.lu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 60f251cf973b..add169162f2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -195,9 +195,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.dcn_downspread_percent = 0.5,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = 1,
+	.do_urgent_latency_adjustment = 0,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
-- 
2.44.0

