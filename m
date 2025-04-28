Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969D6C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD4F10E56B;
	Mon, 28 Apr 2025 13:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YueFHIBR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F51110E56B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l14uHUoFLNp9m6xoqFH4vgEn6V2ReY8rL2J/CiRE9MX/NCheQGSZ1H0lW9g9/x9WI8irgJlz37kN3z3xXUg6Rz7NGC5C3UW2N5sIVCFcMJ/xuwrXm8DxTQUawjmP3V0vsoJT5J3FWlWK3M6dFLfbwWO/U+06YuZdm402w6pdhTkqUz9CteiqW/pDtGZ2m7NLaHcqMfGbC84ylvu+6jpJyQjkFjoada7FqKnztlq2t1KD268wX/vqzod1H2X1BL4Y/vyxMfXudwZbZ7Kp1yNO+7SRNLQso2ITmO8d04bSWUFSpFPJs4DVHH6pR4LT92Wn5um8bcYVb3PZpYU3qj6e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHG0IgVN5KbqUfsKxNB7Z75l3Y1NsmSrehEfOsfrfQ4=;
 b=ZYzV/nk3zol44wPBmykpNIZmfLL2AW8GY9ZTyD77C6xwpbWoXcaPboMo79WE9Ax6GMOq5pUOoljwPsVwBS+I+3tIW5EUKVbdDKLMiBFpHhD6R22z+4JYl8M9N9avS1n79oNoSVSLePJSb85C6NPkLoHNWUUQAqqheEcMTuO9/2KfEdqnWPHZHKCyKP06H0h1tPWjOvpWcoRXrA+07XDhNcJhrOS7/ADfMprvjuaLgfgjxuUmYZL3D6y4ud1hZgS+hPn6uqISRE/dhxKh+nH5OvoHlcC62idiDPw2U1AMR9vaH9NSUxVPm3UPq/sRJEp7bQ2oUT8+GsxHq6zwQczqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHG0IgVN5KbqUfsKxNB7Z75l3Y1NsmSrehEfOsfrfQ4=;
 b=YueFHIBRyMlFtgaUzE12pyRq5Wwx3jJZfqcrFQ5kRLOLjyebHeMNuLOsrj+TdHVf6EJuV63WU50ewi1jkOd7UbGIshtQVcn7rdIR23A3Lr1D1L9GK89O8rmIe4jFvTcY/mOW9TEtTJcIvkibbmcYZi3bhYGA3CAIYnGdvGKnYHo=
Received: from CH0PR03CA0433.namprd03.prod.outlook.com (2603:10b6:610:10e::18)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:56:52 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::45) by CH0PR03CA0433.outlook.office365.com
 (2603:10b6:610:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 13:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:51 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:48 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, JinZe Xu
 <JinZe.Xu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 17/28] drm/amd/display: Send IPSExit unconditionally.
