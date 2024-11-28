Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDBCD69114
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06F910ECA2;
	Thu, 28 Nov 2024 14:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJ+6+27Y";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA9110EC93
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXQAEV81aUOfJC5TAlPNROKUt6HOCRoumWv67cOZdLOAzVzL86XnacK4Vbx0/cYcsEqz9Z2xfAcwKKuzJ9p0RNMt+bZ3PygZxPt/+4sy0/ACdz6toq6m5iXyIsFEtTDCQs3PmmZ9a4XPghBks2yx5hZwzQF6T97UZGJJxNjOmaM7vIAQHYGWvSgHrXv1reIJ9E4O+u24gXe1RkX3hUC8Hz1GaqlsBy0OE/q+wveoIdJFnN28nQsNNR24N4m8U53np3+oksX5f6SqL5343hbBvkyLzpToGs5dqmZUBmK6cxfDWj3L9H2D4Rxx5YCZV7d1dQjTc+N5m8hhSrFXYd/cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpKcBYAf0UwdIHLwCDYji/i6KSVwd23pZR5vWF8Osvc=;
 b=zKDBrbpvQ3ycZT3dZfcHlYsOc3d/OlD7XTX8ACtZBiNRiWR9JiZbcBOjYtatNvX4jIwtQgmm71OGD0t40aODAfAqtXKh6cju/WOwF2ucsFNxh9hdrlYOtKE6Kb06BVzcjuNLe5QuqaRkSxato/nXVwO7+pgPArVl8vgfHVB1rOCtlje14wrlhlAEfkEot9c4BwyvfKrNe4ZHK8wBHo5kqGp5GD+1o+CLkW6xb5Hpd/Ra29oQYAjMmHy4mOfPF407ZztKNCkKtA0zk9PJgdVav7GuFFdWI5bCNS1YXNKTbkQ4o15pjwlHSfruCah4Go/9qUTJBS2tdFEBqi+HMDuSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpKcBYAf0UwdIHLwCDYji/i6KSVwd23pZR5vWF8Osvc=;
 b=TJ+6+27YkPYQH8V4TSjoJojhhL5/6aH6oYRiMJfOaPc8siqxf0+h2b2CprrQhZeLjPtfH6exAq0gadgcwyPmnA/OlBQZ/laOIptlmXROeytGLyTfZ/VQbBr1eL7WBzDM5fUFzNTyQgQNiXjB0JuF1DQBlSKe9bKgZ4SqZ9KqcBA=
