Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608BC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500D260FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500D260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111856E930;
	Mon,  7 Jun 2021 16:48:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348886E930
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GijecUkNnL5NcdF5ynIwdxSEc2v0CI0An7YxJb7NhevWEypulWt/Z6hB5zJpihFklF+utMyYJCosSxFRfDSrjdgYLtuf3pxI5OH87JResrs6uGOOvC9sTTdp6EEuQ0sXpUvzAQS2r+OdT/4lqirSzLToTH9iD2Zp6sKuSzRrFyQcVolWDnVX6ARJHS7rNeB9fR8W/iCN97qbzJ1lYYV/zlQCBQ6kQcdjuCqeE48iFf29GY4N523DSTGPKbWvHccjJ6ROirjbQfM36skSDszH6QsKtAnyoZA+uGWUuu1TAXhnLtOuP8qvuZ1TQL+RZr8rLC6rwFnTj6Xo9Vvpqm3dIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oZNCR4Gc09HmsTPLb2PQ/0dJXm7mKqISLOwxPxEpE8=;
 b=hqrm1rWbMwDS91/Y2uudSl31hVxT1O0dIesnFgDIFsCJNPKMBl0CUZygRdgKcpwO0fYg8+FpIjHIjDD6mhGB74sVEZ+8UlGwgyNynMT0SWHu+vzEWRu1Qxs1EvP7wci9CJWOA9kHemEXG848aiuYnvOdM8TP/SNEEvuBUcLSJn2XxVFWVS6MgxMzVVUhP1gAO9ZqU3/D748EFKcJ1F0Bxh65TDWEwHGM/scPQ6DsZosEJZM9k5S38llhyl+y+EYmvYApibz27naj9yzRnHrY915+p+pRbn43uWNwdfIEo+Q3L2ys6buckWIuubSnNu1i9IaG6B85AnoCVgFGHxFQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oZNCR4Gc09HmsTPLb2PQ/0dJXm7mKqISLOwxPxEpE8=;
 b=g4nbhnQK4sf3olCsedkbIFoL70DqHeardjqusczW7HY2AOHuRgleqYlHxnGtiCrx5QT2+yyXqNBF0+Uk74QlxO4G3VPvm0gJ3NaAdwgP/567y/zaA101ujbSuUlFVKR7i1Jm9LDhU+dPwKd9PJPueZBQRWv9PxzUrm86FR4Ps3Q=
Received: from BN6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:404:8e::27)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:48:14 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::ed) by BN6PR21CA0017.outlook.office365.com
 (2603:10b6:404:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.4 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:13 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:10 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/30] drm/amd/display: Revert "Fix clock table filling logic"
Date: Tue, 8 Jun 2021 00:46:52 +0800
Message-ID: <20210607164714.311325-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee8cfc6-5f39-4350-2ee8-08d929d40aab
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50479CF02F1940C4794AF676FF389@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfkefDu+FiUscMQnVSskejB8C8eV2cbVB9oId3VErGP4u6e33niXllyYeA+9gIsrz5N+15DQewA8sQLxxmmmLb3SL5IMGW4eaoav4HB0okS3bcxhwN9brGKrRlDDrRNelSgUjhRMWzbokSDw8zIr6AitXw0IXw9663l6cxzQ1CwwKhz88iGI80lnXTHVD6wIa/RDq2hQp5bc8suuranGgigX0QO1C3lZW99wy/nAJS3D6PzrQOjptROcXykhLXOAtRSun9vLeRXw7wjTJaitTyY58MBzJIwLqHkDbbmMAHr1a9CyZg4A/pxZMnc4FVz1JOvCiEyNpbmoH4DojD/fovVi/jXSaYHAwtf9WpfWPd6nClYX3A8YYS5HhMHtHfcsyTCCOfF09j5e1iYX27GNtWCzROj7sylA85VgpAfrcBrzZ3GQopANeX331FbB+muwI4Eb18wHxs8rrpprYB790D6OD75V/Uo48zKa4t3ZetlJEKv/ezSMERomJx9TraqUyNJ9VR9J9WqQ09UyrG3Kt1uRePyz5aSvJDZ2Vg5VJFSn8/VXMiSgbXw6lurNTt2wFNtG3Epvn4/fmsnvTqB86pyj1vIWfZ4PuXCY0DOMJU700sFbmp21BcQl045fn9djwiBsFvZyTB/kN/mMAk6MZlvn7oNV19E8lInB1EhahBytK/qJ8gn4q2E4Q/CGpAQL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(136003)(346002)(36840700001)(46966006)(7696005)(26005)(186003)(316002)(70206006)(36756003)(86362001)(2906002)(16526019)(70586007)(54906003)(82310400003)(6666004)(4326008)(478600001)(83380400001)(44832011)(81166007)(8936002)(8676002)(6916009)(1076003)(82740400003)(5660300002)(426003)(47076005)(356005)(2616005)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:13.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee8cfc6-5f39-4350-2ee8-08d929d40aab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
 Sung Lee <Sung.Lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
