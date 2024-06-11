Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3273FC41513
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA2010E6C0;
	Tue, 11 Jun 2024 16:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UG1X+a3W";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E7E10E6C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmiP26MrKjx1qlwUuisd7mfMViFgq18OlXLTS3WDbxvQ8Ix28yvypujPPRJpTiF76dJ2aRfxqnQoO20FkceFFPK4otMRhUTwiCrITCr4UrK9LPNlKZ02SVj3VWJ+OtPtTaAXYPBF0LMZy3dLKqomOPkWKoOeCnI4GvddJuD/XKcSX4xU/IKDrXlLkq7jUJZfgJIAVQDFWOfngIGy0l7OMqsE6xQCKXnpIgMYLX7ULiuzy/PR6kVll2LEh+zymJiXm63E7+9lte20D8fcOalJ0/+XEYw5PF9Q/Q1dPJwpYoqPiv+Q4ulrH2FicKRWxMvKJboaVkEDJElqel0Bhcwclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMG5sEOiB0ed1yvEPGxm//IVfMMeCwV/nwmpnxz6cNU=;
 b=BGz5c9oPzBqKU6x40bKI51DMXRAkKFYfjaMwbCycp0uokSqRxsqRTBSqWRlad8Neyb9cT3zaxx4Rl9XFTNKK/J9Ya9oogEmJYsKCF8MPQPadZUftbVVmH2UX6vxpeoUp6px8zLOBmkmUV5c6sltIWRUPCkr4U7KphhojpkLMTTHPmYNqNVKX9/apKAU8jJ9QzN311G/FhY4AP+RZt2MUdEuV4YRBk6xY0Q+cFt61UPp7hEQcpp3LU9QKMSuxo4EnMj9SmoIYD3mMKsEo/ijm7YZKM1+x1IJ3TOZKRCcXU8yxfqhIR37o6jDH4TmbG8WhAinrMP0Y7hzALBtYk4xgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMG5sEOiB0ed1yvEPGxm//IVfMMeCwV/nwmpnxz6cNU=;
 b=UG1X+a3WLzRPfBgHz155zr7NGbyH3W8a51Rq1nr8i5PVUkThp9DxICCGdHdE76orcTbo+eGojteL7tI7mcueHpIUZQKmc4CFj23jdzelT/XP7bGhdPbMlDFMlIYr8anSJBVuNRK6AaLNXqTTPoZ9VvKGbssOGT3ueYc1bV942YM=
Received: from BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:26 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::4a) by BN8PR07CA0034.outlook.office365.com
 (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:26 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:24 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Chris Park <chris.park@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 08/36] drm/amd/display: On clock init, maintain DISPCLK freq
