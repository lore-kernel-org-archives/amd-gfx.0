Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199B4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC6210F29F;
	Wed, 25 May 2022 16:21:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D36B210E625
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWj1aEgkkk9jqg4ZJhy4rJCTDm37dgmZAakeCtMbUzQEjM9DRsesuJvfHVZOKbWh14uXtIvo0Kv58aHXc/KVsHhiRZCqhJ+VnRafvV1ELoyvHmMtucvAj5lAVgMltAxQA0RSsyU7ejwsDSUvXYAeBaLUpDwFd7HbLVslT2QrQkRAlUeJtNAzgBTeGMv+lkOsILSInLzIdUMV0woNRTVXfWIEicVocVhPHI+zYzOhuFr61r9f4zydpiSwQs/BA5mhitZga/rAlGcfBXML/ozuwVa0Qc5m244s9FpqV3a2DVeUxnV79Ii8INEa21S0tLyIbBUuDD5THMedh1llSX4SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCUxC/ZvYC2+ojC2NNrcFlN4ruGZLL9TYHNKNBkUtqg=;
 b=W/ibX6H8lGiZQUxqB/XQLI8h2kFHmJB9flBdLkFunXBYHs02SOeaIVL+Df3+L43Aizfe1mSXHiAAjctZo5ZA16A8YSfZr+GV3NTJxBgmHZ2D2/KsN/Q4TfLuU8sESncQFCZVKJXA4FNejXgb0X48N540G6/3y7uuKJvexmriW0LmAd3vsahkZW0kUzjtedwNjdBqD4NNH/W+ORgm6jqZr06ePSZbXp6zVkpYzpymqE6LBqvREikrMvQMGxLijnOOoMLNVaouj3qyo/8z9mfXzrAOIxE1BaOUvPuc2gvk3C/yneg6qgtEVQw/oY1jMrk+loHEWzMLpBZotUwzOlSJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCUxC/ZvYC2+ojC2NNrcFlN4ruGZLL9TYHNKNBkUtqg=;
 b=umHLbBuL1w2bFRS+rpNsoHl379JSqyWBXuF3JhqwtJ4NOqXt5ceVifAfQdnUNSTvAXk0BbOvJU51cemQ/lrztseRG1ry0mzkOea5FrMNZgtv2o7dh1z17F3wsLoBB0EJD7qnIOWuGwY9nsWbzH45OMGMY3KKWQC0EhH3M4IA71g=
Received: from DM5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:3:d4::34) by
 LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:20:17 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::a8) by DM5PR05CA0024.outlook.office365.com
 (2603:10b6:3:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/43] drm/amd/display: Add additional guard for FCLK pstate
 message for DCN321
Date: Wed, 25 May 2022 12:19:24 -0400
Message-ID: <20220525161941.2544055-26-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c665ad4f-dd10-4494-e4c3-08da3e6a74b4
X-MS-TrafficTypeDiagnostic: LV2PR12MB5893:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB58939DA2FA206BF9685FB360F7D69@LV2PR12MB5893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3Keu2PfdUf6PbuiDILH5WM0TiPR6O1czJwI8Y57dbLfVZr+OltG2IKv7LKgF0bapbeDIZUsVSYsKKE8J6ntYWFtp08YJ6dhCdvuz5WfQwzlcmQb62fuXa9Ag77xzbtwKfn8Lr7kJYlY003cB+UFzG3973t7kBbcxkhABa7XkRJLj00vtj2cfRJ2+wWvSZLR9SVIBLmomNjN6TFLrqrRkUzQsH5XDDzaUGNiV93RBjHyfSdZmB3XHE4QZvEezm1/9Tymo6d1JHLbbAgwCtPYupB4YVji5ok2Gf7X0DJyUsO+/gDY7YTj7NrUe2ALF+SvxCUIsTnt4z/IBQ7MEoHjwnFiTU13DNuScsFqG4yE2dMag57zIG0xk2wicWMIJ/35l7NrdgWJTCXv5EJdxtPk+HatAL8coxNyfpL6SlbL9doPtKCzXK6tDBbCrW2aRMjT2BozxYYCrDkzK19F02687AjT1g4cpuI1jPNd5qmkBVvjudkafRb+qL7fuUN3k1VVovNMxuLJE0Ir/s/ga43cFlT2p38qZL/LojRjQ1ZPGlOIKxX7vj+qYWQKOjNYPQKnb53uwmbRwMengClW8d8n26ELCHv1HuILuMC41rsGpR1/tvvOI9AtQisDe1w2Ouo/DQFpMIkpIp99Pnr6Y4NpvfmMuBH2eUdFTiEDhS0LaTH1OLo2SJb8oL2RxpZSkcbb5I5jwMnVkZ+eSvyPORhvHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(2616005)(15650500001)(81166007)(5660300002)(54906003)(2906002)(8936002)(316002)(508600001)(8676002)(36860700001)(16526019)(426003)(336012)(186003)(36756003)(82310400005)(40460700003)(7696005)(70206006)(70586007)(26005)(86362001)(47076005)(4326008)(6666004)(83380400001)(356005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:17.0876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c665ad4f-dd10-4494-e4c3-08da3e6a74b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 93fbecbc8065..9d2d2cda5543 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -346,8 +346,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 	}
 
-	if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support) &&
-			clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21) {
+	if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 &&
+			should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
 		clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
 		/* To disable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
@@ -368,7 +368,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
 		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
-	if (clk_mgr_base->clks.fclk_p_state_change_support &&
+	if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 &&
+			clk_mgr_base->clks.fclk_p_state_change_support &&
 			(update_uclk || !clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
 		/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
 		dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
-- 
2.35.3

