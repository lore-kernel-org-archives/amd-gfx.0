Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B11FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45AC10E5FD;
	Wed, 18 Mar 2026 01:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POvDTeOd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA9A10E5FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3vNE5uPNdvnwKd1fbBuGKcrik3+jLb+J/H4A+8uV73Uydq0yyTFhUlCtPsCnSx95I8Zf2RSmwv/0XjRWS1XpQLaiTKJoZwQfAYgAkL4u+9DdWO91DTfQwRsdYPmGHCQHw7yznHs+HgIXiko+zDgXpMi8eebu129vy3upXQTtKu4LzvQzPIus2SQPvzNGej2PvxyZuVMQxRR+51jsmjzGVazP8rfeVsOhuYjeWcdI/4CCsX1j7sYlwmoEFsnkTiNxthX5MbaAndIfwk9Q1374p3PLgzpb2mS0Z4ZYXfRNTlDywIidTqO0I3KxoufLJNvsQkqMpD4+JzjUx3++iYrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqseARpqanEbOOwbiJiFIaPzViFOCbP/KV6XmVq2gCY=;
 b=krxDZ0UGlKwobBAzhr92EbWVB8DAmp8LZDM2buH5ALzvbX5/YpjuE8miWwJDsy0WfV6A+/HeXDvlzfa0YsLJuKHk6BFvbBkj7rHbzak2VzFQzyZeplef0aAglMvXnhrDZDqcaaFSMpxRFUECM9u0B4pfOeYfhMsRL9f3M5/RgOmm2tSkhN2xj84pb0TjzjSK2SF02YQCn7QstHW4mESGab04w2P3JhSqRMW8eU41zoqJGoUX87V2zvWxHXDC38B+eslHHVyVDZ1UZcG/9Vp2fPjYpxDlrTWkenmCmBguhFf7llKejdIxCYyAjRsC45M7sTcC+h0CbePvyagUrFuL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqseARpqanEbOOwbiJiFIaPzViFOCbP/KV6XmVq2gCY=;
 b=POvDTeOdmsiV61ny5x2eR1AUy4Wlejv5taMyAFNltWaA3VHZjx/dNqnvcaJHB79jAx6Ec4RvrQyh+FuQZj7i3J1EUb/42UtXvm82ES81MmzLIinM3vvgamSb2u6lkorQnTIBivvtau3kNtzaphKGqEtbbXiHTH8MoPWaVRRFHqc=
Received: from PH0PR07CA0062.namprd07.prod.outlook.com (2603:10b6:510:f::7) by
 DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 01:01:49 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::20) by PH0PR07CA0062.outlook.office365.com
 (2603:10b6:510:f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 01:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:49 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:45 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alexander Chechik <alexander.chechik@amd.com>, "Charlene
 Liu" <charlene.liu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 13/31] drm/amd/display: Fix DCN42 memory clock table using
 MemClk instead of UClk
Date: Wed, 18 Mar 2026 08:59:22 +0800
Message-ID: <20260318010224.513094-14-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 2088c390-540b-407b-e74a-08de8489ef66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rdDo4eWAMrbhrB6jTFxKDUcj8wzI0Eooc/Af0ngHLa2jLh7pw4ogsYbv2KjZ7NRhHI912c+0HekKYUfTH73vjGHefYFhKW6m8hISxjA7N4v+pBBblWIUFK3tSQuu69WY+9GeMwnMmHnjx6F5efhwVXR7D+yyYfAo04yU/P6eP1lcd0ezV+Neb9oiSrXT41GtXHYg4tzPHoffK9ASyuAcU22DLCKvOJ0g2qMQz7aOiMDycMxaW3+6ZKOSG4FrwZh9IXxePaBRdRXFQKQsWnZKydEFLtGdO/O3awQ/AwKb2qb7HxovekBx+U3reGPf15MI96tP4M7VBMubOzg91TA7QRipOAJoCoartAr6BHcG3PLz3QDRMehYwLQ80F7a0w2J1fK1r0i9zC+aHAX/dwP5TaeUYugbuGnp5GaluIxlb4/RFI3aj69znvbsQKRBdPGwsWbpDlh4vnltiLjOUDzbAl/93vWt6zSOE06TmlbCafNr7BVIkjWp1KjqbKfm1ggX1eI++HFGtqAahl+RfkzQp1eyb0KM50fCwkCDzJUV+9hyEkb1fuv6gRrtzWSnO43QIs0GaVYua6ibbqn8Spmaxosdf0BgyjO3QIU1p5t6MO0ADWxJdBAHYwxF2D2FkeB+3QLCY9DHASclKWNTBZFgHTcTQcLN0D+PJ9RxPkN/TLidAKx5yNP5Rm51Mr32sQzVj/qfs/tG8StxcWqSyaHLilDQvRFHcDZj+npsDes60I+VNp8A/QzGUKgUvIFD7SXOHbCg4xGaB75e+B4/XltNhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F6FNfDbPDZr7LCgZ09DASc+9idDYfX5E3rgKVJh6HvKqGG56ghXa1HNPG7I9rNrNIGj7KH5Rn9+PXz5C8WrWrNzfybtE8CsIJddn+ap0MzPRQFf0MjjgTtn/hS9clnisqKXJP43QhexSGhxSscbxg6fOx5zFaMbYcsMiYcFLY3x0GdwGxnrblhC/MD2VtC1YGNtQdFrVPjHOKj6IJqbJ8LsMviTWcPLzsgk2HLWp9TKHAz/GIPs2nwRnmndm+wSbuRKj4e/2MfuUWg0O81yrkcHyTaYSprXDvM1G88dHCkaTBhz7b+I/ghfYXvWeqg8BDDmPRieMVbfgWSwzgcB7iAOJ1DT/fDOKz8qvRYj60EYA01pvLlIE/4GotIR3D710S4cJgi0fDo4nsLRpxEo8Cr3ZNwnpq3Swkmyx9xuJl54ftSS9fmGLoDXdQKzL9mPU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:49.4471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2088c390-540b-407b-e74a-08de8489ef66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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

From: Alexander Chechik <alexander.chechik@amd.com>

[Why]
DCN42 was using UClk values instead of MemClk from MemPstateTable, causing
DML to see half the actual DRAM bandwidth on DDR5 systems and reject high
refresh rate modes.

[How]
Change dcn42_init_clocks() to use MemPstateTable[i].MemClk instead of
MemPstateTable[i].UClk for memclk_mhz initialization.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Alexander Chechik <alexander.chechik@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 7134d8998efc..24834f89711d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -1063,7 +1063,7 @@ static void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
 			if (dpm_clks->NumMemPstatesEnabled > NUM_MEM_PSTATE_LEVELS)
 				dpm_clks->NumMemPstatesEnabled = NUM_MEM_PSTATE_LEVELS;
 			for (i = 0; i < dpm_clks->NumMemPstatesEnabled; i++) {
-				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].UClk;
+				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].MemClk;
 				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[i].WckRatio)	;
 			}
 			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumMemPstatesEnabled;
-- 
2.43.0

