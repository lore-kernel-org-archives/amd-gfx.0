Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC38C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C69C10E5E7;
	Wed, 20 Dec 2023 16:37:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C0CF10E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je2mSLzWoMSXRK5ZWabJRYXXNM8AtQD/n+l1KBetKEEgOPz6AKKLDd+QTH08TNZoEKmemGPlzsjOtc9ihYmOziVekyBrGAMapNyA8Cg5LQdK7mO1eXHwgY8QxvkzCy8xp9X5DnG2Vmacp/cETKz5kX/bA9wA5O3gwwVCN6APlqLmppXrTOPvonZxr4JLwpwQIVf+jV8H/EmIKnjE0iZ74JnXSbFaWpGMqNvjab8awxxketUIxABEtvRqWGnq2v1HT303NBpcVRDyBXv1YgzrjXbdjgpSjJD0wTzDX2JgjSAP8llmkBWBXk7c4tLsi1JdqKS2cngpPLzUXLz4lzCvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xakOOkWrz9bWTbjn1omihjN/xFVy9QiaitVwLr1ZpSI=;
 b=UURE1wioZzgdX1CQTGWHLaG1Ngd82QyBKt1cOKRvHafDMPY2hg2cfIgO5fAGEqhBqzqkfe/2PUu4IL9N/m23yM6awTVnkZ8OQ3zUnuIEqtD06oxEBcQVa6tdSaDRBOcYz79O2AKEmyJeZsCvlyMa3mG7GyS63MvooiesgzW4WNkJeYsonetFuby+Cq5ZxC8EYrV0k5Nfwe+NhZrm6KDZJgEWW5WmaE8AtRpiBFq/zhTJs97Fp5nxzYyCvfjQPqFDX902PwlEIXxTFEif4ES52IwOa9q5rb8vNupAbEiTGRZh3Vy5eiDOnPrmFyegTxayTyqDWwfEncwtuiH1wQyvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xakOOkWrz9bWTbjn1omihjN/xFVy9QiaitVwLr1ZpSI=;
 b=DyEqZOAk7S2Mr802h6PqL6pbnDMlstmtGmeyI5dKK+notcsC1kmq0GXKjD6rMbyCCYSo2vZivFv0QThjUV0X9EPhEdKM7CC+7fvfBvbe+3gXFd5l/Lds4CkXy+7uEKwuaiTrjkLAl6x8YI0KZ55jrrkAOYLidxg4m8rgUwKLCa8=
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:36:59 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c4) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:59 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:57 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/20] drm/amd/display: Add log end specifier
Date: Wed, 20 Dec 2023 09:33:42 -0700
Message-ID: <20231220163538.1742834-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CH0PR12MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 041778c6-9a54-43c3-22ac-08dc0179e332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Us7Jm/+ZnOUKOdQwodgjo2wL6V2ezVSSAPITB2zzi+UWJSnbeUYsm5PC7BlGxk20UZjG4/IFfr3dN7Bp96wEIsKwgnHoCG+ZojBMVKSzvisnfzoG1WlxLC7baY0Yt/QqTerIbgjeke8Yh/raK7IUlmgyZLwFOfNbuJMCrClz8ZA3kWsuYWb3ufLWy8k5npF2MGqGY5fEj0heOWNFFU79y65/YcoJqDRJzh5cG+rPjGNnjrTgca1voCW+XgHB9jELej3sA+vmR2c2EcHxreeTpuTGFkiR2YtE4NLD11usb1v/8bJ8SpG+bBmMYDw1Qoi9j00rl6dkEdxPNcQ8jB3E60Ry6uT6lQVBytF9IHgN5b/k6hwNxjq5rFKYzb8UTHq25hjACi9oWMqGd8gACc2iilh9qrEbw74+ZLWvhlX6gv3fnYfIw5rPMHK5SQngdrrS8BdNJo63xOTZfsuBD7H5dO4M+s5PdrORQ82BXMjRF6StU14dxb8eSh7nCu/kqrO3tl8XSyp1TMmAll/LKY88wc6FgtRwVk1+lRhWvXUqT/pU+TrAVjLkH+LaB+N4HubVc/s1Z59reAy81UU8bt7S/FderZ0LKIJwJAg9pkhHL9NbZHYbvni9G2BBg/yulTjxj1yskK+7ur15OLGha7wcUTGZby7cGDOX0Ec+zvuKQJAgeP58AEnb0kBSmZBIcEz/svL9BCwaGMxE5dSF1YZmw9qd3PgU0cqFHyQlIch+T6z+O17uRUtlnl5m+6w5/GklHrMFnTX6vniF99B4Gy5gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(41300700001)(86362001)(16526019)(26005)(36860700001)(36756003)(83380400001)(426003)(47076005)(336012)(1076003)(2616005)(5660300002)(2906002)(8936002)(8676002)(4326008)(6916009)(70206006)(70586007)(316002)(54906003)(478600001)(40480700001)(40460700003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:59.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 041778c6-9a54-43c3-22ac-08dc0179e332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
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
Cc: stylon.wang@amd.com, Relja
 Vojvodic <relja.vojvodic@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Relja Vojvodic <relja.vojvodic@amd.com>

[Why]
Some debug tools, sometimes wrap around to multiple lines which causes
issues with the DPM test script while it is looking for the logs. Need a
way to tell when the log is finished.

[How]
Added "LOG_END" to the end of the log.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 51adb13b3b80..aadd07bc68c5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -565,7 +565,7 @@ static void dcn32_auto_dpm_test_log(
 			"pix_width_0:%d - pix_height_0:%d - refresh_rate_0:%lld - is_scaled_0:%d - "
 			"pix_width_1:%d - pix_height_1:%d - refresh_rate_1:%lld - is_scaled_1:%d - "
 			"pix_width_2:%d - pix_height_2:%d - refresh_rate_2:%lld - is_scaled_2:%d - "
-			"pix_width_3:%d - pix_height_3:%d - refresh_rate_3:%lld - is_scaled_3:%d\n",
+			"pix_width_3:%d - pix_height_3:%d - refresh_rate_3:%lld - is_scaled_3:%d - LOG_END\n",
 			dramclk_khz_override,
 			fclk_khz_override,
 			new_clocks->dcfclk_khz,
-- 
2.42.0

