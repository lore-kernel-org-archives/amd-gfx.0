Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA3CC83F10
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 03:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25DE10E12F;
	Tue, 15 Jul 2025 03:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MPEbNPIe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15C810E12F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 03:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlBpoRZ+ia4jXtC6aoMeKGqmv7130t1Q/1c19/R7M2mknfjZ+Zj1WxTZPmGXMuz7A21hmaA7hr6X+PIXo3xsSWVMZp03CUb4Se2JS+8vJ+XVTBUDvphtRCZzGO572JoKesWUECRG+rsM58giEAryV5lW+OBjmhWEsmYQBWzRy09uDsS/Ij7MbS8NNm37pzrIdfYxKVRzbHB7KmAREqx/LAcILr2X8182QkzGXpMJfEUUIPB3m/uGcmyp440dXLSp5g6Q9sm8Kfx9VTLK200IkRlrTe0axjnWvxJof0TONl4kPCHO/tND4i52uQgq9UUrWA4+oVnYUxqK91vDb8QkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pZx/Z7TSjFnl4B+t7mTRqY2xsm/CU3n784aEXuNfa0=;
 b=n9/Nq+EPN8cr8ti3XXjEww7BayTINvcqBqBaktMSqaw78x4Y5O7BAo7P628ggOyz0qPEkYQVRns/v73voB8KaHZTRIwgQuyCV+RPP9JvzWQG/Vhy67+JVHJCoaWCmJpwt7Q5N0ClkqgSelTXJzWIPiW1G6WwgIJR3pR03+mH4TarU2S50Bh5es+04Wo1miOcsnQWjcgV0hLsfftVEAqABtWhZfwTGmZ9o3w10f/jFnfjfPUab/EqmWpmvldG4BxO+hQaL94FCpkgfB7nbC66RVDUZ7thSlmKD4qhZf8d7476pEzibed1Nrf2GiiP+wYgmaek93ZQsx8ubkl2sudzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pZx/Z7TSjFnl4B+t7mTRqY2xsm/CU3n784aEXuNfa0=;
 b=MPEbNPIeIm97vH6aqdDi+jdMbyRBomwgClXmVhRNEz6ovY2OClRK2yfkCFv4iFMHnBHEPBYa/eUdq0Viz73gX0EcKmNfO5y33/875h7pfK8nYFq/vbEXQZv2j1Un9MyK5feAiATY/JrL7+tLxCM/H1a1lcEo2WwXUoer/c/5N/I=
