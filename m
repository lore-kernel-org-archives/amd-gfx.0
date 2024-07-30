Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB85C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC06510E4CB;
	Tue, 30 Jul 2024 07:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3ltBAzO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3290A10E4CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eucTcdUoJWeecc5KS+8QGTigAgaEErtrd5eab8Tb8TaTJVwjNJwq0o7KUF2M79wK+0HLsXgU1VEL79gn+jXhZtiDR8uAeZLBrJ53ONlkyaxZYFRldf6s6YfdBMp5Ghp9d8sYhjctgiZFEUkVPQ4nSyqoR296RY3GV3TX+utQGuWy3tWQXaEhm+xkQes6x5dgCayi25yehGzSt+pyvVi5fbGQ8buk+x0kQp8VA3qEVa9DfWbJSuyPE9wIq2H2GGxcltjLxfzaX9AzFInILYNltjltLoFQZD3h2/+oS99aw8cKDPKPxcvYOmnYzSmHuYvidx3jawGOAFxD9sA30KXpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQTP7AeBobtwMOi3IQxtQachrcCfJHZ7SwVO2jNUUnA=;
 b=Xv/IQYqVVd0CGsXKbeS/kx0IerLhspCEINEKh/lxG1TvwX0ns2nH0zHQTTIAhIjc8hSehylbhm63dzDF2q3DlHRnlX5MqbM+G5dS5JerMRsK7DEGZufqiZvNpI1igtXQ2e3BJeaG/HyTtctv9ZxVOFUZ4K3fgWNAiGZPYFLBtcsQwxs2a3Ve30DCEv1LsPvvy302MSvutw/K9TIqraoYybv1HJ8jEenkRpI+OKi0DU/94Jhhu/ix3JdwcB0p75WVc/fSJDoxGO/9UqMAGSp+Nvp6wI1YppTr4zX4c5fD8ELU2FgWhunjl3PqcHGl8ENrdJKBb+6NwIbUyjLbUAbDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQTP7AeBobtwMOi3IQxtQachrcCfJHZ7SwVO2jNUUnA=;
 b=m3ltBAzOe/gEEcOYLXLWrjd8iB+dFzmFHgVQg2c5TfPs+UKqsd1uvJkrCrbQGe8hVmF6vCWqBN1jOm4mb9TFp3KGypEzGBYw5dtDCKOtoJV2ezCd3kMcrUmjkwrgqL7Xg700wrQc+ZfwGIsIWNm2U/GLHjaSvAODV7C1kB3ZBvY=
Received: from BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Tue, 30 Jul
 2024 07:22:22 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::b9) by BN0PR02CA0020.outlook.office365.com
 (2603:10b6:408:e4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:22:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:18 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:22:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Gabe Teeger
 <Gabe.Teeger@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 20/22] drm/amd/display: Revert Avoid overflow assignment
