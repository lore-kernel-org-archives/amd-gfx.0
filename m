Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C7C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1860E10E4F3;
	Fri, 31 May 2024 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7QbDSp/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CA210E57F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmEBWDdFgM/EPw2FIsIdcpsdf9FCVqyzRN0nP+iy4doBnKGN9Uf5jF81qB4i+nZAMbRGb0TI0XkN5DM5QeJysX3aYWsWoGHTwyV/XSsPJOt8MevKRdp+qdDnci8Go011yvzimDPFS5chu0MUuhupPhHvZDW5CuzgNYP3ogPJgC5h3P3swlh03z00mXEuSd/9hKwGhXJaAAi2udlqSDco6i6MmxV1xuMaWOzurez8UFu+9QiUrIYxBrkNNToJAk9zrTlKoHjHbHLexla0AzwsbESVAe0ydVPSs2hC3F+zCpvXTEondn/LQc8K+XWDYvi/y4X+t9TxFKVpsQeBRulreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6i37dhuOPslt3tvS/Br2pQI83NbuVZFGxIMdosvHTo=;
 b=gF9Ni5gL6BqIbeP0q9gEaCPAi3DNNvR+GA23a4e8C1NS0UwqsLbghPeU5fS8vZubwMgBf27RlnyUGL4fVnKVwKK6IUo8FczHRcM2qu59o/HV+cvjsQ8CmmE3fkVHjE98YkdLbNqWNPS5Izt5DGaBstAEGYcjwVkTWJ1r0zxzo66F04jUpHgflIGaL64gRcFUnr0mISx+wmVLIQ8faFUtx2K0W1cYweGbG4RT6gsWgm36WQEPxd94lCTs3RZzdsv+87hGlQe6COLljPvY/E6DEbTqnU+E5MgT6RODyCH68zVuBr2LLXkizjLTAj/tLpdhljUbWAfRnE7MoCkJyYTqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6i37dhuOPslt3tvS/Br2pQI83NbuVZFGxIMdosvHTo=;
 b=J7QbDSp/dHA0SQx+Gz9/7yF0Y8/nvN3B7Dz0If9mfOzgVua71tle9gxHPneN9gPIZO9mwfE3J73/b3YhrjXuK3un56CPgbKXm8nFbMjpa2PlPoslQQuGwdCH4zamRTGNxrdFelKrRf0C0qjpp8L/G7TO5ey1LcDYuZnDhIsa5AY=
Received: from PH7PR10CA0024.namprd10.prod.outlook.com (2603:10b6:510:23d::13)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 31 May
 2024 16:52:39 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::d1) by PH7PR10CA0024.outlook.office365.com
 (2603:10b6:510:23d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 16:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:38 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:33 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 13/32] drm/amd/display: Add UCLK p-state support message to
 dcn401
