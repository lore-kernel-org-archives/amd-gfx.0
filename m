Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60507C48BED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE11910E71B;
	Wed, 14 Feb 2024 18:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSF+BN98";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7352810E76B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzwfVPilugdw9xmbAMMSUwFlXQi7GySNdBCNF/tY3Vv/yHUWaNxTqWoeH3l2ueIDpEVWpuZo2aCemOiCzHA1wqcm/Sn7nT70d1lIab3lO848EexOtNuCbDxy0OmfxmtZhvD7TmwfZRKGXcBqNvCxdzn4IqKvRWGDzVaGxmCdFleplL3+R6Fshyf13dUlf8gzQEUzva2bjXqbh+yNSJNMGzZ5nxbqucczQblgGKZRFrDckyemNYKUjxir/EIEAB5LUYEgMXvW6SGVDf0Pc1IHPoqpRj/5tAXmThA9yu9y/C2bSRsdYF+taaHDo8SzHpiGQOABWOCLq20tamOI/viGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owxuVEftMA/dMRIhl6EE5YXjtdictUQhA+5T5yguFB0=;
 b=g4YljS3rUG/3rl7FGQ7OcTbGAEnG2/BubaD03ooyiEcVKtNqxpfa8V2QpCSyN1cVrC+Dg8qB7Me1RH2vJUnHqDBFbFkZM1ay072qgHGWK7vxtNEMjdHjrs/B5rz0JNUvUU6uKBDNYDd5mtDTEWdVIVrxlsvNu5GWcWPYG7M5t43yhO0c4Jidn0G1Q1YA2nzbpFuGEOiAOpYYLZTEHVfAiEAvVGfsIiwIg7/dNJ1L/AaaoOeweLy13EYGoeQThJxdnJwOkMvqmvRVW3YRl/eWboKEInsNn1o3DjVEOjH8fkrXRlCLXs4zP3DqNlQCb5XkHv6HVzNZqVn4W9O339q8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owxuVEftMA/dMRIhl6EE5YXjtdictUQhA+5T5yguFB0=;
 b=pSF+BN98cxhHK9SOfeGKxultjoqyYALDPXpQjQaU4WW2sUqhklNNPNdu75TDk78Zp6bYXpLKXTINXsla2r7NUFMwoNuIPftAd/35FPTIHAT5JOmb+OQuWZI1Sif87t90UHxN3m8oq9Yqq3JkWm9GIe6ExzvVoNX/wUKEKAWIxdY=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Wed, 14 Feb
 2024 18:40:49 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::30) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:46 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ethan Bitnun <etbitnun@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 12/17] drm/amd/display: Only log during optimize_bandwidth call
Date: Wed, 14 Feb 2024 11:38:43 -0700
Message-ID: <20240214184006.1356137-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5f0925-bd32-4a2c-ec6c-08dc2d8c76f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxigicfaWIV1XJeGQNQX4FuE3uefjOKn3gbn5IR7tap2gI9QIzZhWgpYGw2+gGbDRUMANri3ZFiiuR3LP49FEzUOxgyVTpDWfy1QqffF1wvogtVV7lVoiByERwFGGdB1rkbwVH6fvJ0AE69LRJfADmgi7aMuvylZYzpPHi7/htsgEuCy7NXZbRz2XhpLgqg9VkOpCBdOWmiO1g32VQXY2ooLuzFXedYZJf8iwf23VxKPuqA78YD/+y93ePmXvV/LsjuF/iVmrb/1qTNIoXHdOwRS6BRZb8WVkCICGtgNgz5xEOb6jPT66HFDiYWL2Yaky67Ltpyfj8n9hdtNLXd6+beMnzdTS+lRUIKqObGud9TB9QGfzYShgGNLroiBEMlecGoWvwq6zh30+vx6/8+crXWIL0weYW6cZUW5K8TJx17/lrPGKppVPlVbbKNWIlUg6bSxR+7kQZJN2RLCDck+ASjLOtLeBbYgq+3P/05tPvbqjR04ZNrqb+P3bo15wP+J+KrSyCyKvWsyUzThd2AxdMZCsxxp9NoA1Ik1eVO+DqxMWh9YSv7dDgg0FJS7QQWAenC8F928GQLSD6U/Mffwq5nM6OHOEyxtD5J6u4SeYmg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(1076003)(16526019)(356005)(26005)(336012)(82740400003)(81166007)(426003)(6916009)(4326008)(8676002)(70586007)(8936002)(5660300002)(2616005)(70206006)(41300700001)(2906002)(478600001)(6666004)(316002)(54906003)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:49.3486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5f0925-bd32-4a2c-ec6c-08dc2d8c76f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Bitnun <etbitnun@amd.com>

Prevent logs during a prepare_bandwidth call to ensure log accuracy.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ee5e7512a7ee..668f05c8654e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -815,7 +815,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		dmcu->funcs->set_psr_wait_loop(dmcu,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 
-	if (dc->config.enable_auto_dpm_test_logs) {
+	if (dc->config.enable_auto_dpm_test_logs && safe_to_lower) {
 	    dcn32_auto_dpm_test_log(new_clocks, clk_mgr, context);
 	}
 }
-- 
2.43.0

