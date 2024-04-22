Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A7C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87F1112BE0;
	Mon, 22 Apr 2024 15:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0tUdfSsT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A940F112BE0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgyf+EsYT6pbo2lC8NS0j6Z15qmqw6oUgBF0b/g56Fv/fcEeo27oWbgtuFYMck42xF3PabRNCfQGGz4fbv2TYnxNAFXo2MBrMyUgkiSjlkHh4ZNh/Q8r5kZi6pPuqzP/y/v29EqElJnx6LqjvRMcHaD3Ajq9aaMS7B2bkryqS6ATVstKSkxZO7f1ciGBRyyP79lQceXVkGSvTvj47A9MpFQ0r+p+fzghdScX6ICAZWfjNDkC4l8TUMAMnVFEX7XgIVOtwTP6Z0wkiyN6OZ3kywlpzEzvGyFQzTX/Nfas+VhPoH5Q39FMk686G1r8McYEAgNXs7Dk3QtkDDLQXT8CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpNQDOsepFc00FE8ho8NPvqrcwIParEVHKFTBVIfq0c=;
 b=Igj6LlPcN6DY3A/GTlWeNfGBoG1V+SeqUBV+dlfkPtDrw9KTMIARf8PMBXYI65geeHDVPOcVfHZp6pjHFu3w9fBOrv2wl7ryiQ3VRlDp4BC8qjApfHMVoPYHdXPD/dPqh1/34Y0TYUS4hsMl+2K1tvaxkhFmPJAESRBDBkj/hf+7huVJFbxkl9TG5Th5FrJGSFicIWPBzP/8t61WAvy6BtE94FZ8gGwtOo9FfwuV96BOpMZeZg7kSoIR9XahYjQvVZAt5DU6Wc7s7WmUUdtC1x/01qSxkDXWJZ28Br5l3wMjqsC22s6PR4EKAPxRI1b0qev0YLi2GVPksljxOCN95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpNQDOsepFc00FE8ho8NPvqrcwIParEVHKFTBVIfq0c=;
 b=0tUdfSsT95vokFUpOKxpmgGqNgUT7zaCppZi+sbnVrMj9MYKo14qnYkSn5YiVThq0v9xPaARQ+Slqrg6czHxJGSH4vZv6I8+z4MDCjcwnUVF0ZDmqHeXtMS+kwh1UjV1ldCr3ZKGGaUKxG1HbvJiKcSRekFqR8Csr/KNkAMIc3o=
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 15:28:36 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::fa) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.32 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:34 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 02/37] drm/amd/display: Add missing dwb registers
Date: Mon, 22 Apr 2024 11:27:11 -0400
Message-ID: <20240422152817.2765349-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6803279d-fb63-416c-23c3-08dc62e0e06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2FD8yMba1xPRIQu22307e5ZGIuztCaYW0tRa81UlwdWla0MEz9p3APM65zFp?=
 =?us-ascii?Q?XzsocdTM2SGCOxUQ/fvwQh8ae6Cah6LgVOrH11v7buKXW37StYchcOoUsnif?=
 =?us-ascii?Q?SxGb1o6gbYKFoHq6K3tpTRkVujiv+Cr+NFuIs408YamplTCYYwboFx/iytv5?=
 =?us-ascii?Q?mfocJKI5kaIc5F4DS9OI/9mrkQ7joF9I0F3/NzOl4f97Z6aoAXkMIU1pyX4B?=
 =?us-ascii?Q?y+goc9s7FekTMD+4oxFM8ZbUIn0jHBxg+6Opf2Yq1guqQ7XK14UCDxexEpa5?=
 =?us-ascii?Q?C8Bxqf//ncWritdOPY6DPk+1/rMoBkJu3IyfBLfrUOobBCOwtfNwiUiorUzr?=
 =?us-ascii?Q?4FEyLAvUvgBACvvEli0ChjPh0+RXH8HHA2fzye2zT/XUFYoXuzg8FIEjGwQq?=
 =?us-ascii?Q?4f4TnMW/RkLl5mvOB+2EUv/q1p5Rhrv8rrnBg+Mw1YvHnM3X2ANex9Unww8g?=
 =?us-ascii?Q?M+S1ZRO3dOUstpNR5JqKxqFyIThJ6b+Ui0K2be8gLylCo//E/p40VXs7UQ4i?=
 =?us-ascii?Q?vTmUPwudHSStBczopNNlopqhjDQBI+SJHZ0MD2W0agIZ2Py6wr4qOgd81h8y?=
 =?us-ascii?Q?bP2z9s1q691Jhv/ktciaqpQq4mOIrCCZkyU2URF8E6i3/eTsBUlqs5u//4VZ?=
 =?us-ascii?Q?MJIvoeBLukQSOpz7XNPUgr02BRzIBA3VtysLVlJQSfvsR+CS7e8s3a9Kl0uE?=
 =?us-ascii?Q?f/+Nen/j4oTEJBqrZZzaXUeacOYP6O0WzFKDo1ZpJFB0W5q/v/qAlIfCr1mc?=
 =?us-ascii?Q?Sga3s5sMCofN9i6yTNPsuEKT+mcNcl2yftd+/zmJm+gXLvgvWRN7RuOotI8w?=
 =?us-ascii?Q?eXvaS3PxBYQLGEt++jBr1k2tMCVbM79MMCGWQIomMUremR/0N3X7ra+ZhOqH?=
 =?us-ascii?Q?1iOfL0WVVGBhZVtjrFklRhTXdijZSKmzP66M6/42b8GUbQw2D8h/lK5jgeog?=
 =?us-ascii?Q?VG4WOyh0KGAihzkG0samhouRUcpabDblBzljd+I4Iu4ItBuf78FJ1BULj/sj?=
 =?us-ascii?Q?jZCU0CHRtBjHfQjiBMYQ2oBLqoldoNG4DCOREpnHhob4UqZ/nkRX7jJmOhC8?=
 =?us-ascii?Q?d/RYScyF2pPl5PDpqS7zqJVshn+S3KBijtvnXaunJkhzzczWNUvqapbj1NTm?=
 =?us-ascii?Q?uu/fkBHYehp0n5sRqjb1AbjBOsWR0VFLmfupFzx11pk5AKSGmH6yQ8lTHxhB?=
 =?us-ascii?Q?Jv0wuf+X81X8c8w2j/B2aL7l9NlC9HfGod9IWIRC9Wv0mb6/dMQPKWJPmh9+?=
 =?us-ascii?Q?AXtaKywIctEyzLAe3jr1yrqeR9rUotx6cESXv12mZuEvzO2b2Mn2fj2eB/nR?=
 =?us-ascii?Q?iqF4D0czw5sJgaamyZKvA2pU5jI7ncRCMHgDkYx/baG9TSmsMLIEZtPc/AzR?=
 =?us-ascii?Q?c6fLMdQ36CU1BMABYrFV6aHUwXVt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:35.6366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6803279d-fb63-416c-23c3-08dc62e0e06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

