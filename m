Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D261C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD78B4B40;
	Sat, 13 Aug 2022 02:14:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC50BB4AC8
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH7gq/BZSht1XNme/dnH6OW6qf1IsVv2kbD4pdUKcetHvKWDp8tEOinybspvHOfwenHNbxEsJCC66DPqK38LWbC4kS5QYD+7ZqLtkAvlUW4W2Qpy0Kqo3WXhw9LIrRbnX5ALtq9Bx+kYQ5/I3dmxEtODegnS7pZXgKZ9/DNaJi8WRQxPczuL/gcSbXoZcMONNsX9doEaSWAM+wX4ukI/4V7jbAMUC27JnrimbwBFaOcGyyUlKRegO7/z1+t5oySGz/ikfVMjdLVCsnPcwsl9HCVb/tT4Nn/fVUsXb18rzqAsDavZXNfk2cE50+jVHXXF04dj2hIvowik9NYqNz79Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdvCJnLgDi29sg8hE3UxUzjXqGCUh/hXIiqud5JkrJA=;
 b=Tinc10tlq1go0cNicXdTqk20bSlweFqq0kSx3svg5MFsZucP0uNoaupmuDnC8Ur7MqMX9ipg7k8+q0Oi61+CG/CZmaEkgoZzVLtuleA8oLQPGM03M6hsn/C2nH/hTfciHsKi3BHOXQU34/Hi6q/sD78G2aVHKNQwawnjyIj1V+B1VgZzEvPWtsYmrcke57SirDny0SCsoEJBXIW+TLhBFv9sBA0e5QzRCTKvMxbW/28WcdEAM7a7JeJ8KBRYzXyYL7rDS1yiyUBa4jUWXKJOmFVlyuNZzt1y/UkyoXko6oNDjbfEvfA76AR1d8xRWIb4aRuGShMqkk+T1XDYw8K/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdvCJnLgDi29sg8hE3UxUzjXqGCUh/hXIiqud5JkrJA=;
 b=FbH2FXJ27CB9rHnaQLJaW3jKPrfrc5+guIq2QfwAwO63wRPDbq30EzbiolKs7cTUaQMl8gzfmaQKQB6xylt1sxxrdOhbCqddmuNJ1/nLK1CfvANSjI4FJmaF4a8+xrPPRImWJFBOxRn8r1tl4bPJrJxpBnK7pZCZVYrp5wGCqRk=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Sat, 13 Aug 2022 02:13:34 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::42) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:13:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:21 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:13:17
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: Update clock table policy for DCN314
Date: Sat, 13 Aug 2022 06:12:19 +0800
Message-ID: <20220812221222.1700948-12-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d14ae662-a69e-47f2-48ae-08da7cd16d01
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xugoJVycrl5/LWME1f7X/+8Lk5dVRlLOxdsuubn3v9Rm64sxeQsdicsnA5hg/cH+aI8+iSHx9SzjfKq43oEfRtI+PTX4x5kGYBuVXSZckiArh80QxziRL0uqrGDGQVcWhqLwGie++JZrwpomw7abgQ4rZMbnIaOZOhlLEm/ccD3o/U5tt5Km+q3gPvuDer/plPlgxQ20E5FXCthfN82Iq1VGORTgoT2QIVR8728S0UvlNSXxV83KFfwjCuMLTGejF+RlcmSqlRaV2dz8sT16rZOnyRNYEOA9gp3q1gvVSuWIoG/4JwfxoTRlwuuP8aNsbFBOSpt0dCPKreKzv1HCRbI17DB4+rp8lIwgE7ns1Hz3rsX5Onrj4tw5ddJX48jI3tSq3Tmpky+7riPyhTdo4bp9Rjt1FYd1uQp2mQgGdohKJuhyJdR7ag3MoOdkb8yoMbmTDswu0CxJIqQiPa7EaWEF9nVMMMMwu76JO2RmE8ILGZcZRnHbaZB4rWJGg2H7ReVTB/nFfEqYC5t2l3PQdcOCEoWLzWwharAWs9J9Gd9MYVQIQqO/mYy7rU55v4IQC2+YrdSDUP3Iu5nCBUI8D5Tye3hqL9ZZU1sn/K+kWOUSGaCQKZwLJMa+rhhtDvpjKbq6auCvjmbkmDm10pQNgUIVygJ6fPGmf/n1iM6Jo3qwNbC9wFvElV3bBKN/y85JSwbOMcTxVHjXQhWk5CRYg3cB0WD5E1GrL/3ohXGHIvQWjTcZf3nmtlN2lVIQQJhj7R+fDUuSAwDoZUFgqWZWFg/xNcD8Uch2tU3tkUe4vIXLlwVpHysjE2BJE2b1/k2Z46xJWmVrcDcUNFLV5H5vWRyDgRxto1jaApkLo05ev3s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(40470700004)(6916009)(316002)(82740400003)(8676002)(4326008)(83380400001)(478600001)(36756003)(54906003)(19627235002)(70586007)(70206006)(26005)(40480700001)(82310400005)(30864003)(81166007)(86362001)(15650500001)(356005)(2906002)(40460700003)(5660300002)(8936002)(41300700001)(7696005)(47076005)(2616005)(336012)(36860700001)(426003)(186003)(1076003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:13:34.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14ae662-a69e-47f2-48ae-08da7cd16d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>, Brian
 Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Depending on how the clock table is constructed from PMFW we can run
into issues where we don't think we have enough bandwidth available
due to FCLK too low - eg. when the FCLK table contains invalid entries
or a single entry.

We should always pick up the maximum clocks for each state as a final
state in this case to prevent validation from failing if the table is
malformed.

We should also contain sensible defaults in the case where values
are invalid.

Redfine the clock table structures by adding a 314 prefix to make
debugging these issues easier by avoiding symbol name clashes.

Overall this policy more closely aligns to how we did things for 315,
but because of how the voltage rail is setup we should favor keeping
DCFCLK low rather than DISPCLK or DPPCLK - so use the max for those
in every entry.

Reviewed-by: Daniel Miess <daniel.miess@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 186 ++++++++++++------
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    |  33 +++-
 2 files changed, 154 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index c74f2d5bbbc5..beb025cd3dc2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -415,7 +415,7 @@ static struct wm_table lpddr5_wm_table = {
 	}
 };
 