Date: Fri, 31 May 2024 12:51:26 -0400
Message-ID: <20240531165145.1874966-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d630b1b-1b92-4d6c-ad5f-08dc8192146e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WD1qqy+n7ZUTFv75Dx2gcu16ld7asSCsMA42oMAzgI5ENW7570XyyTk8xMtN?=
 =?us-ascii?Q?7aDMPBBhc3rWO1RK7OIpf8fVBj0MryaP04i8qtzWLRbpi6f6HWMi2N9REFDl?=
 =?us-ascii?Q?T0sY3jV3U2jgHvxkCcZixIdDKOO6edPZAmSEFWphTOL5HKuLoqOoYFk4WiZw?=
 =?us-ascii?Q?FA/R/7RK3XrGNYk5HYKBaFn2UIV8tL6JaRfFC0Fm95G3DMLOPH4B+dGvXRDZ?=
 =?us-ascii?Q?5xxEEy9RdKayuxl9h/ZTf3Nl0xXE/FIgrp7/FAG304HmURqAnoBK5hLg2HkL?=
 =?us-ascii?Q?gEZi01N5ZNe+AfhGyJggmURynE7I2aB7VtmC4YED+M2BLJyPvsF1KL+4oCLC?=
 =?us-ascii?Q?Sznq5jeMyTnkzESB18y/YRfOjvFvzsy5I/+arIGwMHqt1fUKsjNymDXtma8h?=
 =?us-ascii?Q?GorFk0mkRnuaYl9rdQFbEC2Koa/bp3fgTku2ptnYPHq7JZv2etY85SMBAksN?=
 =?us-ascii?Q?QnSKotNPGTSu3lZw+7SHANrPeHvH399S63n3tVYSkqHDA5Fz7uENBz2FODvF?=
 =?us-ascii?Q?3LIXaCtPn0D7BeOQuzJK4zSTQUa1U7m62cInTxY3eLIIZJ7+CCi3i5zOTLh+?=
 =?us-ascii?Q?c6q1arXxsJ149fO+ZfKSzzbNKv7blsvstDn2rgP+Q+S7/83gpFokmj3yv2k8?=
 =?us-ascii?Q?fj7xBi+6804kGWnqlsTmtSbQo3hTSxiMjoPYuxoWN1L4ZaGNgYy6KJ7H4E6u?=
 =?us-ascii?Q?85rzDEf6HnSwaU/T//JBfhjcvMS3OOUGE0NieWSkTe+g7QGZGsfQEfe/9ACf?=
 =?us-ascii?Q?pJhgcwtGlhwvDHoel10JGllxvI8TBVH3UJ25udggfx907z/njk/6r/pDYtWV?=
 =?us-ascii?Q?aWnU0K1GR1ELjbe09U6lkl1RdFhQzQqYd/zfINoI1ABiM3NR4OBupEm15iND?=
 =?us-ascii?Q?n0Cwv7qvLPgVQaRMSGbSwRiPY4LO20otDjhP3dzMMywmQ2AdRbPDYflj7M91?=
 =?us-ascii?Q?BrmxmeM8ti7nrPZn0ptXqbSR4rxRoHjDT2SrgpFGDzBR+EekJYGZPEA6HWMB?=
 =?us-ascii?Q?G4cReM92D7wOzfauXxVJLwYrQpjfBABozTFf/KR/tDzAA9EFqDGCSRYaJbL+?=
 =?us-ascii?Q?NXcdrFwPN5FORKziFNqz2DAraHHX1nrSZJGrxE3bVGoffKgFfBjc9tfN5G+v?=
 =?us-ascii?Q?hqdmnAyHkTEd5LFRgIlCUe0qa8MvmqEfv7PFQJSg5PdCj9aOxTXcKBDoh7XL?=
 =?us-ascii?Q?Ple1Bu+MgPgBj+DcPfpHqsC5L8ByOuw94vG2tMuwIZpoqrsN4/ZkX0JFCEz7?=
 =?us-ascii?Q?pVKTtSzavsRgbqiX5rtKmxae4AO/j6xWGA9J4ZNTVXd5zoJzQhBaN4VZIjfe?=
 =?us-ascii?Q?a7tTGZkEpr8rmCSoKQ5UDbMOe6SJm2yk9GvQu07dKXWClT3Cgce6aY/Eky4n?=
 =?us-ascii?Q?+xKHDnzW2dPziKALhtYR4qhJiubE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:38.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d630b1b-1b92-4d6c-ad5f-08dc8192146e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Improves on the SMU interface to explicitly declare P-State support.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 133 ++++++++++++------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   3 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |  14 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |   6 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   4 +
 5 files changed, 106 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index e3a3893a9cab..0975986f5989 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -467,10 +467,10 @@ static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
 		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
 			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
-			/* To enable FCLK P-state switching, send FCLK_PSTATE_SUPPORTED message to PMFW */
+			/* To enable FCLK P-state switching, send PSTATE_SUPPORTED message to PMFW */
 			if (clk_mgr_base->clks.fclk_p_state_change_support) {
 				/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
-				dcn401_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
+				dcn401_smu_send_fclk_pstate_message(clk_mgr, true);
 			}
 		}
 
@@ -506,7 +506,7 @@ static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
 
 
 		p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