This change was found to break some high-refresh modes. Reverting
to unblock mainline.

Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 78 +++++++------------
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 33 +++-----
 2 files changed, 39 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 416a24db17a9..c6f494f0dcea 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -835,66 +835,47 @@ static struct wm_table lpddr4_wm_table_rn = {
 	}
 };
 
-static unsigned int find_max_fclk_for_voltage(struct dpm_clocks *clock_table,
-		unsigned int voltage)
+static unsigned int find_socclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
 {
 	int i;
-	uint32_t max_clk = 0;
 
-	for (i = 0; i < PP_SMU_NUM_FCLK_DPM_LEVELS; i++) {
-		if (clock_table->FClocks[i].Vol <= voltage) {
-			max_clk = clock_table->FClocks[i].Freq > max_clk ?
-				clock_table->FClocks[i].Freq : max_clk;
-		}
-	}
-
-	return max_clk;
-}
-
-static unsigned int find_max_memclk_for_voltage(struct dpm_clocks *clock_table,
-		unsigned int voltage)
-{
-	int i;
-	uint32_t max_clk = 0;
-
-	for (i = 0; i < PP_SMU_NUM_MEMCLK_DPM_LEVELS; i++) {
-		if (clock_table->MemClocks[i].Vol <= voltage) {
-			max_clk = clock_table->MemClocks[i].Freq > max_clk ?
-				clock_table->MemClocks[i].Freq : max_clk;
-		}
+	for (i = 0; i < PP_SMU_NUM_SOCCLK_DPM_LEVELS; i++) {
+		if (clock_table->SocClocks[i].Vol == voltage)
+			return clock_table->SocClocks[i].Freq;
 	}
 
-	return max_clk;
+	ASSERT(0);
+	return 0;
 }
 
-static unsigned int find_max_socclk_for_voltage(struct dpm_clocks *clock_table,
-		unsigned int voltage)
+static unsigned int find_dcfclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
 {
 	int i;
-	uint32_t max_clk = 0;
 
-	for (i = 0; i < PP_SMU_NUM_SOCCLK_DPM_LEVELS; i++) {
-		if (clock_table->SocClocks[i].Vol <= voltage) {
-			max_clk = clock_table->SocClocks[i].Freq > max_clk ?
-				clock_table->SocClocks[i].Freq : max_clk;
-		}
+	for (i = 0; i < PP_SMU_NUM_DCFCLK_DPM_LEVELS; i++) {
+		if (clock_table->DcfClocks[i].Vol == voltage)
+			return clock_table->DcfClocks[i].Freq;
 	}
 
-	return max_clk;
+	ASSERT(0);
+	return 0;
 }
 
 static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params, struct dpm_clocks *clock_table, struct integrated_info *bios_info)
 {
 	int i, j = 0;
-	unsigned int volt;
 
 	j = -1;
 
-	/* Find max DPM */
-	for (i = 0; i < PP_SMU_NUM_DCFCLK_DPM_LEVELS; ++i) {
-		if (clock_table->DcfClocks[i].Freq != 0 &&
-				clock_table->DcfClocks[i].Vol != 0)
+	ASSERT(PP_SMU_NUM_FCLK_DPM_LEVELS <= MAX_NUM_DPM_LVL);
+
+	/* Find lowest DPM, FCLK is filled in reverse order*/
+
+	for (i = PP_SMU_NUM_FCLK_DPM_LEVELS - 1; i >= 0; i--) {
+		if (clock_table->FClocks[i].Freq != 0 && clock_table->FClocks[i].Vol != 0) {
 			j = i;
+			break;
+		}
 	}
 
 	if (j == -1) {
@@ -905,18 +886,13 @@ static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params
 
 	bw_params->clk_table.num_entries = j + 1;
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
-		volt = clock_table->DcfClocks[i].Vol;
-
-		bw_params->clk_table.entries[i].voltage = volt;
-		bw_params->clk_table.entries[i].dcfclk_mhz =
-			clock_table->DcfClocks[i].Freq;
-		bw_params->clk_table.entries[i].fclk_mhz =
-			find_max_fclk_for_voltage(clock_table, volt);
-		bw_params->clk_table.entries[i].memclk_mhz =
-			find_max_memclk_for_voltage(clock_table, volt);
-		bw_params->clk_table.entries[i].socclk_mhz =
-			find_max_socclk_for_voltage(clock_table, volt);
+	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
+		bw_params->clk_table.entries[i].fclk_mhz = clock_table->FClocks[j].Freq;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemClocks[j].Freq;
+		bw_params->clk_table.entries[i].voltage = clock_table->FClocks[j].Vol;
+		bw_params->clk_table.entries[i].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->FClocks[j].Vol);
+		bw_params->clk_table.entries[i].socclk_mhz = find_socclk_for_voltage(clock_table,
+									bw_params->clk_table.entries[i].voltage);
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 38a2aa87f5f5..8e3f1d0b4cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1575,12 +1575,10 @@ static struct _vcs_dpi_voltage_scaling_st construct_low_pstate_lvl(struct clk_li
 	low_pstate_lvl.phyclk_d18_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].phyclk_d18_mhz;
 	low_pstate_lvl.phyclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].phyclk_mhz;
 
-	if (clk_table->num_entries < MAX_NUM_DPM_LVL) {
-		for (i = clk_table->num_entries; i > 1; i--)
-			clk_table->entries[i] = clk_table->entries[i-1];
-		clk_table->entries[1] = clk_table->entries[0];
-		clk_table->num_entries++;
-	}
+	for (i = clk_table->num_entries; i > 1; i--)
+		clk_table->entries[i] = clk_table->entries[i-1];
+	clk_table->entries[1] = clk_table->entries[0];
+	clk_table->num_entries++;
 
 	return low_pstate_lvl;
 }
@@ -1612,6 +1610,10 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 			}
 		}
 