-static DpmClocks_t dummy_clocks;
+static DpmClocks314_t dummy_clocks;
 
 static struct dcn314_watermarks dummy_wms = { 0 };
 
@@ -500,7 +500,7 @@ static void dcn314_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 static void dcn314_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct dcn314_smu_dpm_clks *smu_dpm_clks)
 {
-	DpmClocks_t *table = smu_dpm_clks->dpm_clks;
+	DpmClocks314_t *table = smu_dpm_clks->dpm_clks;
 
 	if (!clk_mgr->smu_ver)
 		return;
@@ -517,6 +517,26 @@ static void dcn314_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 	dcn314_smu_transfer_dpm_table_smu_2_dram(clk_mgr);
 }
 
+static inline bool is_valid_clock_value(uint32_t clock_value)
+{
+	return clock_value > 1 && clock_value < 100000;
+}
+
+static unsigned int convert_wck_ratio(uint8_t wck_ratio)
+{
+	switch (wck_ratio) {
+	case WCK_RATIO_1_2:
+		return 2;
+
+	case WCK_RATIO_1_4:
+		return 4;
+
+	default:
+		break;
+	}
+	return 1;
+}
+
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
@@ -530,89 +550,127 @@ static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 	return max;
 }
 
-static unsigned int find_clk_for_voltage(
-		const DpmClocks_t *clock_table,
-		const uint32_t clocks[],
-		unsigned int voltage)
-{
-	int i;
-	int max_voltage = 0;
-	int clock = 0;
-
-	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
-		if (clock_table->SocVoltage[i] == voltage) {
-			return clocks[i];
-		} else if (clock_table->SocVoltage[i] >= max_voltage &&
-				clock_table->SocVoltage[i] < voltage) {
-			max_voltage = clock_table->SocVoltage[i];
-			clock = clocks[i];
-		}
-	}
-
-	ASSERT(clock);
-	return clock;
-}
-
 static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk_mgr,
 						    struct integrated_info *bios_info,
