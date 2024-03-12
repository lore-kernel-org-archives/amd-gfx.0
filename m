Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B60C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3627A11291A;
	Tue, 12 Mar 2024 09:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hlkiC07g";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FB6112758
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iruO2sjC4tGK+k2dSvaEmWshKpJpTLl3QMFS1Cv9ZBkN/hO5oyueJY+xyQ/2miVlkPf9OZwjgwDcxWaXJiHMqdArwdgTxcZtYzFAGR9xTO0i2O5mstipSx56N2pn82UIWGUS07K4rF6CtlBQiebnzATyiRRFNvNsfMH6UD3Ek+C9dhm3rTJlSTMQ3gxKB4jQR9fLNym3NK2+KSE66Ef/c30oR3iWvr3dbsAktsiJ0Jgd9piKYcIA+gQY4bPCT8USe3FxfR3rgMExwePvkMzMaFQaeKPKfSZY8A69+EfB1lth+bL2moCl9ZtQqmMcrh3ESAWdJj7pnRVNIhCkuvePsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXnjZeyGsv5CjQ2XbfeJSEFTZt3zykJOKnnMG+9nCo4=;
 b=ML5v5D8qeC9gGDosZZ7H9tFict37BpW+JPOmUAN9psCq/96nWdbXnZ/8TMJ+5xRPo7n8J96+sMGdJQjYi78RiwTEnGEkn1s9ZAIbFveDuo2LMi2/bHrDuRpR6ZXf199TChvSFVzl/JxpNUMQF1QaHpM95xiqjteMV+g0bFvnrr13uxoojDVyuQa0LKeGUkfO6wqPYEOCIJOo0L5j8CZ1q6QwkOUQWSgdlRPyTjajGUsLm1K0h2g1QU5olu4uz/d7fxUjoCo9AxQt0ujxclnOEOEtuLu6bgl25X7XjN7aqeERtNpOrjabkw0kMxDKkqdKak4ZgDT5m6tPvtzt6pWScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXnjZeyGsv5CjQ2XbfeJSEFTZt3zykJOKnnMG+9nCo4=;
 b=hlkiC07g1/Shfbck7xXvtsS685Pyoi5sFW5hESCTfmEyeWUoqhumbL9dub1bA40lRSz45G5KOmYNS1sURcOnIz3M2Rk86dKaRMWxuPZlls4Gsr2o8xfB/YBp7kh3Cc19ymIRN5zy23XjRwPgKsJoMwzLy+TpIxu+jSP0YQRYcvw=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:21:20 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::db) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:21:19 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:15 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/43] drm/amd/display: Delete duplicated function prototypes
Date: Tue, 12 Mar 2024 17:19:57 +0800
Message-ID: <20240312092036.3283319-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: fa06add6-244d-4cb7-20a7-08dc4275c787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4i1Bphqm+pm586TvbWLUvnw7A1VpbOAuOhMiUi1PDFKttHb2LaKKE8XhtRk4+YKXQHo0xaoEamESFL8G2tNgb5ZWEU1AlwTc4ddOQdKZitTbk1FEnEftt9rKolSw/adj+LZQ4JKZCd19DvyvIonSvB8wx8RWb+BkzSZyXWU3hJvL/Kgd6WBQCl5wUpja2zu7BFiFvtWhJ0+9qXPSmgiHWq6zO6Q36HzeoBtIyfh+wKdzytoL31UcHnQCJwuRbvSOIG+jkr2bTAc/xxrItWobwsOu4qzpM+nM26goQ97zu9CYSQYvbJRItEM+F+P/oyIKRvllyFbKg2EFQZbAaqFF6SFvA4/yw2QFN0itSqf0iNimjvNuVQqnd2lS3nPEzyek1MYSCQH44HZCWh3r1grnEA/Laq4wh2/n4fZkonmMRoXk7MglvUbgvxcUU1ygL0tsyaZZvacMoBA+1VP08Nw5ot9MfBALy9Jtm+3kpM6twZcG7sRy04AIr63kckax98aSfoE7rM3fQEDSDWMywb4ggFE6Dlrra1pESKNQOVGRYoak+7UnPY972GtSkKGOrZJm992Kqpv2cmr+FoIWQJrFgDEc3FHT8WGAkjRzFSI+MHK+3AJmefGkF7dtYpLLGqgcgFjs14677BW0F65tptJR0yaFhvtKgeeeLrNk336ZYkazdg0IJoa4KzVq+ZuVjC26HcWA1MY3mXN9KR81VoL9m9T/Q3Zr1UQrW3KSjnSl311IZp1+h8zRET2XmtPiAJq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:20.4333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa06add6-244d-4cb7-20a7-08dc4275c787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
dcn32_smu_transfer_wm_table_dram_2_smu is defined twice so one is
removed. Also adjust prototype orders.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index c76352a817de..5c44ab0e8667 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -37,10 +37,9 @@
 #define DALSMC_Result_OK				0x1
 
 void dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable);
-void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
-void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
+void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
 void dcn32_smu_wait_for_dmub_ack_mclk(struct clk_mgr_internal *clk_mgr, bool enable);
 
-- 
2.37.3

