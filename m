Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C2DC0218B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0C010E635;
	Tue, 21 Jan 2025 19:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1n782g5i";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564BF10E639
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfh0hoIxXPeY8GNRHfrrk/TXvUXo9T3t/qrnS1ju8CePYa2DhbQS3jNlcsf4DFkWyIDbL6ue9wEplGNqPc7IGmph84wnQvtBVG2WO+eE/UaBZmfOtBzxcX7GbYEPV9GrXk0sj8tyF9HQW5gdPlypiheDtmlwP0aYRnV+kui+x+p4bQ02f/AIcc9ehF9omRQZAYNp3oFWfA/KTWiooO3aVpOGjXHAlV5LzPsf7KTOpLwWFFRJH0DBCUjIQZPGdK+42wFjYJ5sVHpcaM4/HAtGpI7QgtpxZ2VwHkqyrjw9f0pat2+ls8U25kwDFIVsg/K1e+Hn25vDrMFcB78eDVnN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvExHw5yRBH5o1e+33AP5cira7R3Z63W+cauEw021BI=;
 b=IOPfAWCO6L2yHcjccA0AEi5nRqHfFX6KoMA3EVtEqt8CWO6D1T5i5G1avjlV0P1ai7OTWAcA3D0xWOR2sMdmamem6vadVJGomv6OowbD5DKHm31ZFzqbTJSy60oc/5Dzop1ZRne3oxeeq3cn0nLFqOjZgqiTV8OR5FJ653SK9Ux0d/ZuTjf+W4+w+b5XtdUiXX4X162XXc2i+79gOsXVaNDUxC2M6RoPqZN+TdPAHjJnpWb6Bvh2AkM4ZP2Q6yrxKKjumxm+Vr+Li2W9OXG5N+ItfNPMViPzmzA1QPciIxxuLP7gFZ/6Ey6b1XpMrUyzcAWtUI0HS9sS45Gqvew2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvExHw5yRBH5o1e+33AP5cira7R3Z63W+cauEw021BI=;
 b=1n782g5ia8kdETIbrmNbvmPSgKZj6PN0gvosgjJFeoJwuquGVTANNVJ/+WCFjJvqPnL96rUe+D+eEu+Ba8WrXcs8yINgyLTBiD+XqaODDr++XMlFGx8wax88ErxTXZ6Gq301NfLxO4kQd0T/E/JIchZNLcauzgmZIP5cuobnSsY=
Received: from MN2PR22CA0027.namprd22.prod.outlook.com (2603:10b6:208:238::32)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 19:40:07 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::25) by MN2PR22CA0027.outlook.office365.com
 (2603:10b6:208:238::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:06 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:04 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, loanchen
 <lo-an.chen@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 07/14] drm/amd/display: Correct register address in dcn35