Received: from SN6PR05CA0035.namprd05.prod.outlook.com (2603:10b6:805:de::48)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 14:30:18 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::8f) by SN6PR05CA0035.outlook.office365.com
 (2603:10b6:805:de::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.4 via Frontend Transport; Thu,
 28 Nov 2024 14:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 14:30:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:17 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:16 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Sung joon Kim
 <sungjoon.kim@amd.com>
Subject: [PATCH 2/9] drm/amd/display: correct dcn351 dpm clk table based on
 pmfw_drv_if
Date: Thu, 28 Nov 2024 09:26:24 -0500
Message-ID: <20241128142958.28370-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f279b4e-158c-44a7-5924-08dd0fb92e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ShzI8aLANgVZE6q+JUHO7QcxUsZC6mmzNHVlbNeKBeMU7LroLzmDlhIIDW/8?=
 =?us-ascii?Q?e5otsRYPmqJ7B9CsDtcSFFer1KMpBwBqze/LvgAaICYO78nAWhOlv7r2xClm?=
 =?us-ascii?Q?yUc/93gEtIwhQs/AwRGkCy+pxBc31dD9yzLtZuZ7VFgY7L9K61kyIYU2/Vao?=
 =?us-ascii?Q?dzcD6CWeK45YApM26egUNgaXngwmcm+UjOQOb2C7I6SDDaYbePVIeVjbZ+Lr?=
 =?us-ascii?Q?8ZXR7UleGRxc8L4M6+9TlWmAz/2ERGh7IWAmQqbHMIB2vJ5abhpdFlqy3f5i?=
 =?us-ascii?Q?JxFugCxQemjZ82iDD0xEwTklGKIBTsQ1CgP43J5rkE7K2F/6RWrYJ4UNjULl?=
 =?us-ascii?Q?s3qf6+LmVsderYYTQWasX2Wk9xqG1qpUI41KSMIzBsbbuDf/lYHhbkRzch+q?=
 =?us-ascii?Q?n0Q7m9oma2ptf+Esh3j1HCi6Si657lnoK7J+tJfaOgzrPlea+1vQFWTCBzFk?=
 =?us-ascii?Q?Cpfs9i0FnqyVlSXmT6ZXmwo/JegUoA3cwOMJ8+/Rx5cua7tTrtoMP4I/dU3t?=
 =?us-ascii?Q?LKLXT+gTOmmrhDBVZRQqSqc3oAIDDe0aKeAH9E2abyC3LBYh4SeYxKvHaQTd?=
 =?us-ascii?Q?iWIOBYj6qs3AjlUoG+pqoayfReYIQOjvtcUYCDYd79DkKmgEbi4vU7ivmw/T?=
 =?us-ascii?Q?OM/4u2IhoMGd3ocUS/hO6RRUH1lBdBDXM8iUriFGzwoGXLO2YM2SGNWP9ncK?=
 =?us-ascii?Q?mH0q0lzkTsG825C5E/UGlpD39nMy+vRxyyOJy/A1SM1VOHJz3LkUIqVF5YyQ?=
 =?us-ascii?Q?2gZHKiAEYegVSv/IeV7uietGWI/lQHD6d8MUlT3BQ/fcxIitFwxHflrapBfN?=
 =?us-ascii?Q?1/yZZuy/iXSKkytUmJ5e91NH52mi0ImbXUNeFcYG0K5UeAtfj1Dqdu6O2Pkm?=
 =?us-ascii?Q?qhJN800DzGELABl4dIMlG4BFwn9KrPKSAEJMnme3jtPhjN64veQUvLzqKy5K?=
 =?us-ascii?Q?4qxOYJQev5DLXcZRZUUTAQYDJgeN2sBrdpm02feBmxYH2qZ9OvuiBEU3+mOt?=
 =?us-ascii?Q?1LGHp1LZId3Eg5x0mrxwHaclh0fmx5CW6mp6395LXkjN/u+UMsvoFnWUnJZr?=
 =?us-ascii?Q?Ajp6QWGAfcTkk7uvEGaCIE65hvMCV5QBxgIOUevYdj2FvCqq2xUGmYWSabZl?=
 =?us-ascii?Q?ER3L+hl5ir2EoL8gGA9uXZkuYzloOgzhfHstq0WZx+xjbLvwPkk7leP0Y11l?=
 =?us-ascii?Q?xtwC3t9yXehbAe3j/UISCebT9JLJEuOpgZgItwaDdX0MOvTHx3GQLfJ7y3Ft?=
 =?us-ascii?Q?6lzJAIj1kAqXx6jGVbKoou/m5PM9vb3UAb9SBVVGI+aG+n/XJuY9my6tRcla?=
 =?us-ascii?Q?5wb+gkSED5yUeB4I9AFQ3f0zEhwbJ70ivSm7WhDt4wixgcKJkv2OZHTlaxVX?=
 =?us-ascii?Q?TDF81eScEp8N+sc8R3zFbgXAQwOeCU0I6We+x/+7bsqb1qtnsdE5YPTa8IBH?=
 =?us-ascii?Q?zdyEAdRXHrAovsLeAdLncKDOC7KeaQT7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:17.7260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f279b4e-158c-44a7-5924-08dd0fb92e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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

[why]
driver got wrong clock table due to miss match dtm_table headers.
correct the dtn_clock table based on pmfw header.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 93 ++++++++++++++++++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  | 41 +++++---
 2 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index b77333817f18..d6e68c0d9e42 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -632,6 +632,7 @@ static struct wm_table lpddr5_wm_table = {
 };
 
 static DpmClocks_t_dcn35 dummy_clocks;
+static DpmClocks_t_dcn351 dummy_clocks_dcn351;
 
 static struct dcn35_watermarks dummy_wms = { 0 };
 
@@ -755,6 +756,22 @@ static void dcn35_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 	dcn35_smu_transfer_dpm_table_smu_2_dram(clk_mgr);
 }
 
+static void dcn351_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+		struct dcn351_smu_dpm_clks *smu_dpm_clks)
+{
+	DpmClocks_t_dcn351 *table = smu_dpm_clks->dpm_clks;
+
+	if (!clk_mgr->smu_ver)
+		return;
+	if (!table || smu_dpm_clks->mc_address.quad_part == 0)
+		return;
+	memset(table, 0, sizeof(*table));
+	dcn35_smu_set_dram_addr_high(clk_mgr,
+			smu_dpm_clks->mc_address.high_part);
+	dcn35_smu_set_dram_addr_low(clk_mgr,
+			smu_dpm_clks->mc_address.low_part);
+	dcn35_smu_transfer_dpm_table_smu_2_dram(clk_mgr);
+}
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
@@ -1093,6 +1110,57 @@ struct clk_mgr_funcs dcn35_fpga_funcs = {
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 };
 