-						    const DpmClocks_t *clock_table)
+						    const DpmClocks314_t *clock_table)
 {
-	int i, j;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
-	uint32_t max_dispclk = 0, max_dppclk = 0;
-
-	j = -1;
-
-	ASSERT(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL);
-
-	/* Find lowest DPM, FCLK is filled in reverse order*/
+	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
+	uint32_t max_pstate = 0,  max_fclk = 0,  min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
+	int i;
 
-	for (i = NUM_DF_PSTATE_LEVELS - 1; i >= 0; i--) {
-		if (clock_table->DfPstateTable[i].FClk != 0) {
-			j = i;
-			break;
+	/* Find highest valid fclk pstate */
+	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
+		if (is_valid_clock_value(clock_table->DfPstateTable[i].FClk) &&
+		    clock_table->DfPstateTable[i].FClk > max_fclk) {
+			max_fclk = clock_table->DfPstateTable[i].FClk;
+			max_pstate = i;
 		}
 	}
 
-	if (j == -1) {
-		/* clock table is all 0s, just use our own hardcode */
-		ASSERT(0);
-		return;
-	}
-
-	bw_params->clk_table.num_entries = j + 1;
+	/* We expect the table to contain at least one valid fclk entry. */
+	ASSERT(is_valid_clock_value(max_fclk));
 
-	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
+	/* Dispclk and dppclk can be max at any voltage, same number of levels for both */
 	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
 	    clock_table->NumDispClkLevelsEnabled <= NUM_DPPCLK_DPM_LEVELS) {
 		max_dispclk = find_max_clk_value(clock_table->DispClocks, clock_table->NumDispClkLevelsEnabled);
 		max_dppclk = find_max_clk_value(clock_table->DppClocks, clock_table->NumDispClkLevelsEnabled);
 	} else {
+		/* Invalid number of entries in the table from PMFW. */
 		ASSERT(0);
 	}
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
-		switch (clock_table->DfPstateTable[j].WckRatio) {
-		case WCK_RATIO_1_2:
-			bw_params->clk_table.entries[i].wck_ratio = 2;
-			break;
-		case WCK_RATIO_1_4:
-			bw_params->clk_table.entries[i].wck_ratio = 4;
-			break;
-		default:
-			bw_params->clk_table.entries[i].wck_ratio = 1;
+	/* Base the clock table on dcfclk, need at least one entry regardless of pmfw table */
+	for (i = 0; i < clock_table->NumDcfClkLevelsEnabled; i++) {
+		uint32_t min_fclk = clock_table->DfPstateTable[0].FClk;
+		int j;
+
+		for (j = 1; j < clock_table->NumDfPstatesEnabled; j++) {
+			if (is_valid_clock_value(clock_table->DfPstateTable[j].FClk) &&
+			    clock_table->DfPstateTable[j].FClk < min_fclk &&
+			    clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i]) {
+				min_fclk = clock_table->DfPstateTable[j].FClk;
+				min_pstate = j;
+			}
 		}
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
-		bw_params->clk_table.entries[i].socclk_mhz = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
+
+		/* First search defaults for the clocks we don't read using closest lower or equal default dcfclk */
+		for (j = bw_params->clk_table.num_entries - 1; j > 0; j--)
+			if (bw_params->clk_table.entries[j].dcfclk_mhz <= clock_table->DcfClocks[i])
+				break;
+
+		bw_params->clk_table.entries[i].phyclk_mhz = bw_params->clk_table.entries[j].phyclk_mhz;
+		bw_params->clk_table.entries[i].phyclk_d18_mhz = bw_params->clk_table.entries[j].phyclk_d18_mhz;
+		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
+
+		/* Now update clocks we do read */
+		bw_params->clk_table.entries[i].fclk_mhz = min_fclk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[min_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[min_pstate].Voltage;
+		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
+		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
+		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
+			clock_table->DfPstateTable[min_pstate].WckRatio);
+	};
+
+	/* Make sure to include at least one entry at highest pstate */
+	if (max_pstate != min_pstate || i == 0) {
+		if (i > MAX_NUM_DPM_LVL - 1)
+			i = MAX_NUM_DPM_LVL - 1;
+
+		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[max_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[max_pstate].Voltage;
+		bw_params->clk_table.entries[i].dcfclk_mhz = find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS);
+		bw_params->clk_table.entries[i].socclk_mhz = find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
 		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
+			clock_table->DfPstateTable[max_pstate].WckRatio);
+		i++;
 	}