Date: Tue, 11 Jun 2024 12:51:11 -0400
Message-ID: <20240611165204.195093-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: a6692d79-1df0-4094-3746-08dc8a36dfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKmob0fphsGnw4ZrjEAZHzHnEQdtCnRfIG5iTCWu4agrJqlEXA6aQ5fZR4Oq?=
 =?us-ascii?Q?pU3jfplOzmgaFH7TrBqkoNqNVb20L6L8S3d2Mf/Agq4VQ2bxjhBqcN9cgbMI?=
 =?us-ascii?Q?gMg2HXfjKK9nI7RbSHykWXRYNlzfVZNbR1Ddt77I9r4RgN1tVDTbWvlJdUZ5?=
 =?us-ascii?Q?ylEi+ST41jjY6MF/yZqmKPufZR/ux/XCWr1XxXgoPLq/E1Anox6yittvrjXy?=
 =?us-ascii?Q?yerp5gzdIGJhul4cjAIP17A1qhp+EtcEs6fk2uuRpnLb3K2BS14h2GUUD640?=
 =?us-ascii?Q?TPa5AGfKnkdtcZsCsSwlwcDWaaI9K+hQgrgifM5jqowltJOFHm5fRteKu93G?=
 =?us-ascii?Q?Te5NPJsMpEQ/uAokKjkypFiOb6JoXlIeAkhbOntfevTO0InMO/628FfwTQ2u?=
 =?us-ascii?Q?CFk0wkLXJrNgzJZNeQwMlrj7PQZx61BcN9lBHjmi70dKcgHnPsjRQwdP6f0w?=
 =?us-ascii?Q?fOb/nEyZoStOHDb/KZ8EMsE2gRO+FJ1z3WxKTmQ/0wlESCc+t+ubkJO6vDPf?=
 =?us-ascii?Q?/aPEPM0Hf64VSxqvx5+3/EW/cjv1MSd0/rGUbtlHnbuHcHD7g5UyKy+kZo05?=
 =?us-ascii?Q?910cE/drvZ38T+2tSqvoqYCEpGL8p73alyXAVm1GpS2Lbod9iZ+09bu7WK7d?=
 =?us-ascii?Q?AAnbmUq+tdGHbzd0o6U3sh/0sT4waUlq8NaD+8fVE3dbE1ZDIvd53fYNAZpi?=
 =?us-ascii?Q?p+cyjLDN0lddp9bzVsFBvP0HqlSGp6pNIFkbSofFOuJdqFZAhMgTNxzruKxa?=
 =?us-ascii?Q?H6NiqkpMriXmPic+sqS8eFsYckT8wrkKgQM+ytTrKVaXaj9CHKHRT5TfRd1m?=
 =?us-ascii?Q?0vFB49Txq7HS1UXodDdvUzcPRI8+pvE9dQkFeHnZEaqgCnPjEhLYsqSA1Bjs?=
 =?us-ascii?Q?r/vXQxmV+U2D4tnrdKzY0y1YSRoJN8lVZvOLzt3Mg+RhnstXhTS5vZFaCHGY?=
 =?us-ascii?Q?SAUwFfi2nodqnTegmcx/rRxvVdynHZW5Ti9XRUluxAvO1lQDUfw/MI98T4FR?=
 =?us-ascii?Q?yA9nIegcTiRq7jpU1/AkrFAAE+TyxlAdQNlBA7f7xMElOSUMnjbwz9IfOI3K?=
 =?us-ascii?Q?iQBYlFvWKTJKV5YOnLvr3H24ORTCaJn7hmCSbReROULmnCEL3p7KHE15gk09?=
 =?us-ascii?Q?R81DJEEgPwnZYVfVqxNVwX+Mro0tTNEC6CfIKgTd78n0mwgBG1HQND3cpSQ8?=
 =?us-ascii?Q?9ykTLgaCUCkHAJZQAk8cn4ePhtYzcoy0FY06vx08VebK6lzvsv9/lcn7ywA9?=
 =?us-ascii?Q?Xtgsraq2ra8hvjqeNsXywLz6N0hwMUURJ4jy1f7j9GKqU8aSSlNgHt08z6U9?=
 =?us-ascii?Q?c9I02mvU5Ow7s8IBJsZP42ktd24fQ5Eh+teRIjIlVFagwFcazQWFw38v/J3r?=
 =?us-ascii?Q?kVMWDeSJji1vNLOY1btdwSypD40koLGjqPtu58Xcw7Lm3g2ZkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:26.3078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6692d79-1df0-4094-3746-08dc8a36dfaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

From: Chris Park <chris.park@amd.com>

[Why]
On init if a display is connected, we need to maintain the DISPCLK
frequency Even though DPG_EN=1, the display still requires the correct
timing or it could cause audio corruption (if DISPCLK freq is reduced).

[How]
Read the current DISPCLK freq and request the same value to ensure the
timing is valid and unchanged.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c  | 17 +++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c   | 11 ++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index cd1c30fa783a..70f06a7c882e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1459,6 +1459,22 @@ static int dcn401_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 	return dtb_ref_clk_khz;
 }
 
+static int dcn401_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t dispclk_wdivider;
+	int disp_divider;
+
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
+	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+
+	/* Return DISPCLK freq in Khz */
+	if (disp_divider)
+		return (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / disp_divider;
+
+	return 0;
+}
+
 static struct clk_mgr_funcs dcn401_funcs = {
 		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn401_get_dtb_ref_freq_khz,
@@ -1472,6 +1488,7 @@ static struct clk_mgr_funcs dcn401_funcs = {
 		.are_clock_states_equal = dcn401_are_clock_states_equal,
 		.enable_pme_wa = dcn401_enable_pme_wa,
 		.is_smu_present = dcn401_is_smu_present,
+		.get_dispclk_from_dentist = dcn401_get_dispclk_from_dentist,
 };
 
 struct clk_mgr_internal *dcn401_clk_mgr_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 4d0c01e866be..e7d6d987e3d3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -57,7 +57,16 @@ static void dcn401_initialize_min_clocks(struct dc *dc)
 	clocks->socclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].socclk_mhz * 1000;
 	clocks->dramclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 1000;
 	clocks->dppclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dppclk_mhz * 1000;
-	clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
+	if (dc->debug.disable_boot_optimizations) {
+		clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
+	} else {
+		/* Even though DPG_EN = 1 for the connected display, it still requires the
+		 * correct timing so we cannot set DISPCLK to min freq or it could cause
+		 * audio corruption. Read current DISPCLK from DENTIST and request the same
+		 * freq to ensure that the timing is valid and unchanged.
+		 */
+		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
+	}
 	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
 	clocks->fclk_p_state_change_support = true;
 	clocks->p_state_change_support = true;
-- 
2.45.1

