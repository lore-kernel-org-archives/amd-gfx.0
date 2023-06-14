Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4A3EB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC64110E15F;
	Wed, 14 Jun 2023 17:58:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78CB10E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efqJ/luPK6Aa03EezDtTlT6hEmXHQt2Kc4So6TuRmjz0Si+DNMDSQ9Ze5GqL9hjZ0uzH+jYwxCa5dOIHCdNIvswiU/NXXuukFh1nrIWt5xzafPUUNVkhkz5AJ63aca4KASkutO6cJaAZv58S+4cp8K8URv4gBys8GDdsZmKgpw0pC2481WEgrtH6GpZPq+kIOazXSENhNEJId+AwhKuxqc3H3h9Q/6K7H6zxOBY4gtb1vI1OLjEX/qdA86VxNJ6hVufz2gAbTxGE4j/HX3AMbI3M9KqCZ4vvJBmJoGIJEXcNffPGe8hMYFNoiz1Hitb4hokEvJpxJgWHKFGcaSDouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQJtpXWWtpFLKS3lbDkoV6RnH5gpYdWBSUWkLA3E5oA=;
 b=a3SvA2MFEEqLTXCkpVhLi71K/CJ0qX1tr0O5nNjQhAgShs1NU+vzqNDK4Qo2khmdJvfyuc7YIA2wm2ARDjQYRKaS90pBRw1z8RCmmYQtpaN8oy7eHfLXNMHLKwY0fvf9MOJmh00Hp8UXyfVjQIstna2h2msERO+8k2aju4Xd1bhivfBO14BlK8Rj8zED7q09XLyTvh2GZmNgDotRKeUuf8gzFq504bKvkJw97E27XdNHbpMMl6uY/Rjr78kFXk/wLtpj+WB/V75nyI0/LKcpb6uLN1YR6b/Mza125933jj8kKgxo/HWgbzocpZuymcOemv0bGLHG/sxnhb1WZr4nUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQJtpXWWtpFLKS3lbDkoV6RnH5gpYdWBSUWkLA3E5oA=;
 b=lJ1qOrTNqIhqb9y0ArUFQ/SVpjomW8GfctGsYEBN9ZgmMgbig0FL7ID33o6+Ks5gNFT3WGKXysZfrDkNBOCic8mFjE79/ZGd1LgEtdesC+cRUV5klZK7E/Eg5IZ1o6jX8pH3UBzIacXhHyaLXq39miRdT70bQ+oUnL5bp23z0qc=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:58:38 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::7e) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:38 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:36 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/17] drm/amd/display: Enable dc mode clock switching for
 DCN32x
Date: Wed, 14 Jun 2023 13:57:49 -0400
Message-ID: <20230614175750.43359-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 93708314-57c9-4543-d80e-08db6d00fb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPemjvh6Q2goyoXLR9FZyf/N/6+4nybGvkkacR/atIoaPa8VB4kmaYo9tu8WcTrEjyc0NKSFtFQYJTzsXpuOVRuAR8z0Bj7cnuALV3kN48iJ8VBQ4AE1FcbvDIPQzGVdxE6HdKDi+IpOSYDs13oX/ltnOZ0QVHu5ni/Kz7Pe4zeRa+iLkpt+PEZN+xMf4JCqYioQooQG0ALYH8bmhR+KarG1NFL7XbO0Eu70hklmMBTxigL3M4XGxBEKQzfRvrj+C2lJUrW4eZZ/XrmCdY2+eGlVbk7dlxh7ili2B5n0KZ/mCynAj6+EYcZ5NIbn+IwTC1qV8w4Gyxfx1wBH1WGLpyU/acI1I+umlFA7QhqGVeMKJA0bhT4M1CH40+kgEGOdg9klA87zHKOdyojbSpHsZaFbxLK6kQyjktEwuSLmGsfYHFd/RKfmBUMG6iA543AxpedCaS9RAtwpiGkR8Nwt8VFuDKDaMIDFNP9F2fh3TMHyoY1xoGp4/i1fK2pSsqqPnaPNzZqJZKH01/GMrBxlXqBge98iRaLIyjn/jyiTemXHeAaZOIoJl+1lHvxCz3D8U5xXM6jTzIk/usFhOmQra8xaYWvjDmQGZAqKLb9Qg0Jo3Mtrs/h6jHFqgp4IeUAR9U7UvnApx6U23HKCsNzolapp/q53RPcaVuoyRtiYe1hWcskn4iFv+9KOxCG5XLFaUA0aX+3Xf9Ic7GSA4CalHhvEkk3ZfMxwObQIWXeJcnVgzagbWGxG6d9x1NSlvm5dX0jU7GidT7QdpFlRhyMr8N1fU7x4RDHJT3f/8ogSQFEwlAd11SowjYkfembhDb6w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(36860700001)(426003)(336012)(47076005)(83380400001)(4326008)(70206006)(70586007)(26005)(6666004)(1076003)(478600001)(30864003)(2616005)(54906003)(186003)(16526019)(86362001)(40460700003)(6916009)(44832011)(8936002)(8676002)(2906002)(5660300002)(36756003)(82740400003)(356005)(81166007)(41300700001)(316002)(82310400005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:38.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93708314-57c9-4543-d80e-08db6d00fb21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

- DC mode clock switch interface was previously only executed
  for DCN303. Enable it for DCN32x so that the interface is called
  correctly
- Assign function pointers for DCN32x that are used in the dc mode
  interface
- Update the dc mode interface to work generically for each ASIC
- In update_clocks, make sure to consider softmax if we're in DC mode

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 43 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 9 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 96fa68f166e0..402340f17a3a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -541,9 +541,18 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
 			/* to disable P-State switching, set UCLK min = max */
-			if (!clk_mgr_base->clks.p_state_change_support)
-				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
+			if (!clk_mgr_base->clks.p_state_change_support) {
+				if (dc->clk_mgr->dc_mode_softmax_enabled) {
+					/* On DCN32x we will never have the functional UCLK min above the softmax
+					 * since we calculate mode support based on softmax being the max UCLK
+					 * frequency.
+					 */
+					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+							dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+				} else {
+					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+				}
+			}
 		}
 
 		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
