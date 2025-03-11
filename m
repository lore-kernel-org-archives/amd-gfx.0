Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9C8C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22AED10E698;
	Tue, 11 Mar 2025 21:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vTnQhc+L";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C3E10E698
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAMOzeu1UxSG3CfOle6JWpVvHNCfP1QK+J06k03undNSBwxLYUfHBQTeFfoGPUe67XdqDxj+foOshhS1jndwot5sSi41IjEMoIy+Y0+XMxWXw3qLY6cr/kAzXwGhAeHO9EIr00ng1M4CT162jXpSVLBRBR8bo61s0/eryam1GniRoQONOoTJGRWQ52kC1F9b/l+1OxxBUjAxabQJ2/SGrfCOjgLdPqKNG1yoSj7chl3b8ncPYdmfQOZmcv7lP8qf05h/Gtm84/o39rbnHa6ElOBRK2yhrfgEmeDRKaLT+S8d9IdzM3CDfmJy+omubOxHY7nH7UwRGgWcgOwmBZshxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+Mwr2xY76l+BnIUP5YFwWMx88EqftH0/UxD/+Uh0xw=;
 b=RZF0Bebcf1yINC4Ex8cdAKPgAUXfyNcVcYdqnhw1QdxWvazd06nFY2K4Rg0WCkBus/x6giwrdCKzdNQgJjlSqb1higYgLBOH52otGrWi20BaFd7xjEbbJqcxV5d5dmwS3lgUmu1FLku4bSe1I/4yh9y+1ufJQjBbnatChVKzWTBrhoNZZYeTPgddhSRhuSJDFUZLbv4LzMn2CFpl2FvVOaKeI2A04ttXd7pmASPwNvez4VW+qcqFTukwFtAjL2daDWGIZvvPSfKEp6nibKT2EgXuaPKnD2dFssy2rvS2Vhw3gn6Gqup5lGCeSQJKgDIGSK6jF99QOJd3W3CtJX2UGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+Mwr2xY76l+BnIUP5YFwWMx88EqftH0/UxD/+Uh0xw=;
 b=vTnQhc+LEQdc4bJwygPRHkisUf7VLWymMlTllP72ElWvD4uqGjesmb9h0Xr0N3KwinvtyoeCBmsIewMXqtErc4wAdOF0Hf7MBs4uGd6ll6fwrjX0ondRKpEUWLq8xgdosO5azJbM8OH7TxqJxqjghNT5htSJZxFnchoNSIkJUVc=
Received: from MN2PR20CA0060.namprd20.prod.outlook.com (2603:10b6:208:235::29)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:51:09 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::a5) by MN2PR20CA0060.outlook.office365.com
 (2603:10b6:208:235::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:51:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:51:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 10/11] drm/amd/display: Use DPM table clk setting for dml2 soc
 dscclk
