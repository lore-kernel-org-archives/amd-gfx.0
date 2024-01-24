Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BFAC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EB610F657;
	Wed, 24 Jan 2024 07:03:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3E710F657
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAl6t+GuTS4cdwzDsiGnoP58P6u+8uGhwIw3Wh427FeaU3Z5svaG9avPd09BhnonuH2AdrvN9uA8L12wbXKk65r3yI1r1ndJar9K15CSMQS9FPlQcZmxIybYUsPBmkI24J6vSWOxkYZkMwfBlkmIulzdjxZednBj884DhcUXhKPgg2sl8lrTr8xtcMaCw33xb98CShJTkd+wl6p+5/Bdb1BNEqorVajHHvjlz18h1SIA6V09oUwcuJ4CJ+WcebVjs07V23IhSl0ODem/lDgyQ+LhS6ESBSqeNKkO55j3j9X0Z2+56loi0Zqh/2wt5Pk4S7CvkJmNiur6xnoXfr8mPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxF0A+1Lqi/zcGKW3zZ6Skxkkh2Gk3IH2t/mVgI4Pg0=;
 b=Lx4HRJpUuCBAbBEuE+9K9WvEB8dTsS48ff7Q4T9PjxaJWfhRWT6ClnrVNK4NJFlyLAJWX+p8gTtKqMuvSzu5GbZmxG5t85B+CkAuBy0OQPKy7xQDBhtSWRzfI0l2HbMSslCv0+T5HC74XTydboHGYmtd2xCYDDcsqPQCrqfISx20gHEgIXrhasBhMSQvtryTBsMGuLbl07qwfJjKiNZ21MxMO2btMPJiG/aNZgkGG6ZTrAVT0qHumto4uoyw9ae/vcOYCOAPXi2jab5mAG0wRfQTBM4nu5n1IRo1J1opANjgAh99nzNRuz/51nVQcL40UiHj0OGYCgdrJz2DDvKqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxF0A+1Lqi/zcGKW3zZ6Skxkkh2Gk3IH2t/mVgI4Pg0=;
 b=vNU2giUUaNQqA0ZY46ZN8tT1eSaYPwE5uSd99aWPRfI6fj0m1skQGRiz0Ne+tqvIzwmb9kK63ORaRpk1NGuCwIfmwjweVsKz2NesHj0luA4/JTsCaq+AsGmUK9o3w67vV68yl4tkutlIaWN/khRIj60jiVV0vq2OGKJPQ4UDUlU=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 07:03:13 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::cc) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:03:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 23 Jan
 2024 23:03:06 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:03 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Underflow workaround by increasing SR
 exit latency
Date: Wed, 24 Jan 2024 15:01:53 +0800
Message-ID: <20240124070159.1900622-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8f89fa-9ffe-48c1-5672-08dc1caa87ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBbwTs4kXk0owCbnhIPrnHDktaJm3amkJvKzzoy9IfkfCZzka2TOPOQtb8bs+Bz1nK8COFKRj1PAXGROVeyvfKAy8rDYJh6KJZFeiboumRGbj+UCANVNZAcYMoxrxEzVHWdVt/Ic2wMdQkwLssw0FvyZUK1Mio8X7v2lzTWIzp4+Eg0+ncYe+jCiiexn5lmBoN4f7BQFj/Kj4ADdhsebUuwJq1nvrIzwEH3PTaD6oJUNhmpqNCZ8MHhSfNCzUVxk8/qEloMrGPf8ljDJ7SKCnNzGqE45rRi1mgHz3OMlqrMDg4u5mwngepkl8bxIciF/XrhUVe3W24Roqi3E5lU4iEr67ks8Jt+tAN2ASYWy1sCmwkszU3BzeWll/WCI7/1bDcAeBtU7FE1CVN6Clh04IafqyVfRwZql+U+gVxFJogFLMhgN2lxtaECfIltetKX/0qS2RWZGZGJaHkCe/uk/Yf18i7AB+mKHtwoxBMYE7IP720jW70lZFNLbS/etmlyAV2YVflp3mscs712EoeIgWaR3wxdRfEimryKcr3pgxeIplrIMKrqtg8Z6Ke/ZeSmUubtYPcSnb0vyo30hGjjhy3hOkqycPUcKNJmOJ/I5cczY4nDq3DKpHfSSWI8oG38we4/m1nvVtKQzMPQ9ECJbM3wl3sD1h013KqhXRhtjUPwy9x3cQxBQNH6cYqhibUxKivmdpzW5MbsVBq7dGsp5D0WkhfxVdNLU+yVyYVJFuBxolHRVxR9AzIfcrY/PMjbq6Jw23b85AQ1rgkpt/DN6uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(40470700004)(46966006)(336012)(6666004)(2616005)(7696005)(1076003)(26005)(2906002)(426003)(5660300002)(36860700001)(83380400001)(478600001)(47076005)(6916009)(316002)(8676002)(70206006)(4326008)(70586007)(41300700001)(54906003)(8936002)(86362001)(356005)(36756003)(81166007)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:03:12.8792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8f89fa-9ffe-48c1-5672-08dc1caa87ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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
Cc: chiahsuan.chung@amd.com, Nicholas Susanto <nicholas.susanto@amd.com>,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]
On 14us for exit latency time causes underflow for 8K monitor with HDR on.
Increasing the latency to 28us fixes the underflow.

[How]
Increase the latency to 28us. This workaround should be sufficient
before we figure out why SR exit so long.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 32 +++++++++----------
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  4 +--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index e1b035380f6a..eda39d739ff9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -441,32 +441,32 @@ static struct wm_table ddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 	}
@@ -478,32 +478,32 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 14.0,
-			.sr_enter_plus_exit_time_us = 16.0,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
 			.valid = true,
 		},
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index a85693caebd5..912256006d75 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -164,8 +164,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 		},
 	},
 	.num_states = 5,
-	.sr_exit_time_us = 14.0,
-	.sr_enter_plus_exit_time_us = 16.0,
+	.sr_exit_time_us = 28.0,
+	.sr_enter_plus_exit_time_us = 30.0,
 	.sr_exit_z8_time_us = 210.0,
 	.sr_enter_plus_exit_z8_time_us = 320.0,
 	.fclk_change_latency_us = 24.0,
-- 
2.34.1