@@ -808,8 +817,7 @@ static void dcn32_set_hard_max_memclk(struct clk_mgr *clk_mgr_base)
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
-			clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
+	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, clk_mgr_base->bw_params->max_memclk_mhz);
 }
 
 /* Get current memclk states, update bounding box */
@@ -827,6 +835,7 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 			&clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz,
 			&num_entries_per_clk->num_memclk_levels);
 	clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
+	clk_mgr_base->bw_params->dc_mode_softmax_memclk = clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz;
 
 	/* memclk must have at least one level */
 	num_entries_per_clk->num_memclk_levels = num_entries_per_clk->num_memclk_levels ? num_entries_per_clk->num_memclk_levels : 1;
@@ -841,7 +850,8 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	} else {
 		num_levels = num_entries_per_clk->num_fclk_levels;
 	}
-
+	clk_mgr_base->bw_params->max_memclk_mhz =
+			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_memclk_levels - 1].memclk_mhz;
 	clk_mgr_base->bw_params->clk_table.num_entries = num_levels ? num_levels : 1;
 
 	if (clk_mgr->dpm_present && !num_levels)
@@ -894,6 +904,25 @@ static bool dcn32_is_smu_present(struct clk_mgr *clk_mgr_base)
 	return clk_mgr->smu_present;
 }
 
+static void dcn32_set_max_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+}
+
+static void dcn32_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+}
 
 static struct clk_mgr_funcs dcn32_funcs = {
 		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
@@ -904,6 +933,8 @@ static struct clk_mgr_funcs dcn32_funcs = {
 		.notify_wm_ranges = dcn32_notify_wm_ranges,
 		.set_hard_min_memclk = dcn32_set_hard_min_memclk,
 		.set_hard_max_memclk = dcn32_set_hard_max_memclk,
+		.set_max_memclk = dcn32_set_max_memclk,
+		.set_min_memclk = dcn32_set_min_memclk,
 		.get_memclk_states_from_smu = dcn32_get_memclk_states_from_smu,
 		.are_clock_states_equal = dcn32_are_clock_states_equal,
 		.enable_pme_wa = dcn32_enable_pme_wa,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d0e9ada594c5..22becb40aecd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4767,15 +4767,17 @@ static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memcl
  */
 void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable)
 {
-	uint32_t hw_internal_rev = dc->ctx->asic_id.hw_internal_rev;
-	unsigned int softMax, maxDPM, funcMin;
+	unsigned int softMax = 0, maxDPM = 0, funcMin = 0, i;
 	bool p_state_change_support;
 
-	if (!ASICREV_IS_BEIGE_GOBY_P(hw_internal_rev))
+	if (!dc->config.dc_mode_clk_limit_support)
 		return;
 
 	softMax = dc->clk_mgr->bw_params->dc_mode_softmax_memclk;
-	maxDPM = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz;
+	for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries; i++) {
+		if (dc->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz > maxDPM)
+			maxDPM = dc->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz;
+	}
 	funcMin = (dc->clk_mgr->clks.dramclk_khz + 999) / 1000;
 	p_state_change_support = dc->clk_mgr->clks.p_state_change_support;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 26d05e225088..812f39223238 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -416,7 +416,7 @@ struct dc_config {
 	uint8_t force_bios_fixed_vs;
 	int sdpif_request_limit_words_per_umc;
 	bool use_old_fixed_vs_sequence;
-	bool disable_subvp_drr;
+	bool dc_mode_clk_limit_support;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 6d9761395288..45956ef6f3f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1190,6 +1190,7 @@ static bool dcn303_resource_construct(
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 
+	dc->config.dc_mode_clk_limit_support = true;
 	/* read VBIOS LTTPR caps */
 	if (ctx->dc_bios->funcs->get_lttpr_caps) {
 		enum bp_result bp_query_result;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index 2d604f7ee782..ca5b4b28a664 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -179,6 +179,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_setup_interdependent = hubp2_setup_interdependent,
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
+	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp32_cursor_set_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index c2490e16a66a..777b2fac20c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -56,6 +56,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
+	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index c94dec042cc3..1cc09799f92d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2215,6 +2215,7 @@ static bool dcn32_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
+	dc->config.dc_mode_clk_limit_support = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index ca409a441953..a53478e15ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1756,6 +1756,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->config.dc_mode_clk_limit_support = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 6faf40fa5c69..ecb7bcc39469 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -230,6 +230,7 @@ struct clk_bw_params {
 	unsigned int dram_channel_width_bytes;
  	unsigned int dispclk_vco_khz;
 	unsigned int dc_mode_softmax_memclk;
+	unsigned int max_memclk_mhz;
 	struct clk_limit_table clk_table;
 	struct wm_table wm_table;
 	struct dummy_pstate_entry dummy_pstate_table[4];
-- 
2.40.1