DCN3.0 supports some specific DWB debug registers that are not exposed
yet. This commit just adds the missing registers.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
index 332634b76aac..0f3f7c5fbaec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
@@ -217,6 +217,7 @@
 	SF_DWB2(DWB_OGAM_LUT_DATA, DWBCP, 0, DWB_OGAM_LUT_DATA, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_WRITE_COLOR_MASK, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_READ_COLOR_SEL, mask_sh),\
+	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_READ_DBG, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_HOST_SEL, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_CONFIG_MODE, mask_sh),\
 	SF_DWB2(DWB_OGAM_RAMA_START_CNTL_B, DWBCP, 0, DWB_OGAM_RAMA_EXP_REGION_START_B, mask_sh),\
@@ -524,6 +525,7 @@
 	type DWB_OGAM_LUT_DATA;\
 	type DWB_OGAM_LUT_WRITE_COLOR_MASK;\
 	type DWB_OGAM_LUT_READ_COLOR_SEL;\
+	type DWB_OGAM_LUT_READ_DBG;\
 	type DWB_OGAM_LUT_HOST_SEL;\
 	type DWB_OGAM_LUT_CONFIG_MODE;\
 	type DWB_OGAM_LUT_STATUS;\
@@ -710,7 +712,7 @@
 	type DWB_OGAM_RAMB_EXP_REGION32_LUT_OFFSET;\
 	type DWB_OGAM_RAMB_EXP_REGION32_NUM_SEGMENTS;\
 	type DWB_OGAM_RAMB_EXP_REGION33_LUT_OFFSET;\
-	type DWB_OGAM_RAMB_EXP_REGION33_NUM_SEGMENTS;
+	type DWB_OGAM_RAMB_EXP_REGION33_NUM_SEGMENTS
 
 struct dcn30_dwbc_registers {
 	/* DCN3AG */
@@ -733,6 +735,10 @@ struct dcn30_dwbc_registers {
 	uint32_t DWB_MMHUBBUB_BACKPRESSURE_CNT;
 	uint32_t DWB_HOST_READ_CONTROL;
 	uint32_t DWB_SOFT_RESET;
+	uint32_t DWB_DEBUG_CTRL;
+	uint32_t DWB_DEBUG;
+	uint32_t DWB_TEST_DEBUG_INDEX;
+	uint32_t DWB_TEST_DEBUG_DATA;
 
 	/* DWBSCL */
 	uint32_t DWBSCL_COEF_RAM_TAP_SELECT;
@@ -747,6 +753,9 @@ struct dcn30_dwbc_registers {
 	uint32_t DWBSCL_DEST_SIZE;
 	uint32_t DWBSCL_OVERFLOW_STATUS;
 	uint32_t DWBSCL_OVERFLOW_COUNTER;
+	uint32_t DWBSCL_DEBUG;
+	uint32_t DWBSCL_TEST_DEBUG_INDEX;
+	uint32_t DWBSCL_TEST_DEBUG_DATA;
 
 	/* DWBCP */
 	uint32_t DWB_HDR_MULT_COEF;
@@ -838,6 +847,9 @@ struct dcn30_dwbc_registers {
 	uint32_t DWB_OGAM_RAMB_REGION_28_29;
 	uint32_t DWB_OGAM_RAMB_REGION_30_31;
 	uint32_t DWB_OGAM_RAMB_REGION_32_33;
+	uint32_t DWBCP_DEBUG;
+	uint32_t DWBCP_TEST_DEBUG_INDEX;
+	uint32_t DWBCP_TEST_DEBUG_DATA;
 };
 
 /* Internal enums / structs */
-- 
2.44.0

