Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B71C4321E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6204F10E27A;
	Thu, 24 Nov 2022 21:14:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C3710E279
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqtFFD61CW4P0kBipUGUzRMj/GMwdhBqf0y7y9b4j8WFyq/goubksdqmcWs68DPcqOB3BI9ucmQMoCuuHAq9sakGxRrIDuIsIsVkxu05fVj8f0jABDrIjPtxmDNvlNDMwe9gejr9RxC90yxKdxBSQl5Fl+BdynT8rUDDVgxZizciotf55tqxHeyCYDdOrS/ZIkRcJrX+KrOjT5GgbYYWcojWaJw5ACBomPl4cuZTYZPfwhqNBKtBUi0du4bZ0mUMEUoAcTmEf5Jcd2TZCONq3ggOrwDKrz01l90rdAugT6yZ50nN0B2fC47ao/9pZ0kWoVmPVuTcIWmGXykRklnldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D034fIFVFpjmAFNYnpVritEEPcKuf808gIIYJtPBPQE=;
 b=MRZfh7Bn71r6dNCDqeQi6Jnq+nFZDYs1Bag6h7Iuhtwe3169wHcPNfkGM7/1Xdz1TcPQe1+WHdFOPKPsxD2Q+sfi3bIMJ5eKnNgityPil/u/Qgn+iJhx+QMDsGHtGYLAiV9Dqzc0OlFldfQbXKjQVX1RSrF9W3FVVc8VHDQXMPvVTU7oVSz12Soz6UasO1dJnR81BKKKQJw7E6XUp9dnrJK7BUMph3cPS4AFBkGp61TCQQiaCLX5oO/t/MaPY5ppL3dqPkc24Oi8czS/nhOLWYQe8j7bjv/naQ5C7l31U+0rMOWrNmT3J7icwoeFz8ATuQMb9YdbK+5NvA24l+pQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D034fIFVFpjmAFNYnpVritEEPcKuf808gIIYJtPBPQE=;
 b=JJQutL+a05oxN4RpjN0++0Dj1ck0HAeY/4aDoSOpKgiKoEy+5BDwGm8R30MM8NCE7UhDMlG8JIwydmxHaQ/Bg3H32CHEK7r7ZeXme9pZ+G0JNOToZH/AXaUSwXEAjCR8EhnwJB92hn8Z0VnXk1UZER1kFZ4YvTMAJAEvgaMpoXg=
Received: from BN1PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:e0::30)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 21:14:14 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::90) by BN1PR10CA0025.outlook.office365.com
 (2603:10b6:408:e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 21:14:13 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:10 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: Fix DTBCLK disable requests and
 SRC_SEL programming
Date: Thu, 24 Nov 2022 16:13:46 -0500
Message-ID: <20221124211348.214136-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: cf588307-0088-4b2e-d9d0-08dace60d6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raFrxNOL249PgsPfvkybPB4noe1QpWX0qpaiXMrL88XXNcO8wns7Dl0XBZr4ZSv9m31yx3xcjClImZUmKosTnNXDucyWlbqE7frDmCtjeIMdKC6nfZE8ROSsmoYn45iR5+vClkU/vJBMuNXqOehEgLtdDSyN6Xh5ctM92N/PSL5BwZo+dydNkMg1w4cPd/X34FsRaRYiuTGgB5Dk7PVd5W5KggMpxrZVdptzETffTW8uyJXgJVq6juYOPbi7V7+Rav1+wPIiLp9QRrwo3l0kC1iKatS5FUweIzOJBsyKPuCA5rqngrT/JbvbrTgJHtOFtW3rMJY96UpjWQreOVShAmopg986JYZNV7bo4A4Id5PK2FZzUzMMA1kmIELvfgHIQtfFTb2zxq6BG/rz0140TgKMkwV5GHVQv8HxZNeek1DlNcdnIivx+F9R0DJXhaFCJ4Fy0xP+pR1ZKlz4CWD9I49PwC4wI8pYopv2I/VzITgQ92WG/uQb1BNcC8J49uwjEo2xYKUb0Qt0/MbCwpV7WV3h57MCIOu7E8tc3rZu6gGyBTbzeppYgUZL590R81qpV/bF7BslZp/9dy8msTalrRcv/ZdrT8F0zxTua1ndKDpSFVLxYXRxPcohgL3RMECmkqy5mBeAADaizyg6nh26u50SVyIY5pE8KcBFzU+ydVNpp/BjTfxrtj/vYbn63P8q+H2fTpiSMGYoERWMJ/5O9QZy/mxx+Xg9tVlhmN4KVjY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(356005)(70586007)(82740400003)(36860700001)(5660300002)(81166007)(41300700001)(36756003)(8936002)(2616005)(4326008)(83380400001)(70206006)(8676002)(54906003)(2906002)(426003)(316002)(336012)(6916009)(186003)(16526019)(1076003)(40480700001)(6666004)(47076005)(26005)(40460700003)(82310400005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:13.9712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf588307-0088-4b2e-d9d0-08dace60d6ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When transitioning FRL / DP2 is not required, we will always request
  DTBCLK = 0Mhz, but PMFW returns the min freq
- This causes us to make DTBCLK requests every time we call optimize
  after transitioning from FRL to non-FRL
- If DTBCLK is not required, request the min instead (then we only need
  to make 1 extra request at boot time)
- Also when programming PIPE_DTO_SRC_SEL, don't programming for DP
  first, just programming once for the required selection (programming
  DP on an HDMI connection then switching back causes corruption)

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c           | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 6f77d8e538ab..9eb9fe5b8d2c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -438,7 +438,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (!new_clocks->dtbclk_en) {
-		new_clocks->ref_dtbclk_khz = 0;
+		new_clocks->ref_dtbclk_khz = clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
 	}
 
 	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index df4f25119142..e4472c6be6c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -225,11 +225,7 @@ static void dccg32_set_dtbclk_dto(
 	} else {
 		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
 				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
-				PIPE_DTO_SRC_SEL[params->otg_inst], 1);
-		if (params->is_hdmi)
-			REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
-				PIPE_DTO_SRC_SEL[params->otg_inst], 0);
-
+				PIPE_DTO_SRC_SEL[params->otg_inst], params->is_hdmi ? 0 : 1);
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
 	}
-- 
2.34.1

