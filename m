Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C0EC021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B61410EADF;
	Fri, 21 Feb 2025 16:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ciZ1cyBK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDA010EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiY5aN34Ebb8b67elUoy9He96NVLakP8twEluOlxEZ/YjmWPoWx882yjTg1LkAGNpdQB66dJ6R86y/AOlN7amVeS5WtHNljiFL5j2NUYocBOXL9Hr3RpW5pRJhMnSmQjpeKO2F/823GOyBxDRGg2tXFPEM2O7k4CV3RiYfCVtZetESht3N8mJ5CbrTIp0eBcW/4GXY/J+JauCD9NglzBtORvTBPx/OgLj1b1Ra0BeFZoWtiIfnlIxYkHPnueuBoTLPdOkgtxeTEwWkFl9RElZap7kYm4fc++HxpN0S2Qbwl0zeTSBtrXt/o8eSyThPsGqp7rBnUnMZFqemRQd7ZKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu2NRjYx9y6uo5lKV0++H7EH6NjE7yALKnxVhwz0cCg=;
 b=DFSGRLhfhSK7vdd/TY5S2z5xVuIvKH1bQZ3QcW5MADlq0G0nTZuCPS+1esSRNpNDmgeaV04L6d+Y+J2h2i75bt5KD+iARdBYjqixqY+3KPnHWaxu2gsKmOKgzHzQ00cs2ponAcesu6RI4WC4ZqX0AG2inJ08RFdF/NMb0KWn2OS8V7Gi1Zk5N2yBKBXp3wSUQv9c9bq0NzR/SLuZR9y0opfqnwVvg3LzXQnFblgJwDROM7T38zJTK7kbWXWNZjJuoYusULcSawmqjOKZOKK7caHrtPIErRGKLPHxijbEjjaA+LLgTvuDYqrtb2cKNNchvE/Apk3rKNbkF/yGd77ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu2NRjYx9y6uo5lKV0++H7EH6NjE7yALKnxVhwz0cCg=;
 b=ciZ1cyBKddoUXa511ZvE5D3p2bQMXRdx252HzCNatgNe2QjXPgwUqOxFzaWp0ku3GAdiX2jbGBnjdu3ncirzz8+P0EVv/ivw9OBbuW6dqwz3S7LOESXt/tlpIjJ81/qTzCr8xFcJzfJuwycrsMPjevs/+sBiD+fTmEB+PEySB2c=
