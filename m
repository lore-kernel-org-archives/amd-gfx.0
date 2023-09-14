Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B0BEE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CA310E210;
	Thu, 14 Sep 2023 02:01:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F3E10E210
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLU0L18P2W6xyoF8wqGuPjmrZzbNTsgizOMqbl0NgWHIiv3ehY0VlZj5+aoSW63Eqzt4FrdTwy66O5c89XUojdhWEQy1sy3HqraGwevdZpWPL0niKtqVhAxvwEPDLPYDY3OzP5Sj+hoPwMflrhihS7Lbn5z3QaimjDYzMHASFFE8McyH+gJCwxasejGcHWmhpsc4wOQfxyG3dXlEvLHDv00N+4+AWMHPfbo9cdYuAs1PucKwY/rWaJfvAL9fJG6lFReNXTsAETPzzLioi2hIfHRG6PtmKVUut0YkO1jtHgofSlbPjDOemLmXAwYGdeOirLrdacWppwXkrZfTLp547Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vx5YyPycCnGxa2KY/E6iKr+ml0nb/zjNx4gVFrSG/g=;
 b=buMixiRIOhytAhxnM9hVMAghF7qMIFGDL6IvE3RjewESOq6dhDiZox0gj2r9jCcK1SUf/v3JLfPM+zcef7CagsAA2t0ZCbNSso/aMNKbTskWi9yI+297+JOV3xh8lnsfm20Hu+Yv+jFUHK0PJC5ts41l2+Zn1TxyPMKkMVQOdvOcpIt3SsyHdfiFCjtsYZPxJDP01xrgoAqU6TbgrJUhuSANhUvLgN8k0y7tzWSj5Ryd1RN6ZUIGGNZGtcDMl39UEyd5MeCocJiryyUkHXH3ZHhVb2F7IuVoz3XlXsLnv99s67t6IWzxW8vfWyMKZngGEtdMM9PMOo9eR/PYu2rSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vx5YyPycCnGxa2KY/E6iKr+ml0nb/zjNx4gVFrSG/g=;
 b=DrLSseBu7CME4y1LT3yQsKaQYHBwHQxP9Wvw4X73+SEyVLlLfi8T9isaTTqpLBBuZ/JtP5IcUUZC2xTn3dpc76yal8k865F+suNJem2D0IcD5PSYVF+LpmwHYjhZo9KoXUDddumd5/BlFIRvJU70jM7Jh/rfyb6lJyrFxxWlINg=
Received: from BY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:a03:1b8::16)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 02:01:22 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::15) by BY5PR17CA0003.outlook.office365.com
 (2603:10b6:a03:1b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:18 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/28] drm/amd/display: disable clock gating logic
Date: Wed, 13 Sep 2023 19:59:55 -0600
Message-ID: <20230914020021.2890026-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d140479-77f5-4698-e236-08dbb4c67e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ/HE7tgmAmEyrs3H+axtSBvfcos3YerKUoxXzZx4wIleycfl18D6t9IDDiofkI6Mr/b7zaEYcZcyJJbyI3y76HP5/gUSD+PzUx4THpdVCADCbBjIwlnGDMIYlZlBDUMhAm5v7SqE12Hs2F9AaHhG8ivxDZ2mjV1hlEQ6gwGl7RpB3nkDDwvAdnlQzRyyzCYE5gBd7IDJ6oCQw5guxo9+LFw9Pa02be/cPZHYV1xm7SiSH/tZp8Zhs3fWWmIjhIJEjj/XOEaPgorB2pl4aYT16RsTpu5/rdkqFLdHoWFr2NP2W6vUya1R14gAsd8dXujRqEb5fD78fHIyJ78Txg0TLqF7YDF2dLVD039KdX1OwX6QM2L+x2gcOV5+sk1wltj3I+5XEp6ktzCxWFu65DiqupSieDIpayqlmvFaYh1UVDX0FlwUDoHceM9pn08iGRm/3lHZgUF8vFlBGXqaNf8k28dUeV3UDjvELE3SXhwZvgOSFQOnZFAHjPa7JuTclc68y/XVQ8FJ3mZrZuX/NT1u5tKxCP6LYM1wnAkWvFH/xUGtKYdhw22WgiZHUgYU5ImQDs/EVh5j2hovH1vl+B1QtHr9AvWPp4bloFi22KiGWaUzFxh3s0gO5SfYbIgIoqnC0YHiZjMUOEjka3BJ/QH7do3de5fhjDCjre6dGZXQNWmnyYaBQxlWnjf2Uols5GIILNxjV+uBgdGHfKpyPfOwjfheH4UAacPcjVGf93U0kRMeAd5NANdWiu8ayc94mHyESaHU6crTG69FKKLtJCTBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(81166007)(40460700003)(86362001)(40480700001)(356005)(4744005)(83380400001)(4326008)(2906002)(82740400003)(36860700001)(5660300002)(478600001)(41300700001)(316002)(47076005)(8936002)(8676002)(2616005)(426003)(336012)(16526019)(6666004)(26005)(1076003)(6916009)(54906003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:21.3664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d140479-77f5-4698-e236-08dbb4c67e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

Disable clock gating logic.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
index 895425e03247..458aac24778c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -484,8 +484,8 @@ static void hubbub35_init(struct hubbub *hubbub)
 		/*REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);*/
 
 		REG_UPDATE_2(DCHUBBUB_CLOCK_CNTL,
-			DISPCLK_R_DCHUBBUB_GATE_DIS, 0,
-			DCFCLK_R_DCHUBBUB_GATE_DIS, 0);
+			DISPCLK_R_DCHUBBUB_GATE_DIS, 1,
+			DCFCLK_R_DCHUBBUB_GATE_DIS, 1);
 	}
 	hubbub35_set_fgcg(hubbub2,
 			  hubbub->ctx->dc->debug.enable_fine_grain_clock_gating
-- 
2.40.1

