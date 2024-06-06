Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0D1C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0109410EAE6;
	Thu,  6 Jun 2024 21:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ak1b+ue2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E777210EAE2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+doG3qfwpvM3h2BGQr68S+hluTkR+qGr/Z7TRsyXCiG5ANTwjYG/TB1asMGHVCC0X8vmgImFLOU2Z3gfsY3RdcRaNiIxGeOIkGEpWznp1IqSzvcO1Ny5JFoJ+HTou/CkSN71ujb2M8NEui9DV48pU6ShCE4Tz+wnA42dPvp+KOXWYWlKnIokPxJsgVapsZXxkCzbtvVjcepilC8o/OIj4/zNSO+R/wHoknekINVJKQjhZkX5ID9GMolO1WFhXtUZJvml40f5GR7QyRPr9iOR0PIrkK6EBAIFP+rjZRGWwK+H9rPDJht4HBvYCFaHNGbZ0qaMfRcQPVFH9VSrv856g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do1xgO4aCv2MPJhOPRB/hKaQRuNo47tcGvvwO8YzGn4=;
 b=WSWzUo1GOuIsMWWvs5zzlX/zXePB067OiMzEJWUT0zqXjuzFjKZfc/uzWT0APJNte8aoyWSb6OZz9biNiG/g5b00HxO8i0fgYtGCIvcpNlKbBrCZMnuAit/xvdKnoNy7vf6d1lra8yHkEvaZOYLZpDSHC3cw0r+TmsBUq0Mz/+a27TrDrWCyy+TBUgGIsshG2P5hLt3ZgbjOR46enBzRQiin+l162GKTAxQX/HhCr6HXtzZwqyf4xtgJDBlJp8tjTI1cogpeLVCh/FhjcQvDKhyje3SVSoA3TT7IVbNDri1B9H1qeF5kKSg/kZx97gPQNEAdOxoDsvYZ91Sb1KVfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do1xgO4aCv2MPJhOPRB/hKaQRuNo47tcGvvwO8YzGn4=;
 b=Ak1b+ue2MUhJM94zhKvEZ25U+10nEb/OrC3XKvrMpQp9qPiznldjM6HzPdbcNz4defXo80FUIgI0dHGKLPLzwze5TkyqJzOlhfBV7Q37WFT8kjxNLL+0ZsR+hNRDToCizpgkHEWroPewOWXzkWa9Y3/lIV2s1ot+0DmwAxburPU=
Received: from BL1PR13CA0243.namprd13.prod.outlook.com (2603:10b6:208:2ba::8)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:57:37 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7) by BL1PR13CA0243.outlook.office365.com
 (2603:10b6:208:2ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.11 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:37 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:35 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 25/67] drm/amd/display: Remove duplicate 'update_idle_uclk' in
 dcn401 clk_mgr code
