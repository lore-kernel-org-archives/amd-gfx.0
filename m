Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B534C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F60310EDC7;
	Fri, 14 Apr 2023 15:54:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E90810EDCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg9pNGLsNb+fO5cIp1cdTppGvNu/ciq2emdTI/BYVG+u0vxkc5Nj7+umWgezH9YBNAYAtg91zmDzq4om9Yq4Szwt+Y1isuYWvfGVIsxwtP1n/Qs+Zzt+AzHusWNujsD/+5+TZkqC+5P81uftAdL5t/6bJC05bHVWXReFES/QwLE+oZ69CwKclVH0YVx/ubGfMqRigfr79ivZrxlKyFXG5d3pT0GiAGAaH52ejFwqiE//Vq7ZkNvo34LXfBk7P2TfttHDcOq+8iBljP8GwjSucLOW0ACy0/ih3F+itmjF+h/RC0Nc5yNCHBumbCnVUYKi2m5bIbJMic4/iyKBnXTv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLeFGkhBNMylvEeasZ6THo52fcSWToO5wJmCbNExwrs=;
 b=jZ2nJKczQCtQV77lNk193eGvoI5gIuTupiBRuaqDRXiRn8zWoLz+9VtciiOxp8Iaktf3uo6HiZp7bExxuYx1n3k0eRMV/9DKkAuZf6AkwQvquT6wsbXW8WGaZrEG+4txZdyjaq/LM+fXUdMOV99VfatVcBtkeqhCK/ZZt3m6ijYbZ/QbC868zYZt5hZ1b9u5grDsOd+TI14gf4CGsHNfH025g3fuOW9Tf7/Ai7BGlhm5eGaYc4wJ3ln5DjYExFYsm7sGrq7s437Hg0GbfOKi6oTyF7Wuft1Ei25ASZq/80SPKPnyemiDzI+zFvWqV3UiR6uKjUaAD7YJngaJw5MhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLeFGkhBNMylvEeasZ6THo52fcSWToO5wJmCbNExwrs=;
 b=GikhS/XU0QJmgbDrMbAeM/9Z63Z4/+MmRUxJ3gcmzMelb5HXLsU9hKXQGExarRDvkhs2YOOcsnvxxhnBHfvlNg+qRB7QyZmYuePVQc2yNqd2pZNyCdg+nhg6FdOOo20schAlL8LsmxmkCRBkP6W+xWzsiwqTD4WsBSoYwa3eaT4=
Received: from DM6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:5:1b3::35)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:16 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::6a) by DM6PR17CA0022.outlook.office365.com
 (2603:10b6:5:1b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:54:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:13 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/66] drm/amd/display: Only consider DISPCLK when using
 optimized boot path
Date: Fri, 14 Apr 2023 11:52:43 -0400
Message-ID: <20230414155330.5215-20-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 040580c6-635f-44e4-98dd-08db3d00801e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkzfzT165MGmD3EyvAAX5iZepFazSaKtHXPpmsH8MsOBrn7x7N6SjbKU0gUtFeGr2K/oSNARsN7XCtK86rbsegm0upNJzDetFrNsyz3Za0tnOHBNudoLTpR0h1eskY1AWrGpuDCBUDyS3L4Ggl3MA/PE3VwWq4o8x1PDHnmflSkoVsB0wVBptBhQNCD33TRB/M4LtzPQshULEHm8U6tV4FtxVrgsWZvsLH5/oT2rgHblHXVyav3p3lA+mb3/1m0yMlSWOphEjMjoCYy/SVB9a1Sv9OG1CdCz3R4sTxHPWolW8S9IUT8a0AJeYypPuOvmGpfsL5MCOxMY2i7qZ9Mbwv2tOUQ9AqQ6E6a4Podl9qjkvmz99RLO0NpDkoYhuDKfdwLznzTXo1v0H/3ltWBZBpmopksvV0NxQCF2qMQY6kMzMs5KPA+OdJEVuDaKXGdCYFRhKlb1AlfiMBiUQ7xS4txnFTiaHM+Qo7/u+s75vYxmYcVezwGDz+Q19qKwHzVC7nqE3lDyEJzWdePyldISAyp61b6Q4uvsOP+wQWTUFVt9ISojKgnERfT82ciyRXfE+JhvYOEi/8pV8Mazt+uHPhEF7ul+Lc0ddNXKyDaTuI40U1T4njvZPvPIjjajPHfeMnQTUPR5E0Ibb/MBa+PiXIUjBzjfOArqAG3hVZbxn7D8Fmz+m20sYw+2ywqFVTSp9SubvRJcehfXF3HQTB4ko6UOSWQih/hB9JxKwkhpvY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:16.1059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040580c6-635f-44e4-98dd-08db3d00801e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Saaem Rizvi <syedsaaem.rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Previous bug fix for audio issue included dtbclk and p-state
  on the optimized boot path which is incorarect
- We only care about DISPCLK in the optimized vs. non-optimized
  boot path to avoid audio issues

Reviewed-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1f5ee5cde6e1..26791e3d162f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -721,6 +721,9 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
 	clocks->socclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].socclk_mhz * 1000;
 	clocks->dramclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 1000;
 	clocks->dppclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dppclk_mhz * 1000;
+	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
+	clocks->fclk_p_state_change_support = true;
+	clocks->p_state_change_support = true;
 	if (dc->debug.disable_boot_optimizations) {
 		clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
 	} else {
@@ -730,9 +733,6 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
 		 * freq to ensure that the timing is valid and unchanged.
 		 */
 		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
-		clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
-		clocks->fclk_p_state_change_support = true;
-		clocks->p_state_change_support = true;
 	}
 
 	dc->clk_mgr->funcs->update_clocks(
-- 
2.34.1