+static void translate_to_DpmClocks_t_dcn35(struct dcn351_smu_dpm_clks *smu_dpm_clks_a,
+		struct dcn35_smu_dpm_clks *smu_dpm_clks_b)
+{
+	/*translate two structures and only take need clock tables*/
+	uint8_t i;
+
+	if (smu_dpm_clks_a == NULL || smu_dpm_clks_b == NULL ||
+		smu_dpm_clks_a->dpm_clks == NULL || smu_dpm_clks_b->dpm_clks == NULL)
+		return;
+
+	for (i = 0; i < NUM_DCFCLK_DPM_LEVELS; i++)
+		smu_dpm_clks_b->dpm_clks->DcfClocks[i] = smu_dpm_clks_a->dpm_clks->DcfClocks[i];
+
+	for (i = 0; i < NUM_DISPCLK_DPM_LEVELS; i++)
+		smu_dpm_clks_b->dpm_clks->DispClocks[i] = smu_dpm_clks_a->dpm_clks->DispClocks[i];
+
+	for (i = 0; i < NUM_DPPCLK_DPM_LEVELS; i++)
+		smu_dpm_clks_b->dpm_clks->DppClocks[i] = smu_dpm_clks_a->dpm_clks->DppClocks[i];
+
+	for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++) {
+		smu_dpm_clks_b->dpm_clks->FclkClocks_Freq[i] = smu_dpm_clks_a->dpm_clks->FclkClocks_Freq[i];
+		smu_dpm_clks_b->dpm_clks->FclkClocks_Voltage[i] = smu_dpm_clks_a->dpm_clks->FclkClocks_Voltage[i];
+	}
+	for (i = 0; i < NUM_MEM_PSTATE_LEVELS; i++) {
+		smu_dpm_clks_b->dpm_clks->MemPstateTable[i].MemClk =
+			smu_dpm_clks_a->dpm_clks->MemPstateTable[i].MemClk;
+		smu_dpm_clks_b->dpm_clks->MemPstateTable[i].UClk =
+			smu_dpm_clks_a->dpm_clks->MemPstateTable[i].UClk;
+		smu_dpm_clks_b->dpm_clks->MemPstateTable[i].Voltage =
+			smu_dpm_clks_a->dpm_clks->MemPstateTable[i].Voltage;
+		smu_dpm_clks_b->dpm_clks->MemPstateTable[i].WckRatio =
+			smu_dpm_clks_a->dpm_clks->MemPstateTable[i].WckRatio;
+	}
+	smu_dpm_clks_b->dpm_clks->MaxGfxClk = smu_dpm_clks_a->dpm_clks->MaxGfxClk;
+	smu_dpm_clks_b->dpm_clks->MinGfxClk = smu_dpm_clks_a->dpm_clks->MinGfxClk;
+	smu_dpm_clks_b->dpm_clks->NumDcfClkLevelsEnabled =
+		smu_dpm_clks_a->dpm_clks->NumDcfClkLevelsEnabled;
+	smu_dpm_clks_b->dpm_clks->NumDispClkLevelsEnabled =
+		smu_dpm_clks_a->dpm_clks->NumDispClkLevelsEnabled;
+	smu_dpm_clks_b->dpm_clks->NumFclkLevelsEnabled =
+		smu_dpm_clks_a->dpm_clks->NumFclkLevelsEnabled;
+	smu_dpm_clks_b->dpm_clks->NumMemPstatesEnabled =
+		smu_dpm_clks_a->dpm_clks->NumMemPstatesEnabled;
+	smu_dpm_clks_b->dpm_clks->NumSocClkLevelsEnabled =
+		smu_dpm_clks_a->dpm_clks->NumSocClkLevelsEnabled;
+
+	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
+		smu_dpm_clks_b->dpm_clks->SocClocks[i] = smu_dpm_clks_a->dpm_clks->SocClocks[i];
+		smu_dpm_clks_b->dpm_clks->SocVoltage[i] = smu_dpm_clks_a->dpm_clks->SocVoltage[i];
+	}
+}
 void dcn35_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn35 *clk_mgr,
@@ -1100,6 +1168,7 @@ void dcn35_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dcn35_smu_dpm_clks smu_dpm_clks = { 0 };
+	struct dcn351_smu_dpm_clks smu_dpm_clks_dcn351 = { 0 };
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn35_funcs;
 