Received: from PH7P220CA0055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::8)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:19 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::f) by PH7P220CA0055.outlook.office365.com
 (2603:10b6:510:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:17 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:09 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Assadian, Navid" <navid.assadian@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Fix mismatch type comparison
Date: Fri, 21 Feb 2025 11:01:28 -0500
Message-ID: <20250221160145.1730752-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ecf978-2730-4d36-6171-08dd52911de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d4GxfOP7pLrOadiOM1FQi9eq/hvWXk7UBOBJLAFE/GoTsZ7d5GTxVMHeVbIT?=
 =?us-ascii?Q?ILCwbjpFcFaUOl+lBFT79RSVdXUbLkXDf8726f2Upq6xd9LlhHAYs+TacRrV?=
 =?us-ascii?Q?9B/Hvxa7AMwC4TqAdatdIIQMULuizM+rahEaYK9JLJ//vBr9Ba76My42pcCN?=
 =?us-ascii?Q?vhfHkGfB2NLQjkuHvDLSfdpR4JVe+YJn8r89AUaY/N4i1ADhaGS1OST7E14V?=
 =?us-ascii?Q?rXFd5u++o1tbbygm5m9unycySdDuASY01YKmIFS1zBVZ43Q0BYepECIp0Ly6?=
 =?us-ascii?Q?yPAsjeGdZy/Y2run2i2cx8anMCCKSOthVAhCb0CztZbpqcbSIiW84Ytghmsj?=
 =?us-ascii?Q?PopBrdrLqRDtQXlqonEvc9HzLgQY8rpENDDxhWxRGJmhVLhdhJT2uGoYz/Ml?=
 =?us-ascii?Q?dpOuAIfSciL2aq/NdSzmlNQjwGaBl3k/3wSULKw0LADc+8p8vDlftMVOfPXK?=
 =?us-ascii?Q?j3Hd1vqjwwyzbH8IzfeNAUB6YuvjCn49yZxxVLlGaMTyjLGvUowxIk+/Pksw?=
 =?us-ascii?Q?S6W1GBbXl12RC/H2cMK/lcHJkYhI6kCO8qjYtJNpNERtSVYmfPy2ctKE3m+p?=
 =?us-ascii?Q?ArP+EPfk/8oZHubYDdDADAJVvCCn4qjrrt6zRMgAeVnXgDN2/o2viZPMfpg5?=
 =?us-ascii?Q?dAcc0h7EylYve5SWadLglDiqcxcW27qWhcsDPDwMpAWRIR9KRsoptK5jfoBv?=
 =?us-ascii?Q?vWgHDME3vy6yrwyRqZ8X2BOLjYJ+YRg73Tc45630WLHATrO0wFMd1z0BjsRc?=
 =?us-ascii?Q?HISI+Q/dErAEbZEJqerS7mJPsQGDgpK0U5enq7G6cNTB4PlYrBYPEUgDcstf?=
 =?us-ascii?Q?T8SKPfd3/y68putQ2uKOoDzYHbF6wJNGNq1xSEf89w35H+02PZbg1znL3Q6x?=
 =?us-ascii?Q?bifwGDwu0UtYS0EUlmpK1n4qXZp8xU11Z66F6EWMbuzBu5F+qoKKBefgna/b?=
 =?us-ascii?Q?rzq+L5bUOg4A2nOU7iMjmz8/PP7uRflc+dTuhqM9OIgH7v6ybsjtpeo0C2pD?=
 =?us-ascii?Q?mK3BdCCbJaoP+eaLf51vtobSCbmMpKw0OKOus8rt2aRMuRZOoj6rcnmM4PA4?=
 =?us-ascii?Q?3xVYlm4m5EkriuFWaqEUJoQMr8o3TuUIgiuehg2iEN+64HGaQ5I+BUsGFNo6?=
 =?us-ascii?Q?6rYKsd4w4QS1dkSiwM+0CLQ1Vu0AZflWogfCSybtWYxA9JNv4iJZCtzlNOiJ?=
 =?us-ascii?Q?tUhKbPDzynAwNwFJWKXiu5msotqZlLAFYnCKwSyTfcFCgyLyNy8zEhfGvON1?=
 =?us-ascii?Q?wEN5MwjxxxMPtfUD4ySKs0XENMtZr3+V/9lGILwabL96BEYVYfvn1JgFTSzD?=
 =?us-ascii?Q?OVzVymONCnJoVaDTo+17Ag9v4awYshyZ/GsjSkYQPCo8+SVzHSA5so4Ieg3y?=
 =?us-ascii?Q?bVk/wbbjfg/Y8kebJTdrKV4K3RxVGZLJ2rLIn6nNwB1fTDuiwRDg2SHl0lIw?=
 =?us-ascii?Q?M63qGokPIe6Ril2oGl3Y0IVkwMSaJyck9EqzcWgc6O7tgCRKIKpLJGhgSm9D?=
 =?us-ascii?Q?lJrZKUWOQWJU74o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:17.9739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ecf978-2730-4d36-6171-08dd52911de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
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

From: "Assadian, Navid" <navid.assadian@amd.com>

The mismatch type comparison/assignment may cause data loss. Since the
values are always non-negative, it is safe to use unsigned variables to
resolve the mismatch.

Signed-off-by: Navid Assadian <navid.assadian@amd.com>
Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       | 4 ++--
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 72a79288ab79..3d85732cc0f5 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -944,8 +944,8 @@ static bool spl_get_optimal_number_of_taps(
 	  bool *enable_isharp)
 {
 	int num_part_y, num_part_c;
-	int max_taps_y, max_taps_c;
-	int min_taps_y, min_taps_c;
+	unsigned int max_taps_y, max_taps_c;
+	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
 	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 0130673ceee6..1c3949b24611 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -493,7 +493,7 @@ struct spl_sharpness_range {
 };
 struct adaptive_sharpness {
 	bool enable;
-	int sharpness_level;
+	unsigned int sharpness_level;
 	struct spl_sharpness_range sharpness_range;
 };
 enum linear_light_scaling	{	// convert it in translation logic
-- 
2.34.1

