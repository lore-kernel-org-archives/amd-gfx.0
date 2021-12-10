Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900AA10E3E9;
	Fri, 10 Dec 2021 23:05:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5435D10E3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd0TegOQV3lkJdvG9t5Xe0Y5OThTZ7VeiHHne2Zs9b5KI0U7By6lAxHQjk2EwxsVlZ+BFqgeiXiblRbl4dvYUr9MzPI+aAsBs5Lntf5cbD/Q9M+GrKtAmd8h8YusePR/ghqlm7rbWaFjV2EfDNVu3bZFjXbSiqOnYk+0mEWYzhuHp0L+lbG2f4OcZJCvB4CLYN7n+ut4UeuNyspIpY/zS1Tbw+CeZVep4KoijPMVjoNBRrMFQ970zGm30PeAVbDrHGjXpvkvQkdaAaKSTSJqb7thcTyxFJPmsMgU+cmPdE0b2WPpfjjG9fpclb/g8FcaIhELJ/R0CYhafl5Uxvv0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWiJxFcNFE9xXP3CPETlxwJh7Q9AZXaP+JFU376t110=;
 b=MecKab2N3aUqDKO9YUAgBHdYBPUlfrJ4iGfxzVqAmMEF7Fvby4iY3suUKjrIsrl4RIUprV8h8+POOUR38m7CwXCw9HylrrRLfGbAW+ltoWzVceNvBE0d7/ukE/CoX3uzRCcoONjLCtcmV1uMr0EOekDuHUx4TqohZVHI2CkhOKhxW2bhf+Ju9mTMWNRZfGjGXynF/Bc5m4XVfO3J+tRn9rYsqAESj3bFw9WhICB1QLmN7yj7yjQuysrjvHVx+p3X85ZlAn03c5kbOxgOffhpYZpGZ1wF4jtLWOevLKhEOlRH5bu2ZEq3t5EIg4cYKJa8jrGPZWmivxQK8pJi2zRJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWiJxFcNFE9xXP3CPETlxwJh7Q9AZXaP+JFU376t110=;
 b=YY83FgURwz/YAkUxqjoQv+KCOm43ZoAlRdEJW6paxYxbwXdosYEARqkbCC/aXy8p/wLpsmkF43R68SnvlsTmEgk4IkPWEB2Xw/taonQS71ng8lPx4e0Vt8zVLKscJjn9/cFhlYke8A+F83MSVe5NO4NdqxqX9VF7DN6Fvem2piA=
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 23:05:12 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::44) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:12 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:09 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amd/display: Set exit_optimized_pwr_state for DCN31
Date: Fri, 10 Dec 2021 15:03:59 -0800
Message-ID: <20211210230408.619373-2-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f295116-d345-4504-ac84-08d9bc31850f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB001928EBF48597C24709E59CFC719@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XLhOEUDfk1u4JnvcwWCMQSVfFRxO7bMrRiPlklP7iEcscZvmBmhInca5Otz00x6zTQhXW7l3xs18VN2B93/nj7rtcUaIn9fWZ8bvjEMrj6vkPnF0gYQCsGvHIfnw1eKQ9PSvgr+C/3C+1va6OvQVtQG/dxO39BppAUkee/KlT9Swusng9ojFOhZmsxM323/STKKDOu/djZRTIvjbfgOcjCX/0htxf+NXJpOMY1wsTfAMVY7UAr8+no1R5N6OZ4cRtK0yN0ZE0WUf5dFEugWXLCm2zSvqLNHq/1/PzLB7fzAlOJICnZgm1j+hP5//SxTqsmlRJQieKr6+aTqbtxWSIib9Iy7Swn5SOFXCJzIYCmbvtBmCqFO+adkjt6CgY6sox0pAcq2mriMGA6YjsgZHZpnFcxelfvv5/eeHNSIoLuzT68UCGG96Oa3Ooi8YAEJpZsl6l5vRtCirFrk83/ttZeNXA1QJuq9SpdtFCLI3AznrBCbdIGWvAOJr72oklKyM1CMbHjeS8sdAtW868iuWgXhJG5xxfpuu3V0dL0P+OuHgp9K4tv0D4zA/zd7mXAiae9bueVrbyV79k3Mdu69brKeZ/bfc4MvMAcX4aUZ/pDBsMj027zvtBnGTQVr5EgxkwOkIY5llH6SND2c+HlLx+BzrfuayrqfErI2wAu+zQvPMzc5Gvciki6Lbbu6VumwPk7GKBr3TqZPW5CQmQtPgwOqSXoCUBLJg7S67EQX824nYKsUxF/Ms/9V1fsr66ex2TDLH5/CWjs3KjZ4TmFU+YWe3DbCSuOSg3DAzIhE4M0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(1076003)(2616005)(82310400004)(5660300002)(86362001)(54906003)(8676002)(36860700001)(6666004)(336012)(508600001)(26005)(70586007)(2906002)(316002)(7696005)(6916009)(81166007)(36756003)(70206006)(356005)(47076005)(4326008)(16526019)(186003)(40460700001)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:12.0670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f295116-d345-4504-ac84-08d9bc31850f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
SMU now respects the PHY refclk disable request from driver.

This causes a hang during hotplug when PHY refclk was disabled
because it's not being re-enabled and the transmitter control
starts on dc_link_detect.

[How]
We normally would re-enable the clk with exit_optimized_pwr_state
but this is only set on DCN21 and DCN301. Set it for dcn31 as well.

This fixes DMCUB timeouts in the PHY.

Fixes: 64b1d0e8d500 ("drm/amd/display: Add DCN3.1 HWSEQ")

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index e175b6cc0125..4e625094026b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -101,6 +101,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
-- 
2.32.0