@@ -1130,14 +1199,24 @@ void dcn35_clk_mgr_construct(
 				DC_MEM_ALLOC_TYPE_GART,
 				sizeof(DpmClocks_t_dcn35),
 				&smu_dpm_clks.mc_address.quad_part);
-
 	if (smu_dpm_clks.dpm_clks == NULL) {
 		smu_dpm_clks.dpm_clks = &dummy_clocks;
 		smu_dpm_clks.mc_address.quad_part = 0;
 	}
-
 	ASSERT(smu_dpm_clks.dpm_clks);
 
+	if (ctx->dce_version == DCN_VERSION_3_51) {
+		smu_dpm_clks_dcn351.dpm_clks = (DpmClocks_t_dcn351 *)dm_helpers_allocate_gpu_mem(
+				clk_mgr->base.base.ctx,
+				DC_MEM_ALLOC_TYPE_GART,
+				sizeof(DpmClocks_t_dcn351),
+				&smu_dpm_clks_dcn351.mc_address.quad_part);
+		if (smu_dpm_clks_dcn351.dpm_clks == NULL) {
+			smu_dpm_clks_dcn351.dpm_clks = &dummy_clocks_dcn351;
+			smu_dpm_clks_dcn351.mc_address.quad_part = 0;
+		}
+	}
+
 	clk_mgr->base.smu_ver = dcn35_smu_get_smu_version(&clk_mgr->base);
 
 	if (clk_mgr->base.smu_ver)
@@ -1166,7 +1245,11 @@ void dcn35_clk_mgr_construct(
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
 		int i;
-		dcn35_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
+		if (ctx->dce_version == DCN_VERSION_3_51) {
+			dcn351_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks_dcn351);
+			translate_to_DpmClocks_t_dcn35(&smu_dpm_clks_dcn351, &smu_dpm_clks);
+		} else
+			dcn35_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
 		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
 				   "NumDispClkLevelsEnabled: %d\n"
 				   "NumSocClkLevelsEnabled: %d\n"
@@ -1227,6 +1310,10 @@ void dcn35_clk_mgr_construct(
 		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_GART,
 				smu_dpm_clks.dpm_clks);
 
+	if (smu_dpm_clks_dcn351.dpm_clks && smu_dpm_clks_dcn351.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_GART,
+				smu_dpm_clks_dcn351.dpm_clks);
+
 	if (ctx->dc->config.disable_ips != DMUB_IPS_DISABLE_ALL) {
 		bool ips_support = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 3fae13c73934..ab9d21ba0c43 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -126,18 +126,31 @@ typedef struct {
   uint32_t MaxGfxClk;
 } DpmClocks_t_dcn35;
 
-
-// Throttler Status Bitmask
-
-
-
-
-
-
-
-
-
-
+typedef struct {
+	uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+	uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+	uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+	uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+	uint32_t VClocks0[NUM_VCN_DPM_LEVELS];
+	uint32_t VClocks1[NUM_VCN_DPM_LEVELS];
+	uint32_t DClocks0[NUM_VCN_DPM_LEVELS];
+	uint32_t DClocks1[NUM_VCN_DPM_LEVELS];
+	uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
+	uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
+	uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
+	uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+	MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
+	uint8_t NumDcfClkLevelsEnabled;
+	uint8_t NumDispClkLevelsEnabled; // Applies to both Dispclk and Dppclk
+	uint8_t NumSocClkLevelsEnabled;
+	uint8_t Vcn0ClkLevelsEnabled; // Applies to both Vclk0 and Dclk0
+	uint8_t Vcn1ClkLevelsEnabled; // Applies to both Vclk1 and Dclk1
+	uint8_t VpeClkLevelsEnabled;
+	uint8_t NumMemPstatesEnabled;
+	uint8_t NumFclkLevelsEnabled;
+	uint32_t MinGfxClk;
+	uint32_t MaxGfxClk;
+} DpmClocks_t_dcn351;
 
 #define TABLE_BIOS_IF            0 // Called by BIOS
 #define TABLE_WATERMARKS         1 // Called by DAL through VBIOS
@@ -163,6 +176,10 @@ struct dcn35_smu_dpm_clks {
 	union large_integer mc_address;
 };
 
+struct dcn351_smu_dpm_clks {
+	DpmClocks_t_dcn351 *dpm_clks;
+	union large_integer mc_address;
+};
 /* TODO: taken from vgh, may not be correct */
 struct display_idle_optimization {
 	unsigned int df_request_disabled : 1;
-- 
2.43.0

