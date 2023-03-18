Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F526C61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD9E10E441;
	Sat, 18 Mar 2023 07:57:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E36B10E441
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeUplkSzXaxsTD7ZBtpiUBu5GekkDEJIZETBmBfQiCw8MSWSvGwOgZnQeghGtRjpNnn6Euh8rY7PiS9s4vHgNPiHHUBOjbANtYueyjnGsKgeNhzsN4B0CZVrsLbZd7dmAqtWRR0FO2O5VPw6MXcNaV2qQvyw0VoVX4PV4nHLL45TonW38XSWM1ATOwQjt1gOzJ1fRx4agKKh/a028tcgtnh90a29UBhCMcoTTrq2RNm/hjqBDhaOpHwPKX+F1gTSqdRTFTO/uI15uswlnJQ7Jzo0O3ojcKf93OBjHbe9Dkj6UIih0m7OfckBYuOjgcWdiX6Y35z0ss0KeLHSHyTWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfPPebSodCw1d2vqQKdmjZQlwqg1g5xPlnglNhZIx3w=;
 b=ZHyE29J/xGISLBF3lP/QMr6Qh3SDYmKj/OBLK2DDz9z0F8pF8LtfJZ1tR9qvPpNbHgvaPKBEq7ILMCRtpYhlKDkA6AIs5N0yjOYIj6cq4Qk1bi7mvo4G85pGe90Pbr2KCP2bPRbQchpgLTc3AmLIQmBqHtoIPcPOibyk/Es+pTvb/uhUEM1YIdQfriqI7/jt2QBTPT/ib8zabwKdpq/Xjayo52ZVqLbVs0uP+i0GZbQ6t6vzBYnxZ3/nQn5l+Gszigoq6PYlY3G/dNu4takTPQKh08u4ghRCW8SdkF+UCfOPMshb6JQQytYiPyBssxZ1CbapQLUtJ0le6JudCf3tgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfPPebSodCw1d2vqQKdmjZQlwqg1g5xPlnglNhZIx3w=;
 b=sqsHL8vN66GXBoULC6lhYZwhjdy6H2+GrVMpGcZGgqKs2A3EF9us2pNnJV0SkjzFxTCIp3J9cr+Z5vGTwsuDsnZ6paddJcYMj1tSyG2dX7R1GjHxzdruEmIERbrzftUAuUD8IZ6OgQeIjOwcACb/WZg/2tZuzFlwcn6tNRsJfS4=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:57:47 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::a4) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:57:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:39 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] Revert "drm/amdgpu/display: change pipe policy for DCN
 2.0"
Date: Sat, 18 Mar 2023 03:56:10 -0400
Message-ID: <20230318075615.2630-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 974b7f1d-077b-420c-5c31-08db27867626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIGQRZU7Xobmvu/C+WCax43hX8U9QZmveR27IsmvjeP6x/zHiIFIjUTPbOAkx5MG8RdMiGzsPGWx72lxGg75yDTqCGzTcejjA5Wp//Aq5zeLy5p8BssQG5HBItQtR7r9JO7YFOD2tJUZemODRTL6yv7k2sIki+S/L7guDyEr49EjJ1LvnUo7Gxh59v4PJMyVikuxViug1JAxkYy2+IqbFuNtcD/3C86N59YQ9p0EEblEFNowumZiGwY4FpAfin/U07N46TcVGit+XSz1UF6CUTZExFtyWgXGJ19nfh9CyPlFEZD9SPu0mbJ/tEqlqzm0T88JNZUjSzrxK2mmBUFyU3cRrzD/2GRZ41D6JfKefHqXDFnVCKTruYY62BmjI7IcXmzxlijkfCoZc3XZ/n8rGdFA/DlYQ2J1D/qa5SV7RN/UKTLz/bQSg8Q9kSusnZz7VwJ3cnvypJ68R7/WGrmpt0hxAMK5nwOy/xJLfEiEB1s4kGRgRNnqO2az1a9g5S9IKMnFOl0OGgTZ+lYkGhatr0oV1rzyInHhTTA2lPUAFIi58DQW3jXet0PIMwhNVCMuy+kyXrXnRn0Xaapneb7Tdmjg7vQSidXb5q7i8B3ECX5uSvTDzo8kW8Y3P7D3Pi036IHw7itC9g/7uTKIULJArxUvtYOvjPYOTd3O/eXr8xcyz5s3SsQzCjYPv230UgDwn+yxAvLRWqH2W/CrzqXuTDpTyJ/+2riM1rHrn9TeYxqcsQpYfXgMPKiu3e7NdyEnXbceRiBReckZ5sZBjJjSVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(426003)(47076005)(6666004)(478600001)(16526019)(186003)(336012)(83380400001)(1076003)(26005)(54906003)(316002)(2616005)(70586007)(70206006)(8676002)(6916009)(4326008)(36860700001)(44832011)(8936002)(5660300002)(41300700001)(82740400003)(40460700003)(81166007)(2906002)(356005)(40480700001)(82310400005)(36756003)(86362001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:46.3914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974b7f1d-077b-420c-5c31-08db27867626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This reverts commit bcfab8e35ce81e2fd3230c1575024bfde0d28c8b.

Hopefully this is fixed by the previous patch to enable
TEMP_DEPENDENT_VMIN for navi1x or otherwise and we can re-enable
MPC_SPLIT_DYNAMIC for DCN 2.0 for better power savings.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 77ef474ced07..1d8c5805ef20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -712,7 +712,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.34.1

