Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DEDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68A110E68E;
	Fri, 17 Dec 2021 21:24:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF74A10E651
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/BmzaTDlr7nNbnSJ631xZ3oBRvpm/9YmzQJpFaDTQv18jVA+u7NvFSHpwSit/4nmESVc1mKJS801nIzSNSSBXmyRRREEu+QzArJ7IKNo8bdteTfSW2BGUOjqWESu0wii5mH9rweZXonSd8wV9ALqWZve8+izIpU7ys29UHpv2I2LOyKMF0E2FyZg8HqDomGCDKaPvwykEOJP/vg+7fQRlClxpyZs9Jp/+qdQbXjfjsYqJelQrojXoc+cAjiGSMV6oTQzgBpF1uuEpcK7VlqG9Z5n4m2vLVa/TSfbBsWBfpG16+koN/W+23FPL8jeLBeSKM1EhrKXoCFuqnKvAPc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J90FEMkk5WXU4uT4Is9qaju/X4tdicJLh0U4zDlGpAA=;
 b=J/LmOn41paopHCjkkxEcV9lj7rLgYtPqPf7P2zybnRGHZwRExCq6VIthADrzSa35Fpkp8cibWra45VMk8lvE7//w6mYFIBB2DAvsnFU+RgzbvL2pYP6wggSRJzrt831jXgaYqmbVXZdrmk50VOeZ2REBiHK+43m8WddzOpJ53E3T2et1TYvZxNhAroVdC17psaOWW+vxPIx2jTsjnRAo0WOMwrCU8AucuunLHH2PQLieku1ImpEojGay32eioAk+xuD//nb/xAXkwDXCWmGFX/pT7oJEEnZktKJ8YAlqiUporMOCmCdLBmXFPfd4LGq8kINUC7O8y6sP8uX6wuRL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J90FEMkk5WXU4uT4Is9qaju/X4tdicJLh0U4zDlGpAA=;
 b=NdTrK4tlP2oMQtCrj6RbVg+/0nEUGRP533ghd9nfn/zAcMT0tcV+btxnC4VWfpiggOcf5c1hQ2qnrEpF5wFvU6AgImDVC2Ox/HNiuB9VdEJfHF5lEtsFyLMU/PC4JiAq2G8glJAy+pt2kcT1VOUYByxcGUzHtlDtZa1uAq1UxM4=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:24:32 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::16) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:32 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:31 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: Remove CR AUX RD Interval limit for
 LTTPR
Date: Fri, 17 Dec 2021 16:23:56 -0500
Message-ID: <20211217212407.3583190-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26760536-7686-4781-3567-08d9c1a39e24
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5294572ACB8AE3594B77875B98789@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiBhKi5RzXKTaSURRiBJF/Zx1yA+/XvEZSGfJXrM1KivIovVrxdYIgLWgk9hTNEquDR22bffKnQ3XR5dupoKZw3oURTg6qEsegHcBHWBhE+kBqms5Ci9Ez/ViJ7yKoBEZZRYk2FF0eRFdsHUO5RY92uGlfMXUC2u4NOexy60wb6eRsyP+z7LZeSv/O+VC9mHljGYfJcXGDsYJlX1yKq5Glf/sy1Mh5Oq14UDjETRR4MWAo6DhhxXB68wyzXOXBhyGJJtP+2gHePQL5viVyrSKWe+7zJg6rmfNLItYCW2CPSfWUSwukm6YGeTGeD/vNtmYmy2aJ8CA6aNnvwyy5sSuzSriJ4xIYJgSxYMVgvKB/dWx551DGU1SEETGs322EyZCrhfNQp06S0HDBjeGypNQ4g6yW/hF+OKatZWG9X7JJCj5s9RRZG9eWQBRJrShOgBYpRmGCvmDqSrR+2VBC3EHYT6gk9H9nSM7ggJrmYZQp2G9366mvP0//Kih19+O56JWtkBnfOyI/uO15M46/DvpFtTkyRuKA2Jiz3rLBviExn5akd+abmcTdoCIu5LBUPQQWbkVPeNdeebmUZf049z2AxgxUhR5t2t0tKP9rTsdqvlDgVuCN6AiU+I54ucfDO+JgCNOOtflH4ynlisptvgWFh6qC+9ecp+r5cHpYZjSgnCQNdm9Gn4AvMHKwQ4wrmZLbqpuClURIVk5xNbeuqSdvS79kLfGotl38RU8ZXXdanBpqKWKToqoywrKV/dAQRoD5rIQ7egeFC1pgn7fWBImwuaMcS1bM2iLRkZy2h1j+4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(2906002)(83380400001)(316002)(47076005)(336012)(8936002)(8676002)(36860700001)(86362001)(4326008)(70586007)(5660300002)(2616005)(36756003)(54906003)(426003)(6666004)(26005)(6916009)(70206006)(16526019)(186003)(356005)(81166007)(508600001)(82310400004)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:32.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26760536-7686-4781-3567-08d9c1a39e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
Cc: stylon.wang@amd.com, Wesley Chalmers <wesley.chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
DP spec specifies that DPRX shall use the read interval in the
TRAINING_AUX_RD_INTERVAL_PHY_REPEATER LTTPR DPCD register. This
register's bit definition is the same as the AUX read interval register
for DPRX.

[How}
Remove logic which forces AUX read interval to 100us for repeaters when
in LTTPR non-transparent mode.

Reviewed-by: Wesley Chalmers <wesley.chalmers@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 04878817e622..9dc99929b0cd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1544,9 +1544,6 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 3. wait receiver to lock-on*/
 		wait_time_microsec = lt_settings->cr_pattern_time;
 
-		if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
-			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
-
 		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
 				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)) {
 			wait_time_microsec = 16000;
-- 
2.25.1

