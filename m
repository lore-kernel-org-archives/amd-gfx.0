Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C5C43217
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D9010F7FB;
	Wed, 25 May 2022 16:20:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6F310E814
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViFqAdKm+PnfNRuqfqG6J3WQ65cOXBYYKDEOfygK7+hFYnSSW1xmJeHEtqhDXuz/Aq7KcOSW1ho+vz/x+qaXu8xeM6SiWA947tpbsnVDi6IPCgObPcB6NaprbpnXYjenD3QyNAzBaYAt/TOBEv1HA/2Lx8odI0s3R6DHAACPf7uf92zNRB0/ANjxogYDJhewWwFx527oJBFM2/UTb1G1DHhNeQpITUpUQ5BY5H2yPClwykdTtCSZemWIfJ6+j8+1aoyqxYf5DMcnoBG9r4nG8qXDBbWJKSHe6FktTOo6/Xiv8saqvuwIdwW0hPjZg3tcMGGN8beekiDwfvSpLLekgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YNLEjFuE7oepwo0IMYuGh5OS4+8Ra+mMC8DduZ8YLU=;
 b=VilRlD8cC868ebRLuPLn0xJxpMq/jNP4kA+LwPEEgEN5GFsO/zVwch7NMD7zc3ibPQUzUXZZ3ONvQYpwnfHcM8eGtJYJl05kJ6b/zNYjbjEDMspi0Xzqwb7ZCt0c4RkABR5jL6PPV701reJiZ6yHFdCbIDrF7G1AXNwkqiNJDGv2cU5F1sjZBHWcu8q2SPPpEcjcEraIs1I1AS+B5H+cvEBY++4OPOlRoC261Bm3IPVbA1DahCZrz+IZEWR17+ULpRYKl6Tjc7ti4j78jY5vDgl6aXMu64YrmTpccH5+e/a3BjSAE0s7GCLIQuhkTqldG/+y5lidlgLyfMz68oHgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YNLEjFuE7oepwo0IMYuGh5OS4+8Ra+mMC8DduZ8YLU=;
 b=2kNMeo8xQeNnbV2Tnh7KAIP0Z1zOigtP66vfDp8CCuAmKLDuhdIHqhvi8wHDROz/9bRK2XqmPjM2T7un5ZH16qV6YTTXOelkj9UYtlUYiAwuQQZG1wkXR8hgW8zATDew6gTsDPHdaE7A2NmwwVP0e75+pznVxir6sE7zhwLPXwg=
Received: from DS7PR05CA0093.namprd05.prod.outlook.com (2603:10b6:8:56::17) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 25 May 2022 16:20:15 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::2e) by DS7PR05CA0093.outlook.office365.com
 (2603:10b6:8:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/43] drm/amd/display: Implement WM table transfer for
 DCN32/DCN321
Date: Wed, 25 May 2022 12:19:18 -0400
Message-ID: <20220525161941.2544055-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 269b5882-71d4-4f26-9e04-08da3e6a7387
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4154E35D72B65C30C3B987FFF7D69@DM6PR12MB4154.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcU7jtAM7Y+TJCDwLu5Wy4tS2CLk6uLoGN0fAWVxGJhLIhznwOdsjeYdnTWQFnWCDwA7E0TRB95CkzvPqdSK9T9gJKL6hLF1S0j//Zg+2uEZ6mDsYVF+r19prYLjYrcxzs6jBQtjTvRXJe56up6fshRKv82XIEStamONLRWb/Fz0IUcUO29yqTy9tNCbh3ONbliQGi5OD4LZDP77dl9NpQFIISkHhE4HRuHcyJy3PLJutJtYeXgX5WSxERDbSC0eT4sYenCaUrOukEqktBb/+IwcKdzqVi6z+iqqT0zcVzXxM2x4BqP++kcEMXJAd7nJI/DsIilmQdiDNQeScWoim8ZHDG0hU3+lWsnBieMhY3Pdu9BnssliYgC3Sxvd8PIhFMjOurd1RoOZxtQ67Zk+YWd8CvSr6C2KZ7pR9QNY13UlURACZ/wDfGD4BLuX3bRbs0+spXtzYsVmScnQzPwm2A2PU/wH4491i+DeZBcC+Pw6I/CrimXpEBVsxV4eM01Ja3l7BNoo+l2oY6Tv20VEQnH85ljang+dk70/1O0QVGg6h0bYoLGPk/UdjaJBFLgLrww2/rOCdJoAU417skCpCfrELZu9SjYfAClNntcf6N5I9krvUi2NOZgFEsdX7bVIMZGGR6TYa7xty17HEYBLMc/xm1EW4Qv5jpPlJfunEipO7rE0sLYatasmjrrh9Uj0WZ4lwYyQDAONfTaD7S0M6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(1076003)(36756003)(54906003)(6916009)(316002)(7696005)(356005)(82310400005)(2906002)(16526019)(508600001)(36860700001)(86362001)(47076005)(4326008)(70206006)(8676002)(83380400001)(70586007)(186003)(5660300002)(8936002)(2616005)(426003)(336012)(40460700003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:15.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269b5882-71d4-4f26-9e04-08da3e6a7387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Add support for watermark table transfers.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 4ff12b816614..93fbecbc8065 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -444,6 +444,7 @@ void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
 }
 static void dcn32_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
+	unsigned int i;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	WatermarksExternal_t *table = (WatermarksExternal_t *) clk_mgr->wm_range_table;
 
@@ -455,6 +456,12 @@ static void dcn32_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 
 	memset(table, 0, sizeof(*table));
 
+	/* collect valid ranges, place in pmfw table */
+	for (i = 0; i < WM_SET_COUNT; i++)
+		if (clk_mgr->base.bw_params->wm_table.nv_entries[i].valid) {
+			table->Watermarks.WatermarkRow[i].WmSetting = i;
+			table->Watermarks.WatermarkRow[i].Flags = clk_mgr->base.bw_params->wm_table.nv_entries[i].pmfw_breakdown.wm_type;
+		}
 	dcn30_smu_set_dram_addr_high(clk_mgr, clk_mgr->wm_range_table_addr >> 32);
 	dcn30_smu_set_dram_addr_low(clk_mgr, clk_mgr->wm_range_table_addr & 0xFFFFFFFF);
 	dcn32_smu_transfer_wm_table_dram_2_smu(clk_mgr);
-- 
2.35.3

