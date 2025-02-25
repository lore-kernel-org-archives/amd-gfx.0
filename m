Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D281C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2C710E4AF;
	Tue, 25 Feb 2025 06:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WTiLgZDe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DD910E4AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZMlVRV7WaSl+1uRyDDJuQfWr4Q+fGfkewGGBe1QRovmBcc7F401B9R5TSsCsIrwvQ5ygS4D/QgNG2Zsiwn7Pa9pyS0qVOT/CbsZDnkWRlnU2iiKAGKqbi8sLqS2taKNDHLlSUP/YgCzkPL0KlcEATAMrB5K+naWGOIKCuRnHt+B7cQPqr/Ee1d5ZZvJw20Y4mdG2m0HM0SskN1avDLK7bfOqpzGN0odoVAB1iW61kAxyrapMtqc9wBb4ZEdSI5kCYNIkqZP9ullHdcOYyCCm/pFluZnS1Mgv732uBeiRXXzGERyQHqB6U/MudP2Uh1HYTimeHWV4VF404oQb73dyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAm/3bg9ME5VPB/+Wil+DBSsz2iwynNr4bdlpr+Gfu8=;
 b=Rl14F1ZZJjIDhF/nx2LvOLw/PI8vBkZhJj0lMnkjWBobObdknDdi27Wwh/hcB6XeVuzNf0h8UJt5WQqjchVc8CE6vvmouT72MbmqIWJCq4mmRiR3/+q5XBsfUmwUsM3HmK1jzlQvYTGl+HMtkfJMBl/vbRthib2T3b2axmIT938KkfmAHxo8UjTt8yovZY2TYzuN9rYSgob3sWJLJXW1lmfGb5bUNzkEHzcjKiaydOjGt+piKBKz0yG8gNeUc6ZtLqaDHPKfRaqVgQckX4P/1crpSXwoi2pIJedGXI9R4Q13FkIOeRmc6jLGVX9HSrrrh9NL5FqmiLrr6Moe5x4Kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAm/3bg9ME5VPB/+Wil+DBSsz2iwynNr4bdlpr+Gfu8=;
 b=WTiLgZDem/WLoWVokIhOiUa+6cC0uvtLRsLqnWgLTu/zeJBToau93gA/yBOdM9h9Y68drFZ6e269mAHsNnZi0csD++ijbxR/DC1+SzxGGzcCqg15MVBtl7RAEthRYny3li5YGUS0Ts847d/F7SSXGhXJMSK6d9ujNUD4AhNe60M=
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:36:41 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::89) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:36:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:39 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:34 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 02/27] drm/amd/display: Fix p-state type when p-state is
 unsupported
