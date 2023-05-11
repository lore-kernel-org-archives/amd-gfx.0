Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E79FC77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 15:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520B610E501;
	Thu, 11 May 2023 15:38:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EBA10E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 15:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqa/3EgQUWufyjtvNdfak0rs65zfomX5HFgN6XcIRkvimkvoTJ3YOTKML+jq622IlkaTMbG5nL5mDxLgkrpSaD+rnwf20R1GmC9+jluYQwUXKtnZdA+bFMFFZ5cOGCD8lwemICa9TwoPjXNYt4+q7Q4fithWUEBWpn6RHAL7FSf8Vh565MrckXY049L5aZfbW8hx0aYd4Ihr5xAyiebWJacwEitLdWt2kfS5TYtJm+L+1MIWRVThOFiR1YRALgLxDlXycaBi7oJUhkn/LzOXV8hchb0g6quEQ+aoewaVEtlROGQHyBgGgZa77ewXQwgf0ZXJH2OiuKjq1kGTYpTtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95faIScGKQ5a7Tw0gV9VBnnpGxD++wXRVkPlLjU78N8=;
 b=l14K0H9qIZ12nxvKLZVP8iYygQyQp1//0EuTK0E/gVR78OpQl+a5RMiE5P+/NpJRdTsdg4VvInwBgU0qq2u9Ol8NMjEY17y7Z+S7eHWwRWON4v84VBPiRjJzOOZx3m1WKHF2LLmtnFUlhi/xmZ1Yen/fkdbTC3yOyuMtsLSUo7N50xvPEq2myY8daD/r6NJR9d1+tAFSRmxlYX32UScrFtYh4B702iVLK5kjq+YuYXyDpeBLgaRgL8gqeWC4y0VJHBENPou8P0w/nkhEJLsC0y408OSO9T9IYaFt96AZbmNLPDvhQyFeEs8g+2fMDAcFdSznU8qxH8jnh9Kg2awmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95faIScGKQ5a7Tw0gV9VBnnpGxD++wXRVkPlLjU78N8=;
 b=EeIxxVdMC8OHSi5V1ehpp4Jnp6JqBywUdTPih9FQZ3ecYIuRWcG9M768gMlfUxZRdsHzP8FG/CWxUYQ42glcvMoT7VgrC8uu8u+jqbIbWh66Mk9Se6tR7P46uB0se9PDnZoVRz7h32KJE/GfbtuSHLLzJKbnAyuIi8KdsvqXvIA=
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 15:38:09 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::a2) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 15:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 15:38:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 10:38:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 08:38:08 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 11 May 2023 10:38:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/display: enable low power mode for VGA memory
Date: Thu, 11 May 2023 11:38:06 -0400
Message-ID: <20230511153807.1154612-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
References: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9adb42-9a25-42bd-cda2-08db5235b8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sr1siQbud9UdAVFYlIBlgO26oKtEdlY7PxwM4rF6RJZKeYZ2LMvkM/UYD2nS3lqj1F/DmnZRHS4nS3rlZBJmEP6szKZ6qfaMBeFsm5F2A3ZP3rkft3W7uV4KTXD0TmpO+gP8NJFLPwRqFgs42lk2eMU8FDYTJ6HePO8mYQJMD/hyoRmIaBSKLP6dl7frLrKopeDocO9UOjd9r0NlD4+LDlGu02SeLk552Xd0VMsRLSzSshxwOUEIHtPkdw44X1FULu0z20GxCF/IhTpz3bYaNmPEk0dXah823GNrRyiZQw7MuzhylKKmJyjfyEOMIxDiVg66S7/m/JsrMrYBp7Jem/3FgFc7zsRlaPATsOYlSGZm8bPzNGIyMajofPtD1nM9R79CPXiQZgJYxl9FchvkCyEYYM+fPHzN0sETu8Gzik7TaGSDQyp/aRaGkac48M7/EXZ+3ezep0dOp2U7l24KlzB/vKSCVbX+l5K74RICvlQRTe4Y3i8L7ABlSe0CQb3vQFYcDBUNE5XWcC1MsvePT+f9L7AMun3oarNPysHtPqMuX1DFYmNEOX84R56xo4QFbzT/lFi4+3UAsmE+TqA1Bt/81KT8o09llPDrsAeygoaQH7AmRmqt6+8z7NX2yj2Q+DieaPpLZrnHxcfq5nV+3px+og8safXB1Eh9CV7WSnlnIPJxl9ROstvWC57kEMjG7TcDTgDKgQPQqjN2thcPwqBixLBtWRZ4fRlGt2c0zLyK6EEIgAd4UR2vIT3m0d6bgwVWzHIHAI7oMhs8HL8EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(83380400001)(426003)(47076005)(2906002)(2616005)(316002)(336012)(4326008)(36860700001)(54906003)(186003)(70206006)(41300700001)(6916009)(70586007)(1076003)(7696005)(44832011)(26005)(5660300002)(40480700001)(8676002)(478600001)(8936002)(82740400003)(86362001)(82310400005)(36756003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:38:08.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9adb42-9a25-42bd-cda2-08db5235b8c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When unused, all memory blocks should be put in a low power state

[How]
Check the value of enable_mem_low_power.bits.vga and set
corresponding bit in the hardware register

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3303c9aae068..c9ec158c5aa7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -487,6 +487,11 @@ void dcn30_init_hw(struct dc *dc)
 		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
 	}
 
+	if (dc->debug.enable_mem_low_power.bits.vga) {
+		// Power down VGA memory
+		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
+	}
+
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
-- 
2.40.0