Date: Tue, 11 Mar 2025 15:42:11 -0600
Message-ID: <20250311214618.3106637-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 926f5dab-0309-4e13-e858-08dd60e6d51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7xx9v66HOaWz3+obKeodZYvqR8zZAdGOZOOy+4tJR6Isyl1u3cCJi0Lo5iim?=
 =?us-ascii?Q?di05suLB7dspHNeqIfnjiIy0g1X+FSYLHDtFTUlyaK8MIWllPrbL7XaTGDqV?=
 =?us-ascii?Q?5MDa2bCViQEE5LzH8HTvLoK+sdmrjtsEXrAG+MHHIUp94Id5TRnHnR+HzWUZ?=
 =?us-ascii?Q?fux1IL8AwUlNRvFaWS533EePhG522AykTEVM6pfIW2W9EWdfEehJHzO58BU8?=
 =?us-ascii?Q?yi3IBMQsZNePZijRN1tLaGO6KfOev4xWVhZEzpDNikHLcL1NeiRk0xtIszXM?=
 =?us-ascii?Q?pjR5SvXO9s2QM9JOul1QpYLVx/5TiKcMCmVcf9WpiHMYSUBHRmoseA8VShct?=
 =?us-ascii?Q?3p897EjG9PgHkqRdmGdU+vupMWnHvClPk+JIZDPVZzBmGHdLNQVmX+MGBo7I?=
 =?us-ascii?Q?uA/nZNmrOBreMTwHQvnCLt6ABa3f8TfvWhiL1zsblZ9mjngJiCE6BGDmR7P8?=
 =?us-ascii?Q?auxflzi7jKHm17Mlfw5Ftrbal0ryazmURQ9h0KNxsspfhantK0JsJDcDsiLp?=
 =?us-ascii?Q?mdZmozgLsCfAkeqAlwgveRpuKurpTxRAeTofMa+z5XBWtOkdNVVqSzI+yOTR?=
 =?us-ascii?Q?5SeJv8SjfqZBD2w/tuu4IVdMu6YQWexuvZMpP+Yo71Sr8OcAK/5U2E1U0W7N?=
 =?us-ascii?Q?hXEbWduhE97byWyypvLlIxn4UkYFqDWPOKWa/sOh3IHqndz1R2OYIrRVb0x3?=
 =?us-ascii?Q?Bzin5/AuslxqiO8TIUOV7BkH7eAeqMHG7SNIdcbXtBD3Oxgt1r+3ltMfrH8i?=
 =?us-ascii?Q?JxXOVqrW5llPkKciQorvDg+1kGPmX9BemrejphvHm2RY5HbpZZ7pYqARC2FO?=
 =?us-ascii?Q?adaAwyk+4BRiAXkrenR9s7uw2HEITpRb7t5Ho6F5XKWMcHRn842JoYxSXQZi?=
 =?us-ascii?Q?LHybsdLKI+lyLP7XlJfRP6macaTDmS3MpHy4xC4QDPUMfdgGyUqytX5hWdw/?=
 =?us-ascii?Q?6P2JbzctWJAjbEWZ+FLuDlsc8TArmzv8G+CgaA4tiLwVujyMrop7Qb+qjPRX?=
 =?us-ascii?Q?ce/sU9u2Jh5BZytxhBEWhECV9Y8ZFHriDfpytgg01KQlxIXyi+ggxKpQTifx?=
 =?us-ascii?Q?OWATlT6IK9eDmZnGPGgJ3T5Ooho6ObXdRcoFGbfC6a8jhKYlEtnTB8VNqwTU?=
 =?us-ascii?Q?OM5Q1TYb3jiKU9nSuKJCvoKqacHAfwjkXTxRpRCPVUfd7LU/igrpvcyHSb/f?=
 =?us-ascii?Q?yge/SeGwZysN1kq2KQ5DZmXg8+VmDEAjE/tkDlTlTx+lhrzkvzjSvG9g9shr?=
 =?us-ascii?Q?j801UYyM69NRqgGzauCCzIYV/ui/hI7/salpT4iQzByVvmKqYRwrx5XBtCjR?=
 =?us-ascii?Q?QW6Aon2jCQ15MAh/fClR+wfn/hYNR23Mwc/TiZCG0pgy6Up+kNya+6CZJ3Wa?=
 =?us-ascii?Q?37lTvWDRT4c0mwkubL2t1tlR912SxfS21JClioGe7Q+we5Dt5tjsXLJRFZHs?=
 =?us-ascii?Q?wJRpNaiJH7SqilVx+yNs/8JjiawfgbRvnYQix3j9R43lqpT9wnw4lKB2h/K9?=
 =?us-ascii?Q?24PA3tvWKpEzqHU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:51:09.0326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926f5dab-0309-4e13-e858-08dd60e6d51e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
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

From: Charlene Liu <Charlene.Liu@amd.com>

[WHY]
Not like dppclk/dispclk, dml2 will calculate the minimum required clocks.
For dscclk, it is used for pure comparision.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2061d43b92e1..70c39df62533 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -590,11 +590,11 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
 			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
 
-			p->out_states->state_array[i].dscclk_mhz = max_dispclk_mhz / 3.0;
 			p->out_states->state_array[i].phyclk_mhz = max_phyclk_mhz;
 			p->out_states->state_array[i].dtbclk_mhz = max_dtbclk_mhz;
 
 			/* Dependent states. */
+			p->out_states->state_array[i].dscclk_mhz = p->in_states->state_array[i].dscclk_mhz;
 			p->out_states->state_array[i].dram_speed_mts = p->in_states->state_array[i].dram_speed_mts;
 			p->out_states->state_array[i].fabricclk_mhz = p->in_states->state_array[i].fabricclk_mhz;
 			p->out_states->state_array[i].socclk_mhz = p->in_states->state_array[i].socclk_mhz;
-- 
2.43.0