-		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.prev_p_state_change_support)) {
 			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 			clk_mgr_base->clks.fw_based_mclk_switching = p_state_change_support && new_clocks->fw_based_mclk_switching;
 
@@ -525,7 +525,7 @@ static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
 				update_fclk &&
 				dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_FCLK)) {
 			/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
-			dcn401_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
+			dcn401_smu_send_fclk_pstate_message(clk_mgr, false);
 		}
 
 		/* Always update saved value, even if new value not set due to P-State switching unsupported */
@@ -678,7 +678,12 @@ static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 		case CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT:
 			dcn401_smu_send_fclk_pstate_message(
 					clk_mgr_internal,
-					params->update_fclk_pstate_support_params.support);
+					params->update_pstate_support_params.support);
+			break;
+		case CLK_MGR401_UPDATE_UCLK_PSTATE_SUPPORT:
+			dcn401_smu_send_uclk_pstate_message(
+					clk_mgr_internal,
+					params->update_pstate_support_params.support);
 			break;
 		case CLK_MGR401_UPDATE_CAB_FOR_UCLK:
 			dcn401_smu_send_cab_for_uclk_message(
@@ -773,16 +778,16 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	/* CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT */
 	clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
 	fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
-	if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+	if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
 		clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 		update_active_fclk = true;
 		update_idle_fclk = true;
 
-		/* To enable FCLK P-state switching, send FCLK_PSTATE_SUPPORTED message to PMFW */
+		/* To enable FCLK P-state switching, send PSTATE_SUPPORTED message to PMFW */
 		if (clk_mgr_base->clks.fclk_p_state_change_support) {
 			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
 			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
-				block_sequence[num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_SUPPORTED;
+				block_sequence[num_steps].params.update_pstate_support_params.support = true;
 				block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
 				num_steps++;
 			}
@@ -825,12 +830,26 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		/* We don't actually care about socclk, don't notify SMU of hard min */
 		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 
+	/* UCLK */
+	if (new_clocks->fw_based_mclk_switching != clk_mgr_base->clks.fw_based_mclk_switching &&
+			new_clocks->fw_based_mclk_switching) {
+		/* enable FAMS features */
+		clk_mgr_base->clks.fw_based_mclk_switching = new_clocks->fw_based_mclk_switching;
+
+		block_sequence[num_steps].params.update_wait_for_dmub_ack_params.enable = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK;
+		num_steps++;
+
+		block_sequence[num_steps].params.indicate_drr_status_params.mod_drr_for_pstate = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[num_steps].func = CLK_MGR401_INDICATE_DRR_STATUS;
+		num_steps++;
+	}
+
 	/* CLK_MGR401_UPDATE_CAB_FOR_UCLK */
-	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
 	clk_mgr_base->clks.prev_num_ways = clk_mgr_base->clks.num_ways;
-
 	if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
 			clk_mgr_base->clks.num_ways < new_clocks->num_ways) {
+		/* increase num ways for subvp */
 		clk_mgr_base->clks.num_ways = new_clocks->num_ways;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
 			block_sequence[num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
@@ -839,15 +858,22 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		}
 	}
 
-	/* UCLK */
+	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
 	uclk_p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
-	if (should_update_pstate_support(safe_to_lower, uclk_p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+	if (should_update_pstate_support(safe_to_lower, uclk_p_state_change_support, clk_mgr_base->clks.prev_p_state_change_support)) {
 		clk_mgr_base->clks.p_state_change_support = uclk_p_state_change_support;
 		update_active_uclk = true;
 		update_idle_uclk = true;
 
-		/* to disable P-State switching, set UCLK min = max */
-		if (!clk_mgr_base->clks.p_state_change_support) {
+		if (clk_mgr_base->clks.p_state_change_support) {
+			/* enable UCLK switching  */
+			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
+				block_sequence[num_steps].params.update_pstate_support_params.support = true;
+				block_sequence[num_steps].func = CLK_MGR401_UPDATE_UCLK_PSTATE_SUPPORT;
+				num_steps++;
+			}
+		} else {
+			/* when disabling P-State switching, set UCLK min = max */
 			if (dc->clk_mgr->dc_mode_softmax_enabled) {
 				/* will never have the functional UCLK min above the softmax
 				* since we calculate mode support based on softmax being the max UCLK
@@ -870,6 +896,7 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 			active_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz);
 		}
 	}
+
 	if (should_set_clock(safe_to_lower, new_clocks->idle_dramclk_khz, clk_mgr_base->clks.idle_dramclk_khz)) {
 		clk_mgr_base->clks.idle_dramclk_khz = new_clocks->idle_dramclk_khz;
 
@@ -879,17 +906,6 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		}
 	}
 
-	/* set UCLK to requested value */
-	if ((update_active_uclk || update_idle_uclk) &&
-			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
-			!is_idle_dpm_enabled) {
-		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_UCLK;
-		block_sequence[num_steps].params.update_hardmin_params.freq_mhz = active_uclk_mhz;
-		block_sequence[num_steps].params.update_hardmin_params.response = NULL;
-		block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
-		num_steps++;
-	}
-
 	/* FCLK */
 	/* Always update saved value, even if new value not set due to P-State switching unsupported */
 	if (should_set_clock(safe_to_lower, new_clocks->fclk_khz, clk_mgr_base->clks.fclk_khz)) {
@@ -927,41 +943,66 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		num_steps++;
 	}
 
-	/* CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK, CLK_MGR401_INDICATE_DRR_STATUS*/
-	if (clk_mgr_base->clks.fw_based_mclk_switching != new_clocks->fw_based_mclk_switching) {
-		clk_mgr_base->clks.fw_based_mclk_switching = new_clocks->fw_based_mclk_switching;
-
-		block_sequence[num_steps].params.update_wait_for_dmub_ack_params.enable = clk_mgr_base->clks.fw_based_mclk_switching;
-		block_sequence[num_steps].func = CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK;
-		num_steps++;
+	/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
+	if (update_active_uclk || update_idle_uclk) {
+		if (!is_idle_dpm_enabled) {
+			block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_UCLK;
+			block_sequence[num_steps].params.update_hardmin_params.freq_mhz = active_uclk_mhz;
+			block_sequence[num_steps].params.update_hardmin_params.response = NULL;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+			num_steps++;
+		}
 
-		block_sequence[num_steps].params.indicate_drr_status_params.mod_drr_for_pstate = clk_mgr_base->clks.fw_based_mclk_switching;
-		block_sequence[num_steps].func = CLK_MGR401_INDICATE_DRR_STATUS;
-		num_steps++;
+		/* disable UCLK P-State support if needed */
+		if (!uclk_p_state_change_support &&
+				should_update_pstate_support(safe_to_lower, uclk_p_state_change_support, clk_mgr_base->clks.prev_p_state_change_support) &&
+				dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
+			block_sequence[num_steps].params.update_pstate_support_params.support = false;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_UCLK_PSTATE_SUPPORT;
+			num_steps++;
+		}
 	}
 
 	/* set FCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
-	if ((update_active_fclk || update_idle_fclk)) {
+	if (update_active_fclk || update_idle_fclk) {
+		/* No need to send active FCLK hardmin, automatically set based on DCFCLK */
+		// if (!is_idle_dpm_enabled) {
+		// 	block_sequence[*num_steps].update_hardmin_params.clk_mgr = clk_mgr;
+		// 	block_sequence[*num_steps].update_hardmin_params.ppclk = PPCLK_FCLK;
+		// 	block_sequence[*num_steps].update_hardmin_params.freq_mhz = active_fclk_mhz;
+		// 	block_sequence[*num_steps].update_hardmin_params.response = NULL;
+		// 	block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+		// 	(*num_steps)++;
+		// }
+
 		/* disable FCLK P-State support if needed */
-		if (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support &&
+		if (!fclk_p_state_change_support &&
+				should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_prev_p_state_change_support) &&
 				dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
-			block_sequence[num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_NOTSUPPORTED;
+			block_sequence[num_steps].params.update_pstate_support_params.support = false;
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
 			num_steps++;
 		}
+	}
 
-		/* No need to send active FCLK hardmin, automatically set based on DCFCLK */
-		// block_sequence[*num_steps].update_hardmin_params.clk_mgr = clk_mgr;
-		// block_sequence[*num_steps].update_hardmin_params.ppclk = PPCLK_FCLK;
-		// block_sequence[*num_steps].update_hardmin_params.freq_mhz = active_fclk_mhz;
-		// block_sequence[*num_steps].update_hardmin_params.response = NULL;
-		// block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
-		// (*num_steps)++;
+	if (new_clocks->fw_based_mclk_switching != clk_mgr_base->clks.fw_based_mclk_switching &&
+			safe_to_lower && !new_clocks->fw_based_mclk_switching) {
+		/* disable FAMS features */
+		clk_mgr_base->clks.fw_based_mclk_switching = new_clocks->fw_based_mclk_switching;
+
+		block_sequence[num_steps].params.update_wait_for_dmub_ack_params.enable = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK;
+		num_steps++;
+
+		block_sequence[num_steps].params.indicate_drr_status_params.mod_drr_for_pstate = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[num_steps].func = CLK_MGR401_INDICATE_DRR_STATUS;
+		num_steps++;
 	}
 
 	/* CLK_MGR401_UPDATE_CAB_FOR_UCLK */
 	if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
-			clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
+			safe_to_lower && clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
+		/* decrease num ways for subvp */
 		clk_mgr_base->clks.num_ways = new_clocks->num_ways;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
 			block_sequence[num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 8860b35279d3..8b0461992b22 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -38,7 +38,7 @@ union dcn401_clk_mgr_block_sequence_params {
 	struct {
 		/* inputs */
 		bool support;
-	} update_fclk_pstate_support_params;
+	} update_pstate_support_params;
 	struct {
 		/* inputs */
 		unsigned int num_ways;
@@ -82,6 +82,7 @@ enum dcn401_clk_mgr_block_sequence_func {
 	CLK_MGR401_UPDATE_IDLE_HARDMINS,
 	CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK,
 	CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT,
+	CLK_MGR401_UPDATE_UCLK_PSTATE_SUPPORT,
 	CLK_MGR401_UPDATE_CAB_FOR_UCLK,
 	CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK,
 	CLK_MGR401_INDICATE_DRR_STATUS,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index 84e9203aba3b..7700477d019b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -131,12 +131,20 @@ static bool dcn401_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mg
 	return false;
 }
 
-void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable)
+void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support)
 {
-	smu_print("FCLK P-state support value is : %d\n", enable);
+	smu_print("FCLK P-state support value is : %d\n", support);
 
 	dcn401_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_SetFclkSwitchAllow, enable ? FCLK_PSTATE_SUPPORTED : FCLK_PSTATE_NOTSUPPORTED, NULL);
+			DALSMC_MSG_SetFclkSwitchAllow, support, NULL);
+}
+
+void dcn401_smu_send_uclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support)
+{
+	smu_print("UCLK P-state support value is : %d\n", support);
+
+	dcn401_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_SetUclkPstateAllow, support, NULL);
 }
 
 void dcn401_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
index 892881d11ce8..651fb8d62864 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
@@ -9,10 +9,8 @@
 #include "core_types.h"
 #include "dcn32/dcn32_clk_mgr_smu_msg.h"
 
-#define FCLK_PSTATE_NOTSUPPORTED       0x00
-#define FCLK_PSTATE_SUPPORTED          0x01
-
-void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable);
+void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support);
+void dcn401_smu_send_uclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support);
 void dcn401_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
 void dcn401_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn401_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 022d320be1d5..ab9df1cc1d3c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1978,6 +1978,10 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
 {
 	uint32_t cache_lines_used, lines_per_way, total_cache_lines, num_ways;
 
+	if (total_size_in_mall_bytes == 0) {
+		return 0;
+	}
+
 	/* add 2 lines for worst case alignment */
 	cache_lines_used = total_size_in_mall_bytes / dc->caps.cache_line_size + 2;
 
-- 
2.34.1