Date: Thu, 6 Jun 2024 17:55:50 -0400
Message-ID: <20240606215632.4061204-26-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f226ca5-5553-4df4-122f-08dc8673ada7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MdfwVPpt3prM9XTNh2AZpfUmCOxO9VerSB1/NleE4psrGAB8lSyztFq3bvoW?=
 =?us-ascii?Q?6YFcmcruj0TaQu9oBTJOM5I/+p5VdpDMBFWJubyAPiPcDPO/HEl/yXU+A33K?=
 =?us-ascii?Q?IoMZdpFrXsTG/4J+XmtIJfhm6TlN5u3IVLi7zpyCUj+tyH9Gan2AYIZOEiqq?=
 =?us-ascii?Q?KQNZh8G+i+y8YoVdZGL8p5Sv+PD6N2/xBufRXEhqukkSxYaI7qS9KGRlOYu9?=
 =?us-ascii?Q?+OQC9N7kYgvLhUbQUkU5LwF6m8ceLdFVTglQpuBDyME2qdbBkYtA/WlB6bES?=
 =?us-ascii?Q?iIo8M0UIu1qU/efm+Xsn6C4DNnif8LbIudjIz89fxff8dA42OZRxywK/cDbd?=
 =?us-ascii?Q?khGw2pZr4oI94siA8fNV3lTU247arUXNhcDaTr3HYkZjUPZT9ETEypAVHsV2?=
 =?us-ascii?Q?0N2TVFnuOyoXwQMO1vjCkZTJ75QPkYapQaTpVR7aZCtT8bY7PIRHhRYD/uDu?=
 =?us-ascii?Q?Hs7thlWyVEcEnKCttAjoVFqdYsCDxpkWSba26OwB2e4SDGETcRyHkqBNaFHS?=
 =?us-ascii?Q?vsqO5ROYZfrwPQtPRMKdQ3e4nH1eITpupNrV1Zzd4/jGfjcm+Kk0pbnDzbFM?=
 =?us-ascii?Q?P4qJ8bh33FbT7CB1a8sDMBBUK+0laF0Q8n6+RvwVMg+pZhzqTFLlKXdoQ/3i?=
 =?us-ascii?Q?XGwuQz3RcrGaMiHTK00bpzaAbRBxta+yac71+CS0tjbVn5B47xhchCJYZOmx?=
 =?us-ascii?Q?hvU2wkO+1k+30ARaRsXD4cy2Ed+RcNu8CylTEGQ2t8jeBtdej/oe3gAqo6dG?=
 =?us-ascii?Q?s/QNKosj+IQeSq4JGtNNB7237XFzhwhRQA0UHha+ZwyWlCtT9HjSfZORrfOL?=
 =?us-ascii?Q?CZRBZABIb7kL9juqZ0jqLshJMg7MWqcWiK5pqDD/STOZgVFW5NxbZU/bsMqF?=
 =?us-ascii?Q?jyr22pxfLJiWIIxfh8Cz8Q6bcPQE4DGoRnpDh0J0VPIVEEOQ2kt/we86ujOH?=
 =?us-ascii?Q?x8OM3yTk3zrsfQpD1CG9WckGVyi7q1N9cKuWuvOwakVhhiTiQ3kJi3pfHyx4?=
 =?us-ascii?Q?Js5/pomiuZ0j8JRxdrlYaF+n13YoVnWLRspdq+ghPOOrbZ+esFcDs8dAJgKC?=
 =?us-ascii?Q?9XauPFLXu/JQdRl97UmLBBRksU7xXN9XdaJVhFu1N55XREBupMFY2A5G3iID?=
 =?us-ascii?Q?9Bug4EezPxFtlc1IKIw0eFrd5fc5ugSVqmvjuupbdBXAHcoGDv0L/+avnZ3h?=
 =?us-ascii?Q?wCf/J6mmXkrKerpl3Zv2nclvp2fwYVOwISZJmqSQTF5a7i/288c1D60hEagQ?=
 =?us-ascii?Q?y8pLCsKZlQV0O9E4hU39kGA4VGZvsD0MAHtkmdYX++rTHhTmPPnVIFpVhH6X?=
 =?us-ascii?Q?dNGZnEvnkEYLaKsXvA4+ODqyLHDcBh3w2g6iryZbXyNz047saMrdqgWdTqT7?=
 =?us-ascii?Q?4ldxg6+6Mshtjyl4OSuD0J5jynxh8sVewyfWFLLMbKQbHl+/4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:37.1755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f226ca5-5553-4df4-122f-08dc8673ada7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
The coverity analysis flagged this if expression as it contains a
'CONSTANT_EXPRESSION_RESULT': 'update_idle_uclk' is 'ORd' with itself.

[HOW]
Remove the duplicate 'update_idle_uclk'.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 0fbe615069f0..28769deaad37 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -940,7 +940,7 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	}
 
 	/* CLK_MGR401_UPDATE_IDLE_HARDMINS */
-	if ((update_idle_uclk || update_idle_uclk) && is_idle_dpm_enabled) {
+	if (update_idle_uclk && is_idle_dpm_enabled) {
 		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = idle_uclk_mhz;
 		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = idle_fclk_mhz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_IDLE_HARDMINS;
-- 
2.34.1