Date: Mon, 28 Apr 2025 21:50:47 +0800
Message-ID: <20250428135514.20775-18-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbb4a6a-9a87-45f0-0e85-08dd865c8799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KldBDlLPMxvhMecjwjNZnp7GQmVNagIo1gYhQzaK/2pIOaKCPb7GpkQNUHa0?=
 =?us-ascii?Q?G8cJABfujgQQuo++t6p1Jv3ULsVfVvT2c5LvxRTOdXBeN31ie1z7SIfrfAHY?=
 =?us-ascii?Q?/2dqUD6SqNHJglGwk5rndPtgXOnBsrzaSvsEuvbB7eh4bTgx2+l8PagShvz9?=
 =?us-ascii?Q?mXJSVG8nWtAZHhvqVX0Bd/qhIBZ7CHScWhb0b1/h1m4AwKGxYll3kN5sNZci?=
 =?us-ascii?Q?6ENj005koYUtYP/wiiBaOj0QCtz49f9smCg45aiN/Sq3tfnRH22Cqu9zWIXm?=
 =?us-ascii?Q?9WiIrnPMqJHekkG56c+uiW9iZ1HnA6l3AWK8mu47MTMt0fM8mZhhb2ApfOcv?=
 =?us-ascii?Q?Fh8zJuT/fHrTNc0QS+9V1D3aBoMzKsu7c+X4ygc/qey/vm0KUcDtIzAzkFBw?=
 =?us-ascii?Q?jHcca6xXMYHrh/9BxMHwZGiim/tX4L06I3kz0JC7D8hpCFmjbTc/BpZxgYLT?=
 =?us-ascii?Q?A9X1QFmrsSU/1GYJ4Ujx58tVOIn2KG22/Hu5a+Zty17seBxl700JH37htERW?=
 =?us-ascii?Q?YNkWlp4Z+3P0v0EcdFdiAT3SzJbliGXGoeUNnCf0AhlcH5Rl93Ndf3tHsnh7?=
 =?us-ascii?Q?ucUgSSN5SMW5qU5cspjs48n3ZJzwYyf/O4FKnmdGyWmwE4lkdhC+VeDIFZxm?=
 =?us-ascii?Q?ZO61yMRNpIYJMmc44mYlsdCy/Cyq5KWGZhiDP8MZC2iwWajWC79bM1cFR1sv?=
 =?us-ascii?Q?WdGnZlwBTTv77g4I3jYvEtdtlwwXrjHF6iySQmusODEm5wlYmnbh0beTmssA?=
 =?us-ascii?Q?J7puIH/gkOH9Wap9vtU7rCYq0H+ja5UqIqhuniFLOkqoI3/gZvVxZchxLl6y?=
 =?us-ascii?Q?bawjngz3lFxHedLm5dNdhpkKQobvAU0w1MrL6OeKDcVdgJNTaJsKWCtpOvx+?=
 =?us-ascii?Q?4OrSyF47TZzNlIT1P/Z6EjReLCX9ds6Ma3YR/fqUx9pOmSuZ8t4fGcAgdIi4?=
 =?us-ascii?Q?FDkcDbsyi/0+mEkKgb/yq45xzdBTCiyA9hWHNsSomZg6oCOlISOVfnffAkhd?=
 =?us-ascii?Q?wR7ochgtnDsXSYjzTRtrwkAZvUipFZhwxWrL6VHHCLrdTO+Gny1B6rb/WDsU?=
 =?us-ascii?Q?iy7UXgkj5G0dhZIw/TaCFGvoKPW6GP/WuSd0S4UGbG5tQ7kCeoRsWxRbYXND?=
 =?us-ascii?Q?sg6w51ObxjNcbW2baHDT+Ork7yJ4s3dAaa923kLtIbdcSq4SFbXocKg6rgrX?=
 =?us-ascii?Q?gy594KsgIzHzRR5gA0ETTBQtgujB5GZ9nMcrxZxOVW1QO1LT2FDIkxGzwe5b?=
 =?us-ascii?Q?3fea/CFRJuIYtJ46XxN5wCkluERfmC15UcQawte+poex7hdtkNf1BvGskZHr?=
 =?us-ascii?Q?IsRNFOsILWEo47fRlPoSCNBCQ/pYJ2Qagyvb7GA6090HFCwVBQmB5JejW3X2?=
 =?us-ascii?Q?XwesHPn5Y4Ds1Q2AydN0PLOSZkjAIboOUiNf3E6uLJ1NpmbJvFwzpFCO6OPR?=
 =?us-ascii?Q?SuSCjByU2ZZbMPj6Yi0YPt30hKGj5LAi4ZavPJqn2REgFhsmM5UChQ78HGVV?=
 =?us-ascii?Q?R4HI5wZCPv8p9iNmiZ5SJIKmNqqPLvgS0SQ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:52.5910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbb4a6a-9a87-45f0-0e85-08dd865c8799
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

From: JinZe Xu <JinZe.Xu@amd.com>

[Why&How]
PMFW needs to flush page cache in IPSExit.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: JinZe Xu <JinZe.Xu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ca6da53f45ad..a3fbb9f5b4a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1365,14 +1365,15 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 			if (!dc->debug.optimize_ips_handshake || !ips_fw->signals.bits.ips2_commit)
 				udelay(dc->debug.ips2_eval_delay_us);
 
-			if (ips_fw->signals.bits.ips2_commit) {
-				DC_LOG_IPS(
-					"exit IPS2 #1 (ips1_commit=%u ips2_commit=%u)",
-					ips_fw->signals.bits.ips1_commit,
-					ips_fw->signals.bits.ips2_commit);
+			DC_LOG_IPS(
+				"exit IPS2 #1 (ips1_commit=%u ips2_commit=%u)",
+				ips_fw->signals.bits.ips1_commit,
+				ips_fw->signals.bits.ips2_commit);
 
-				// Tell PMFW to exit low power state
-				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+			// Tell PMFW to exit low power state
+			dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+			if (ips_fw->signals.bits.ips2_commit) {
 
 				DC_LOG_IPS(
 					"wait IPS2 entry delay (ips1_commit=%u ips2_commit=%u)",
-- 
2.43.0