Received: from MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::25)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 03:22:48 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::56) by MW4P220CA0020.outlook.office365.com
 (2603:10b6:303:115::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Tue,
 15 Jul 2025 03:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 03:22:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 22:22:45 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Get max/min frequency on aldebaran VF
Date: Tue, 15 Jul 2025 08:52:30 +0530
Message-ID: <20250715032230.1531865-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d786778-36b0-46e9-9097-08ddc34edf66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6F1BOIJuWYn9c32s9vogVZ2+MX+0sjO8h1CjUcVOGRBQxgyyR4qqJttDECgu?=
 =?us-ascii?Q?hg5/klt6VHq+8hvW6sQsNuEFkZYJj9GGqhLVyYrx92ioa5Kv6PFcdU3zADff?=
 =?us-ascii?Q?7dhAUGbuFJwYHoJ7l7V2c10qhi34R5KQnY1xFK4Wy2nGo5yADR+DoF7EOwJT?=
 =?us-ascii?Q?TL3Qb0almZSSQ3+hT66sqwycXeSZJrKURgtCiLo80pvX7GpeibcPLoMd0Jih?=
 =?us-ascii?Q?axSk7mtCU20UvV8p1VHQhTgIBdnok+PfXvL9v/1MUcQ1D+S8Racfdf3q9nou?=
 =?us-ascii?Q?zddkBv05gzh1GL6TcwthmCKSEvRAqT7QRrNLhcb+tXOGJPaacp70JUJ7phNG?=
 =?us-ascii?Q?meaYoYpb3ru6EW5nqK/l+SCuBkD7daleff5rW1FYGChTBbeiosMpr0nHB232?=
 =?us-ascii?Q?iBNv2+d2bekoDvcNNsHDMabBzNU2b6gRweHjTMk6ggCSOnTZHa2mGe7e3Qyi?=
 =?us-ascii?Q?y7Er+tQtNatbD12YVoYsLHlwimcdp4XQpWTx4fTioLWHwL1siGUmh5mZGZEV?=
 =?us-ascii?Q?C7eudfLhG7OErETZ33wOF8P+gqlWTgdqYjW0sTbCNaXhrtQtTC8YE4qm613n?=
 =?us-ascii?Q?h4JK21j4DnboBn3++O09LHFM1Xcysa8gFTcVPUHvVVPibqK3pW2+CAtIwS4r?=
 =?us-ascii?Q?tnIB823GWT+Vte9l0WGGDedARxLodDarHM6Hnsgv6SXZauphxv7q+9PPs1UL?=
 =?us-ascii?Q?7pLtBUECG314yZ4BLW2kzrqk63Mwa2nKY/W1tuMy7S8kS6G/mVozlIeI3xD6?=
 =?us-ascii?Q?k4v776eBWPcOqL8emnzWmoUWejelkorz7XEpk3YbEhOmqOz9Fe+YC7yOFKXk?=
 =?us-ascii?Q?riV2EqncTANTXrX0fv56/LZn/3o1ATDgRsQZHWWCD9IR+40HrkPxQ0qMNHN3?=
 =?us-ascii?Q?HWhICaMGcd55SOlDOb+bGUxEXCyKmQtV9HA2B9mw1DflbBXLE8fe12vGCq1E?=
 =?us-ascii?Q?pNExQsbDdKlyTh+ZpQmkHwQGSF1yYkjE+a/qJitOfxLeckfEcAYJfSpd7OAG?=
 =?us-ascii?Q?pcu6flms/MgXqHnzPEW5xZNBIH3ANDBCy4aiOu08voffEy6Cs1Q7iXlpekQm?=
 =?us-ascii?Q?fQMmYGHpcctB3WzRdL/CTpkVHBIaln93g0HmwgPhNEtzOYHabmp+3s0MvlDZ?=
 =?us-ascii?Q?rjh3BUOfGJoM1i5OQ/6+Pj+m1kvT38UG3MAw6wG79j9QSeurl6pCoeqZ+Vaj?=
 =?us-ascii?Q?S9lBbrt26gCsEiNs8UNFgijlTOrIVs+2WMPLZQDOu8L2oTTo7a9uPuRof/Z2?=
 =?us-ascii?Q?SQxSPXxWqObUcUEaMpWp2TZJp55Cjrh1t9IAnCeY5OvvDErnOGVs8fMKk2y+?=
 =?us-ascii?Q?PfmqiBH3xbzjkppMngb4mlW1WzTbI/RlFNWuOCPLq3jIePaUruvR6rD21qFw?=
 =?us-ascii?Q?AlDsXPExng2v4cZBoWxwUKB4SDm06p5+GXREk3aWzxY8etqyxQXGPLdeoQ6F?=
 =?us-ascii?Q?5K+a/r5vZ8XpmtV/OZhhDkwuM2AiXMEJJGcWJNEjFrGNO0bZLqBtAodUJjrt?=
 =?us-ascii?Q?v9NY5KGwEaR2b3PT1C53jYzThG+IKAkAsbYl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 03:22:47.8514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d786778-36b0-46e9-9097-08ddc34edf66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
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

PMFW interface to get max/min frequencies is not available on aldebaran
VFs. Use data, if available, in DPM tables to get the max/min
frequencies.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9a61cf904275..b067147b7c41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -342,6 +342,61 @@ static int aldebaran_get_allowed_feature_mask(struct smu_context *smu,
 	return 0;
 }
 
+static int aldebaran_get_dpm_ultimate_freq(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint32_t *min, uint32_t *max)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_dpm_table *dpm_table;
+	uint32_t min_clk, max_clk;
+
+	if (amdgpu_sriov_vf(smu->adev)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			dpm_table = &dpm_context->dpm_tables.uclk_table;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			dpm_table = &dpm_context->dpm_tables.gfx_table;
+			break;
+		case SMU_SOCCLK:
+			dpm_table = &dpm_context->dpm_tables.soc_table;
+			break;
+		case SMU_FCLK:
+			dpm_table = &dpm_context->dpm_tables.fclk_table;
+			break;
+		case SMU_VCLK:
+			dpm_table = &dpm_context->dpm_tables.vclk_table;
+			break;
+		case SMU_DCLK:
+			dpm_table = &dpm_context->dpm_tables.dclk_table;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		min_clk = dpm_table->min;
+		max_clk = dpm_table->max;
+
+		if (min) {
+			if (!min_clk)
+				return -ENODATA;
+			*min = min_clk;
+		}
+		if (max) {
+			if (!max_clk)
+				return -ENODATA;
+			*max = max_clk;
+		}
+
+	} else {
+		return smu_v13_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
+	}
+
+	return 0;
+}
+
 static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -2081,7 +2136,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_azalia_d3_pme = smu_v13_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
 	.get_bamaco_support = aldebaran_get_bamaco_support,
-	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
+	.get_dpm_ultimate_freq = aldebaran_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
 	.set_df_cstate = aldebaran_set_df_cstate,
-- 
2.49.0