Date: Tue, 30 Jul 2024 15:18:41 +0800
Message-ID: <20240730071843.880430-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3c037f-e346-4b42-8ab4-08dcb0685a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VRpe0gOCxL4hHg42od2bR2/mBte1LCz4Eqv/ZhyfAEqSEoxHJavTN9I9GzfF?=
 =?us-ascii?Q?itwyh1PEkBXaG/2OvqGOj+rakkaKIRBvz0HxmWb9XUP+Pzw4YdXklI8u9wFx?=
 =?us-ascii?Q?LYRA+UQtpxdr5jqzEles/LKDGEnRvyGR/DEvybehr5tiZWVV0Iyp4jOyHaXB?=
 =?us-ascii?Q?uwtKAVMuKimVtWvFRlgy0HyeIMaxFxV8+TjSM0ES1a2EDajgm/n/+1pNGACN?=
 =?us-ascii?Q?dKXINO4S1twP9C0xD7dhq7MOAM8YzgY2hk7HNu6Rse9HAutdzEgsw2Sy6oud?=
 =?us-ascii?Q?A++iCmjkvhRUm6GkCT+fMmgq3DJcyIMCtkwJSyp3HxIIG4vw6CFvae4v46R/?=
 =?us-ascii?Q?6XmwYRybfaiQ0Uv3xJlb/nXK2mbhMBjuo5z0gji6Rcmz+l/66mCFdAkJKEdO?=
 =?us-ascii?Q?ddLnKC5RsO8YKup46j9Ptxi1vPlusoG77yWlJzjJF2IQUGrVS/i9DggirNki?=
 =?us-ascii?Q?5IizzrPkJyWddCfsO1nhDzcRZzHcMnBMBLkBNvuHoQNZr22qc0cxC+R2mAnU?=
 =?us-ascii?Q?QkfphO7NhZXOsU9bRgl0QDaRakq21M3veu+UDJIO22MIxT1DD300mv4OFkVF?=
 =?us-ascii?Q?D/9omJAMM6kEnMrR91drdjBWgO+MJ7ptkRR5cQU57Ec4cUOc24cMxBsBVfer?=
 =?us-ascii?Q?1UfgbtiV30ojGjS/FmKZmDOw5yC+6J0SLn9hWHOQXS9SQdl4M3KzUk7FRskV?=
 =?us-ascii?Q?sGWG46MLeq4GeESTNQ1OCdnX0ctnOkpLWGlJ/lhoy9O37mV8Xu7UhCH2MbZ5?=
 =?us-ascii?Q?MTiMypuR+kot7cbVsrva1MuZovqUs8CC47R34LwIuEXyxI1fZFOZHOKaxgeP?=
 =?us-ascii?Q?z5qgcgV/FKGrEcBYDJJtyycMYFuz5UhK00GQtjSpB6uKGmLjm3qA9fPwRnTi?=
 =?us-ascii?Q?Y8odNTJn26y3XA13msQ7QrfDT9ysdsnLDlRd5yHmPw7lcJq5LIHojM7thCbc?=
 =?us-ascii?Q?Bjy3p7h7hPOezNDryyynx4ukWAeHvKUiTohYMoNrAIz8WCmRo3zOccerhhzB?=
 =?us-ascii?Q?uekVQ6qgI8+C0ZTIbnvUnH2FilucRCuLAYQxO9esN5ec7aLIw3JPsc9ZqNq0?=
 =?us-ascii?Q?Ni2VH0n67bhqmlDfaDIaOgLTwwN7G0l6Kz5bOCUi4P8pMDVN+BqY3cy7jU5x?=
 =?us-ascii?Q?iPEh5/ztTGIN91FkJS6y2GnAKC01nli/zDWbgT1kiQuDZRgLkd6RlpPF22PO?=
 =?us-ascii?Q?n2izE976LiKvwChUazC7CxWKRFO11dSCFxopU6WEO5VJJgvAssHT5kQQi3Sa?=
 =?us-ascii?Q?Wxe7r9DnSVlEwDOA90dgJNKQW9S1mE2w96jgaj6htPfcLBxPEoZzCkTbcUa0?=
 =?us-ascii?Q?BK3dNPkLkfWMJW28WEfFu1KkBKNAtR7hljRraNHm489kRDGt74kp/4VVmiBp?=
 =?us-ascii?Q?r2H6XoND7GR+viBsU4DAuMmy1OX1I7Zsci3VTtUvmO7DUWnSSMEnoDKRJBlR?=
 =?us-ascii?Q?nD4vp5P4x2UbSHouAieDzpQvMiqPAVtg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:22:22.1364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3c037f-e346-4b42-8ab4-08dcb0685a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393
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

From: Gabe Teeger <Gabe.Teeger@amd.com>

This reverts commit 4362962f41b8 ("drm/amd/display: Avoid overflow assignment in link_dp_cts")
Due to regression causing DPMS hang.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Gabe Teeger <Gabe.Teeger@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                  | 2 +-
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 3 +--
 drivers/gpu/drm/amd/display/include/dpcd_defs.h               | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 95c275bf649b..519c3df78ee5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -727,7 +727,7 @@ struct dp_audio_test_data_flags {
 struct dp_audio_test_data {
 
 	struct dp_audio_test_data_flags flags;
-	uint32_t sampling_rate;
+	uint8_t sampling_rate;
 	uint8_t channel_count;
 	uint8_t pattern_type;
 	uint8_t pattern_period[8];
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 32d5a4b14333..df3781081da7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -775,8 +775,7 @@ bool dp_set_test_pattern(
 			core_link_read_dpcd(link, DP_TRAINING_PATTERN_SET,
 					    &training_pattern.raw,
 					    sizeof(training_pattern));
-			if (pattern <= PHY_TEST_PATTERN_END_DP11)
-				training_pattern.v1_3.LINK_QUAL_PATTERN_SET = pattern;
+			training_pattern.v1_3.LINK_QUAL_PATTERN_SET = pattern;
 			core_link_write_dpcd(link, DP_TRAINING_PATTERN_SET,
 					     &training_pattern.raw,
 					     sizeof(training_pattern));
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index c246235e4afe..aee5170f5fb2 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -76,7 +76,6 @@ enum dpcd_phy_test_patterns {
 	PHY_TEST_PATTERN_D10_2,
 	PHY_TEST_PATTERN_SYMBOL_ERROR,
 	PHY_TEST_PATTERN_PRBS7,
-	PHY_TEST_PATTERN_END_DP11 = PHY_TEST_PATTERN_PRBS7,
 	PHY_TEST_PATTERN_80BIT_CUSTOM,/* For DP1.2 only */
 	PHY_TEST_PATTERN_CP2520_1,
 	PHY_TEST_PATTERN_CP2520_2,
-- 
2.37.3

