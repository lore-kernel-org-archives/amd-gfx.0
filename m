Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054A4EB8FC0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3A510E64B;
	Wed,  6 Sep 2023 12:52:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30B010E649
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmnpUOhK0f89UmxBaBxyRKHwU/mcWTh5AORTEvGSsmwRITsfTkOFEW/ky/NKoRdCwqG8cKY++j8vzgWChQG2yhnAqkkdHqcPFAfGWYvy77Io4pNZmSMf9bbL9SflpErY71p1zLuXSmN6GPl28Dq1K7TEeTjQOjQNwu0EkV1B3G4NopeybLohSn0988AkwrIMtw08Gz5V6/MASugFoMWXlZLXmrbW/d06hPl+UNc5H405SbcDX8ZHqDkmIjvpZ69MxPeusGninOlAw1Sr5kOrSE18ZbXjKOerxhDHZQOk1kOVaZN8qchU7AiRlaqkRdesG6wBdA3rglrM20oBRNbXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2/utsOZmnp4yHskm/2thDstV1yKvrAKtH0/kwdcG00=;
 b=BdI/vGg3X0HH9D4/aPdwKe60Uf3LC9ypKCRgjTK4HqHCGNLP7p13yJPFzz9Fek4Xo9xSuUfTR2mIOqSVieKgN5rd4rgGShM8V0R7BdY+hwRZinjNVGRZ7rdxw81ZScZ5SLrjJyUWc1Zdz0m3zRsA7c7O8eigP7XuQ/4eb0GOb1qkXG+qbRep0uajNagSnRCbaZdk5Q2pYQk7dqLZAIGav9eqcDY6qdo/tZHkFYE1+0lJvW+p5TOo84GSUMBQX5fLs9mVEm1Q82eHrTwXCplPebSGf7cL+UMwBqm0owtbjP/UPtcpTFcft8UoXK7HZep5lz+/XDgYnmoKEMLqvgju7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2/utsOZmnp4yHskm/2thDstV1yKvrAKtH0/kwdcG00=;
 b=Z+vXXJt7ohNcOwEilzRaUupIFp+6hKifYNlnxQZcSetr1LqyHEg1eohDWnx6V6s9nPeHpVuIz7zmoD6OUnc0p6vR2PWP0xeh7qR3HJy5OUTvDJWTBifsx4O9LAKthAnSeWaq4smS0pAIRD8gs2ORAo72hpbHQnD8NMhIAVuwHX8=
Received: from BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:52:15 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::ca) by BL1PR13CA0329.outlook.office365.com
 (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.18 via Frontend
 Transport; Wed, 6 Sep 2023 12:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:52:15 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:52:10 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/28] drm/amd/display: add skip_implict_edp_power_control
 flag for dcn32
Date: Wed, 6 Sep 2023 20:28:33 +0800
Message-ID: <20230906124915.586250-29-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c424597-c3ad-43f2-c157-08dbaed818c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4TMae6APlYKKg8iksM+IMbITlDGiA3kAh9o5x6G6qgI5EZ4uOCGVSChp/1tXJX9lXHCT2wSAGOHH8eyPi7xqf5avHT3bp8ZcTta7Gaidc8Pu130UxSQdvsiJomeDPH203QptT0x8bQUy9aG9sHSqNESX+nQKKi4zIrCOQJCVFkoRbirKPUy/XnyzpnleW4jT5mO9zjio4wzrU3Ms4w0lL/pFEAdP/s2iyewYnSNvMY7KIRD+D/icFBU2vDmGaX9KZIclke8wN4b/YckM1IIdKv/qGUYdoWaNV0exEs3v74qAnGA3Q/DFgU01WuzpnSKcWVRK1Uujz9hcFFSm3dKacdgqXBb7L0H8EbCNnFFjjXu8EHOiDmSLobCPU2dhKd+eOKoZ5Fq9OxTS3wAwBhx6Y8yg8vVY63Kfd/SDEmDwa4y2pSrJJjbCIbzq/B9XxYkwx7lCdqsielWupHQg/uiCy/UYDKVO1NoT5ZMhpJmr2e85Py3GKlLQOtvvSeGMEik1teBJrCaywc8ilWrIAZoLNhffwWMXQ+6JZaWl7umx3K10s4d5rwxokiLSbPjc6kko4DTmfHo88WPdgiKizvOU0DvNswLEjTd0W7zmy/uN7hKtS2do8fJfLqz9zWgU+ff06zLfrShg1tgjj2tlbolHb++TBGLmtvRTRxRtVV3teqi6csMn6m9hoDaizzgqgCfGYl9u4sb/9jBqWEwEPG7GNdvOiuRlmchoxEe1aUXhUExmmmU/Sjp6pBn+P/hSqVvhiVrrXcGPBcDMChKeF7r+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(6666004)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:52:15.4108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c424597-c3ad-43f2-c157-08dbaed818c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Add flag skip_implict_edp_power_control check in function
dcn32_disable_link_output to fix DCN35 issue.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 018376146d97..e8a989a50afa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1322,7 +1322,8 @@ void dcn32_disable_link_output(struct dc_link *link,
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 
 	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
 		link->dc->hwss.edp_backlight_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
@@ -1331,7 +1332,8 @@ void dcn32_disable_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 
 	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
 		link->dc->hwss.edp_power_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
-- 
2.42.0