+	bw_params->clk_table.num_entries = i--;
+
+	/* Make sure all highest clocks are included*/
+	bw_params->clk_table.entries[i].socclk_mhz = find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dispclk_mhz = find_max_clk_value(clock_table->DispClocks, NUM_DISPCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dppclk_mhz = find_max_clk_value(clock_table->DppClocks, NUM_DPPCLK_DPM_LEVELS);
+	ASSERT(clock_table->DcfClocks[i] == find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS));
+	bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
+	bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+	bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
 
+	/*
+	 * Set any 0 clocks to max default setting. Not an issue for
+	 * power since we aren't doing switching in such case anyway
+	 */
+	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
+		if (!bw_params->clk_table.entries[i].fclk_mhz) {
+			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
+			bw_params->clk_table.entries[i].memclk_mhz = def_max.memclk_mhz;
+			bw_params->clk_table.entries[i].voltage = def_max.voltage;
+		}
+		if (!bw_params->clk_table.entries[i].dcfclk_mhz)
+			bw_params->clk_table.entries[i].dcfclk_mhz = def_max.dcfclk_mhz;
+		if (!bw_params->clk_table.entries[i].socclk_mhz)
+			bw_params->clk_table.entries[i].socclk_mhz = def_max.socclk_mhz;
+		if (!bw_params->clk_table.entries[i].dispclk_mhz)
+			bw_params->clk_table.entries[i].dispclk_mhz = def_max.dispclk_mhz;
+		if (!bw_params->clk_table.entries[i].dppclk_mhz)
+			bw_params->clk_table.entries[i].dppclk_mhz = def_max.dppclk_mhz;
+		if (!bw_params->clk_table.entries[i].phyclk_mhz)
+			bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
+		if (!bw_params->clk_table.entries[i].phyclk_d18_mhz)
+			bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
+			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+	}
+	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
-	bw_params->num_channels = bios_info->ma_channel_number;
+	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
 		bw_params->wm_table.entries[i].wm_inst = i;
@@ -671,10 +729,10 @@ void dcn314_clk_mgr_construct(
 	}
 	ASSERT(clk_mgr->smu_wm_set.wm_set);
 
-	smu_dpm_clks.dpm_clks = (DpmClocks_t *)dm_helpers_allocate_gpu_mem(
+	smu_dpm_clks.dpm_clks = (DpmClocks314_t *)dm_helpers_allocate_gpu_mem(
 				clk_mgr->base.base.ctx,
 				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
-				sizeof(DpmClocks_t),
+				sizeof(DpmClocks314_t),
 				&smu_dpm_clks.mc_address.quad_part);
 
 	if (smu_dpm_clks.dpm_clks == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
index a7958dc96581..047d19ea919c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
@@ -36,6 +36,37 @@ typedef enum {
 	WCK_RATIO_MAX
 } WCK_RATIO_e;
 
+typedef struct {
+  uint32_t FClk;
+  uint32_t MemClk;
+  uint32_t Voltage;
+  uint8_t  WckRatio;
+  uint8_t  Spare[3];
+} DfPstateTable314_t;
+
+//Freq in MHz
+//Voltage in milli volts with 2 fractional bits
+typedef struct {
+  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+  uint32_t VClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t DClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+  DfPstateTable314_t DfPstateTable[NUM_DF_PSTATE_LEVELS];
+
+  uint8_t  NumDcfClkLevelsEnabled;
+  uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+  uint8_t  NumSocClkLevelsEnabled;
+  uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
+  uint8_t  NumDfPstatesEnabled;
+  uint8_t  spare[3];
+
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+} DpmClocks314_t;
+
 struct dcn314_watermarks {
 	// Watermarks
 	WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
@@ -43,7 +74,7 @@ struct dcn314_watermarks {
 };
 
 struct dcn314_smu_dpm_clks {
-	DpmClocks_t *dpm_clks;
+	DpmClocks314_t *dpm_clks;
 	union large_integer mc_address;
 };
 
-- 
2.25.1

