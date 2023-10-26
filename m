Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA7C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5F110E815;
	Thu, 26 Oct 2023 14:20:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8638510E810
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l//Hm35PzRes/rVKVtfttrpNqi1YnOKUO+iy/5YXCDK2rXPDqrs+7kRFv8az5StEbqJBFyEE3ftSyLAqgpyYWSmw7VBeGEBh5+zJxglTM9XZ7GZERJQSTHyA8gOMeX8PC/ETxf/xyg8xNwInq698pIf3BSh5/eQL3/TmqrOHGR1U1iN0OqGZWaVz45/GYFNloqV9ahawvjJJYGcEOLZ6BzvfIJS8WLEeYRG6z3VEirTybqiDv1O5q7pa25ffeiKO4QheLGzD1RXL7XzTkrQetZWfMf4H6LbkepthhL+ExaZMlVFF67TiI5csn5s7zw6MD8Tby7mf/7naUhNfKvQKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMkoMcGiw3Mw0vQT1EhCqc8NoJB3kO+S6eV3mK5b9pg=;
 b=YcMhgYEKFRHe1YF7g8ByfICtFzTzunMOam/RnecTwHy528K1FAdxzlll2el/b1sWWD11QAcWoC0UPZUWaugzqZYDtAzM60W5tml7PxTdyEMMBchBPeKKObf00Tfp5NYyIIfKRTDm01bdloBBOivW/KI0yB9aLdmFv2KBFRRxQoxrdQm99YTdSmw8MEJPXC1gZWOM6z/Gv6Xglf+H10MIqQWt3BpuLhYoeVbbS/EOYWTx58YBuH0bCTGc19pI73GF66jRWbMnoXadwBuPahi9E1lAfUIh1ejpCTnF2sIrhcc9xvscF/bNltoqQw4rHhkMTR9Vm1y2G7hl35h/04tHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMkoMcGiw3Mw0vQT1EhCqc8NoJB3kO+S6eV3mK5b9pg=;
 b=HTUXg6CUHfLh6QiXSNct7esm7CLXAHmn2kmXsgwA3TK+YvvrWCCpYi4br++EhiW4fC8gBq7nnAoTNl31Q0YtFJ+MMUREFtWdfvY2pYarOM7CfXcJPDItZjy1prnIdbGwH9qtlAmL8gH8tDk646zzOaqF7FBO8o72YpWtBjPQHWQ=
Received: from CYXPR03CA0012.namprd03.prod.outlook.com (2603:10b6:930:d0::11)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:42 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:d0:cafe::f3) by CYXPR03CA0012.outlook.office365.com
 (2603:10b6:930:d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:41 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:40 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/25] drm/amd/display: Fix FRL assertion on boot
Date: Thu, 26 Oct 2023 10:20:07 -0400
Message-ID: <20231026142020.67861-13-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: e391ab95-7a4e-465a-f8cc-08dbd62ebc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+c2+lrMMS5Se0z+towX+oLVMf1w5D2ZYTA9soshE8tj7432STndzLoAFn7i88z6e003UKJkEBwVYTCztPKZHfhVuzv6+dgseYHn+gpPyLFpq4X1EakYTC+0xOasjyoEnTIc2NF6sXIRKVUV2/I9/sYtv4OsEMEKcV/mZZtIxgdw5Y8sj6L84DNfdeZIlHnLYjxDVk1S0v/rZ6R7KxbQrFK1tttIKq3j75qFFuuXTfmO+FDLL4fHvnNOetgFS4hHp8bxwVKoNx2oHulavqCwniUSfAVrj9tOYwjnAs/SYF3QXp41AOTUFNmHWn3TRxccQH7MSkuveDjhRTAOTrzCxGwszihlP0HR3HBqNrusdwtzCfMNYgSE1CE+6snU51hwaqXU0VjCAVFz//SubskY4RjvSKzpOSsySWXQEq0iat9nW0XE4FONxYFl+0guNPQYrPwV5aNmFvC+FBCWFJtszvZle95W3ZHiW1MHTo0EiqyAkC1PUkIws2PeIz9ozY5NjRAyNh+m82PLpL27nxypiWnfqCV6OYu1nve2QI+/5QQJBOG69AXd0lefIF4PFT+WZRGxLi2mxbeXojg4zyHI7jZJFHjfHC9afmIkee5peMlj1y3KwP6u85p/m3HfCy/+zs27b57MQXocqJ6tCenxPl7TFhkLNYpjxpe04tCiTIKmCoqd378itF5hjsOJ/LlyvaFzsP8CFRQgxXDFmB7NY6Ru//c7WBV42bStAUHJARpkqj9dQxJU+pW6jmk0D84Wypmxr+HyzuvitDq/R08LFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(2906002)(40460700003)(36860700001)(70206006)(82740400003)(70586007)(81166007)(6916009)(54906003)(2616005)(478600001)(1076003)(356005)(47076005)(426003)(40480700001)(6666004)(336012)(83380400001)(5660300002)(36756003)(86362001)(26005)(4326008)(8676002)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:42.2576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e391ab95-7a4e-465a-f8cc-08dbd62ebc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Xi Liu <xi.liu@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Make sure to ungate the clocks on boot
so programming sequence is done successfully.

[how]
Move the ungate logic after bios init.

Reviewed-by: Xi (Alex) Liu <xi.liu@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ff46e36cb254..0569fa6f7600 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -138,16 +138,17 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
-
 	//dcn35_set_dmu_fgcg(hws, dc->debug.enable_fine_grain_clock_gating.bits.dmu);
 
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
 		/*this calls into dmubfw to do the init*/
 		hws->funcs.bios_golden_init(dc);
 	}
+
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
+
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
-- 
2.25.1

