Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E2C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B7910E87B;
	Fri,  1 Dec 2023 13:28:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B755E10E87A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAe9SrQfqjF5WTGp32iBLjjxDHKEGgF+rZ7lMI2qduDPk2ymvUpu8qKJJgdWgj0fFKqQIWAY8BUcowU8XxzMxZ5c94rEH57Wqw7RHhPDtYGgoBnxX5W/etmKd233lc8oUgq7MizSzUtKtt4ZHRPhZHltZMVqAAT9JZ0wmSRwC9Ore2aytUF1ELl9RZ3+vhvO707Sytl55fXWRk5CAiS+wEOW3iUDz6S5HputxgPCIUU8M0I4VJHM/ZNGah2pDSMT+ml1ex5eSQspHbvwcd0w/nX16LYxTpLfS1eOqZtlFu2711j/uT8UpU1QgqGC5uAhMAa7qsK/2vucORyrJ4DOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeTUZVlh5f7xLWFQP2eaRGx1iEb/Tvy8pd8aFWUbq04=;
 b=oGxyl2+kaGgKjfxCNAcAV0QjGmmGd3+TQZTeNrfbUCisINcNbIFax0+nxz8Hm4A36JbdbokpZxazTHPYI4tbaylRMuXXH5z5bLrJjgDYxgK6gEGl1qd2Zfp2IwtRHLFWTc/IiYCziwJ6mvzh3Lar/7Syj9x107dgg52KJeRDX65LBnBfBpwhI3XcNsvRzfPJv4Cm9Qfx/X762KGoglBRRQ3IumfFX3mkMbY9pqfyuSaVlXMNdBddcJUEjcCUBqICLW7aRbgV7nxmG9tBgk9T8VzUMUpUnhzuGMcwW2QKY54RuqR7e+o7DYo4vIwWqknWs4uadT1J+RP+pGn2oZgnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeTUZVlh5f7xLWFQP2eaRGx1iEb/Tvy8pd8aFWUbq04=;
 b=UNIHRLqn43lZoWyZ9V8Yee3Gm1lR+C1XAehc59Gi9eCkZyVaXFhaX87u6goAHSDj39q2sPP2KKwQashCETJXoK6O8fRYXb2rR5x/ph8xpls3e5POo7Hqsk8Ti0Zrc5q8Gzr8ipCjkcRYBGLPfIk6eVw8x+yzaEQN5C6iP6cw5hc=
Received: from DS0PR17CA0014.namprd17.prod.outlook.com (2603:10b6:8:191::10)
 by CH0PR12MB5370.namprd12.prod.outlook.com (2603:10b6:610:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:26 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::f0) by DS0PR17CA0014.outlook.office365.com
 (2603:10b6:8:191::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.28 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:26 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:24 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/47] drm/amd/display: revert removing otg toggle w/a back
 when no active display
Date: Fri, 1 Dec 2023 06:25:11 -0700
Message-ID: <20231201132731.2354141-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH0PR12MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e8e73b-b167-48b8-88b6-08dbf271668c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWtzc8pG2+43UbEhkVEGuQUw7fjr4aUGY2PO8EKFHjUalHtRusPV8rQnMfbQqN8K3VLOCNYlCLjM9kNyJAohWbkfHzZ2tEY7Hbqt1vUqz/3BZkHzAeLp+gPyyu6SpzQcHrxUUoLWxs16eOkZ8/CAVttVRFbB5/QBwBYhTEJJK3uEiYp5hwtjGdWgsW0k5vN5DrAxgJ49vT+vBHyXa1fiIFUqJSM6Lk0uZliF0bYEBRx4/pTAcqoe9Dfgxp2WvSxuTJvzrWvd2RnQVKJoaO9Z+rTYOD0jytURIG9LnMXQpNPdZn8id1EUy6V2Tk5rlDQiPfAAviq2tFP3uq9RSj+JQn5JqzqBjxqyfiGKfA4ssaqGcCBU2+LDH/B8q3xjwQMplBtW1YTWFv0FFmuKdA18PI758bWVmPHieOv3KCUkMUfKlr8l9SVUeOEMERkf9yFVevaVXO5AEeTWop4XCUwHNx3cAGliaRN+rJsWzUtPCX+6QqDrMacekh20zJUMZburfWBVa/776MiipO2lNjSGSSMAyKJRvkyB4abXtV+hDEpfLe08hy6R8Ne4//J5J3uRgQ+7Tt6dQoZWTPTQBX4eTHaMZDejUEPhiRjYUmboRvfaXC9QOy1T5CO6VV6edGvW/Plh1hK5HtwAAeHm4LIHoW4imX+P19RNsEDpnu4d/kfagctDAnxFijisAynyRMCCowjhEhiW3IJK9fj1fN7xRxcpnjYE0ieN1cSOwnkEhgmMU0xqzFHSJXiCk08zHER5Bw2FTel/mhrxFOfju1izMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(26005)(41300700001)(16526019)(426003)(47076005)(81166007)(356005)(336012)(83380400001)(82740400003)(36860700001)(40480700001)(1076003)(2616005)(36756003)(478600001)(5660300002)(316002)(86362001)(6916009)(70206006)(70586007)(54906003)(6666004)(2906002)(40460700003)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:26.7831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e8e73b-b167-48b8-88b6-08dbf271668c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

w/a use case:
- dual display, compliance, toggling between the displays
- switching between 120Hz 420 -> 144Hz 444 and vice versa
- switching between 144Hz -> 60Hz TMDS or vice versa

It'd typically involve TMDS in some capacity since that's the only link
signal we leave the OTG running but DIO/PHY off you can hit this in
cases where you have multiple displays as well it syncs with the first
active OTG, so if you had OTG[0] mapped and FIFO off you'd hit it even
if OTG[1] was mapped and had FIFO

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 10 ++++------
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c   |  6 +++---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 9e0fa01ecb79..439414ef464a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -312,13 +312,11 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
+
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		if (all_active_disps != 0) {
-			dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
-			dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-			dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
-		} else
-			dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+		dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index 786b62ab8d0f..d6db9d7fced2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -475,14 +475,14 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 			VBIOSSMC_MSG_QueryIPS2Support,
 			0);
 
-	smu_print("%s: VBIOSSMC_MSG_QueryIPS2Support return = %x\n", __func__, retv);
+	//smu_print("%s: VBIOSSMC_MSG_QueryIPS2Support return = %x\n", __func__, retv);
 	return retv;
 }
 
 void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
 {
 	REG_WRITE(MP1_SMN_C2PMSG_71, param);
-	smu_print("%s: write_ips_scratch = %x\n", __func__, param);
+	//smu_print("%s: write_ips_scratch = %x\n", __func__, param);
 }
 
 uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
@@ -490,6 +490,6 @@ uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
 	uint32_t retv;
 
 	retv = REG_READ(MP1_SMN_C2PMSG_71);
-	smu_print("%s: dcn35_smu_read_ips_scratch = %x\n",  __func__, retv);
+	//smu_print("%s: dcn35_smu_read_ips_scratch = %x\n",  __func__, retv);
 	return retv;
 }
-- 
2.42.0