+		/* clk_table[1] is reserved for min DF PState.  skip here to fill in later. */
+		if (i == 1)
+			k++;
+
 		clock_limits[k].state = k;
 		clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
 		clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
@@ -1628,25 +1630,14 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 
 		k++;
 	}
-
-	if (clk_table->num_entries >= MAX_NUM_DPM_LVL) {
-		for (i = 0; i < clk_table->num_entries + 1; i++)
-			dcn2_1_soc.clock_limits[i] = clock_limits[i];
-	} else {
-		dcn2_1_soc.clock_limits[0] = clock_limits[0];
-		for (i = 2; i < clk_table->num_entries + 1; i++) {
-			dcn2_1_soc.clock_limits[i] = clock_limits[i - 1];
-			dcn2_1_soc.clock_limits[i].state = i;
-		}
-	}
-
+	for (i = 0; i < clk_table->num_entries + 1; i++)
+		dcn2_1_soc.clock_limits[i] = clock_limits[i];
 	if (clk_table->num_entries) {
+		dcn2_1_soc.num_states = clk_table->num_entries + 1;
 		/* fill in min DF PState */
 		dcn2_1_soc.clock_limits[1] = construct_low_pstate_lvl(clk_table, closest_clk_lvl);
-		dcn2_1_soc.num_states = clk_table->num_entries;
 		/* duplicate last level */
-		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] =
-			dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
+		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
 		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