Date: Tue, 21 Jan 2025 14:39:12 -0500
Message-ID: <20250121193919.3342348-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: afc65798-ef3a-4aaa-4fc3-08dd3a5368c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SVHuprkYBLG5Kp7CdvXMkQaTZcQpUiN6kR42y25w+/DY9c/XTACWvqGB/4F4?=
 =?us-ascii?Q?224ZPFoQjNhCM9NYh94P+kl9Ep/zuWa9wzt5/GeTxjLmiTbC7ltEHF/rmbfe?=
 =?us-ascii?Q?ZDTx2L2nzVKTcadsjv9PMYVrgfOPKbck4ykBDyswfVv5z3WO85Sti1DzKpb+?=
 =?us-ascii?Q?bGTaqqRxYyb9uzJ+TnXserIW7cYGQAjjeatLYg/rGuzSx5vdNbelpeqcAHzM?=
 =?us-ascii?Q?J9gwUNYrZcmb4Xk1lGjWJ3aiuperNs7GKuTiWQwjN1Eo+lm+4+TDvz2sQIEN?=
 =?us-ascii?Q?bFVuW4MlbbKK8xq7tJDCP52R0EUT8qNku32chWRbXuYR1NHEjkEBjPKKiolP?=
 =?us-ascii?Q?E43fENuSb6w2s/RtQOZ9JCYj9aH+M9YLzmbPsmywbWi/ukYw9Exh2IvNSavT?=
 =?us-ascii?Q?N3405kOayXqLtQ78QQiRnriZJqFKwDaoRVLSu+UrUQJDA582GFD4Hg4CsHBz?=
 =?us-ascii?Q?eTOb92gKRpDk5XjN5fGhJvLdq/vBXdJmGiHjiihMhCrnd4vXoGp4u278Wr9v?=
 =?us-ascii?Q?h+/N+itB6Ws3KzdTzT/ujtDK5SaSYMwwIGxYgISqB+AvXxAcq47MJTdkpDaz?=
 =?us-ascii?Q?HTNI3m/LLi+HChvK4KgqBRFMaPWuFQOh/HCLB0JrPdLvQwyCBCOrNp4vJWmF?=
 =?us-ascii?Q?yQre1DfEydVtXw/2ApeS3JVLt0xUZgoX+Xx6IBG0cXfLY05PUxAzxASq12Zx?=
 =?us-ascii?Q?0I4xth00k+LPKRq/TuFIjl9SM4ynPrHF0aXNEm4wLTQEBFuL1cGHiZKFP86r?=
 =?us-ascii?Q?ZDTyKb5LVhpbR30bLqgKDDKrS9W5glWNOUfZsAiWrCb80CtAeUvSTuv8CKXw?=
 =?us-ascii?Q?XQ7aOR/1uh1UBiF3XohJPHRvWAbqlQQROZxfVjcYbJHTW1z4f6Gh+5rOPWNa?=
 =?us-ascii?Q?XMlZXaNSmFOvTv1a+4V8mtD9ql5RMSceY9PF9QcKlORf+pnR7Us25b0yLK7v?=
 =?us-ascii?Q?+dOJS1EuTVzLLyhNHXB/5IQpccyK2H1Kk6nYPHJduRTs7ioK9hzzrUvi9JfC?=
 =?us-ascii?Q?nnlFrZbVJJ67+rLL7xVLwD9HRy2bJNtVZoh+hW6bGSu+21ePUCGroTKlxDYp?=
 =?us-ascii?Q?GtneEGLI07Ju/hEWv/2xXyvVux/5HtxggOMhw/35dYFSi8tOV77HmP6/1tMr?=
 =?us-ascii?Q?TeuRUQxtvYvI6HzI5BmKT8+4qZZcYAZmxZvG0Jjt71Gq/xQFv6y20c9IoP6S?=
 =?us-ascii?Q?p5y/+c2cj/+SKjGeEqR8Xxhu15Zj0vmeBNbWHIU7RDjA24pjgi9xsWUUosvv?=
 =?us-ascii?Q?XAqGOekgukyHQcvn8MsS5B7gHHEL2PNam6e1nAYHp7rs4a+ZrZQ/Za+KpKGk?=
 =?us-ascii?Q?AggqXYsvkxSws7Trf5v00npuPff/9/J8fQvsFfkhZ9DRFmsE81+8baVdHWsY?=
 =?us-ascii?Q?FQf3K3UU4SH7ACF4Vif2D9pU0N0dB0aGhKoZmXLUwfnRZUNT8zI5Z/Ttbkgd?=
 =?us-ascii?Q?OocIC3WswTnHorX78tJ97t4Hs2DDvejYLU4HzHqzhASS9NeOLk5bpLL0g6uS?=
 =?us-ascii?Q?iJ2zQfMwWlv2SEs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:06.9958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc65798-ef3a-4aaa-4fc3-08dd3a5368c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

From: loanchen <lo-an.chen@amd.com>

[Why]
the offset address of mmCLK5_spll_field_8 was incorrect for dcn35
which causes SSC not to be enabled.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Lo-An Chen <lo-an.chen@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 684a51e1cc48..56800c573a71 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -89,7 +89,7 @@
 #define mmCLK1_CLK4_ALLOW_DS 0x16EA8
 #define mmCLK1_CLK5_ALLOW_DS 0x16EB1
 
-#define mmCLK5_spll_field_8 0x1B04B
+#define mmCLK5_spll_field_8 0x1B24B
 #define mmDENTIST_DISPCLK_CNTL 0x0124
 #define regDENTIST_DISPCLK_CNTL 0x0064
 #define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
-- 
2.34.1