Date: Tue, 25 Feb 2025 14:35:45 +0800
Message-ID: <20250225063610.631461-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 85948caa-4e4a-4dec-df90-08dd5566c30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kTHylh5FMHwqTOyo7ixnBroxx3OtLNhnC2L7Ajq9PODdJYTysTHEtfPae9x5?=
 =?us-ascii?Q?aOsuOr6qc2cA6uNegSReREFadWcoQ28X3GNgMlMj8oQiReHwfdHp41/9sHw6?=
 =?us-ascii?Q?pOkKQruslaogqgjMm3aPXZL8N0RYuaHvBvyz9g+YGRjR8DgtA8egWVuw9Jtf?=
 =?us-ascii?Q?xpoQTP1/hhKwEQV2Cuc3D3J/PBKJyCP+LtlNJGfaKn66ofKV5cuMdK4vzZrW?=
 =?us-ascii?Q?bF7iOjQnY7xPSIwfYJzzmiVmxmoClUp9NeHB9KlqFRVBNuiGrCJ55fIJeAbx?=
 =?us-ascii?Q?hs1udLuWl2rytWobWGB0haXS0qbZjFLM3w/cWiD87IGgEY+OD00AFaA61CZ6?=
 =?us-ascii?Q?COoneCmWDRijdLMeuqbRAugDqWr78XbJg9L4t7UfNuQdYTZ+8BFBWoNKYson?=
 =?us-ascii?Q?tdQGPdLhIOeJhPQfig4sa6O82cdQJ2qcRy4kUypHE+WBxNewoNe4rnw0tWoZ?=
 =?us-ascii?Q?FK4isMei/sfNfZqrs/BOzn6ct9vj5HKQi/MIXvFiuzY2ISQeuV8+j9i/d4SA?=
 =?us-ascii?Q?taynqPX/4aRt8mtpkDF//ISF66lN5Xc30qlmt4aku4SR/84brezs00TXaUtB?=
 =?us-ascii?Q?MCiwBvfRQFz7JhR6VHWGLZbeYMEs6fGmU2fvuZQQ91IEFTtLcYDgt9eHRajA?=
 =?us-ascii?Q?ljxmTqy0+fJzbzQr4JXHpqsasnElrRasFoM8hFKTiuPv5T6H900hAvOiO9IN?=
 =?us-ascii?Q?/+OMTgxrMwkfziLWCVMQ/26WVJ2EH9KKHSNHhC4Datzn6TbE5PkNEUDY/p4U?=
 =?us-ascii?Q?z0MyUIE0bjFd7uUZuMXhLeT2JMOR5aIxgh1Egwni8F5AeVPGZ7DDgRt0hJBK?=
 =?us-ascii?Q?NEESAEow/SisPFjFV0eHT9aTroVLwQK3zeY5LTxB7rAQCfFt5/XXDScP30pI?=
 =?us-ascii?Q?YxysgDWNmvdP82YU25yY3jMS07ZPnPQYwZf6n9JocFlLI7yE+SZuvchri0pL?=
 =?us-ascii?Q?IqPi31qLtQy1wAE8PPaAzGCw9hkB5WiOSZaTHJXG5gVZFYHZvWKUHrnPwxi8?=
 =?us-ascii?Q?/tdDbQvhsL3eCnnM5fl9MaoYlbELiPg2461bTx6ZrRNsAWWd43YI/mTvoGXj?=
 =?us-ascii?Q?DDwbD/f0DZjtlyWfCHUhSq7dHftT6fQlEKFh4RUq0lddKzj777tL2SXFUmsJ?=
 =?us-ascii?Q?9cG1tNT/7/l+W3AOEFzCdF7dRj86W7xwBxXIzRALsdhmb+Y3Vj/PTjIMMYHk?=
 =?us-ascii?Q?NN9QxR+JbF8AEUJikxAW1oJ2zCGD4YzjAfmv+bWVHeEEd9FstGBM+mAVdpfX?=
 =?us-ascii?Q?x9hy0pBgAt3z7TSdD5KLFXDu0AciGs7SJmKyTlRld9ZX06zVJ8ycoTERCARB?=
 =?us-ascii?Q?Y6RTucarrk2vW3gicDjyD+HYmTAuGKsbunoGXMDFDL4XE2PJ5J+ncrgAbhKm?=
 =?us-ascii?Q?/ZwqbwMnvpcuGJpXdLZFEI4c4G7DVJk7AOgtexhBiEeVA4UR7Ioltwn2M8fc?=
 =?us-ascii?Q?YkO+J+6vZJH7/oAdLTNe+RNesMyrozz5zKqh1Bomi71nHsT6GUNv+cvu43wW?=
 =?us-ascii?Q?YvbM3f8Ha2KlE0k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:36:40.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85948caa-4e4a-4dec-df90-08dd5566c30d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
P-state type would remain on previously used when unsupported which
causes confusion in logging and visual confirm, so set back to zero
when unsupported.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 6b514fd03f16..367c6b794412 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -564,6 +564,7 @@ void set_p_state_switch_method(
 	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba)
 		return;
 
+	pipe_ctx->p_state_type = P_STATE_UNKNOWN;
 	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
 			dm_dram_clock_change_unsupported) {
 		/* MCLK switching is supported */
-- 
2.37.3

