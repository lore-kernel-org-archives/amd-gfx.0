Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1268C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6E310EB02;
	Thu,  6 Jun 2024 21:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t6v7AEBA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2ED10EB01
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVrQveRWmxapAePt9xzfOWhZbkJuHx761Eq1+M1wnrkzbue8V0ebFRHdrsfZBibpLFplIu/L1RrMJOIDJ1jJ60zCIJ0xS44flfLh4NXS/Iti+pEBPkfw4Oh8+ItKHzYnYDBIRWDXILeDyDei6pUWXwzvmLcDt0i30nf764mWa+gJ2H79ewfPYKwmQpjGcmaxfHGRKqEOAIxqUOFohZqm3oqJlg403wHVd07/KhwB6gfyWSQSzInXm7CqgkTmcURbD+oTds9RseCMWyPGeWIq2gkpFc1DO3rjFFnaA1B9a4dORBsak+ApDXd9KU9VxA/O/iHwAcOtaFPzlvCCmEvKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oK+i4rEZwDD0dG99aO+gq3Cpsf/jnnWtWX3G9xlSdw=;
 b=QaE3EhUnGHDKGIqm6FfafTcDOXA28LB+74S+oWihtEjTzXYJaLuc22jvZ0m5AxH6iL1jWwshtZwcCPO8MjPq8kmJQE/2PAyRpF7DTN5lkQiQqd08z1am0AijgAlD61twxuSr0GfiA5iCTbG4/oVp8W6Kik9x18aX8QFvDnrHCa+Z0p41w4pszd729KqJXQQ7tZ5XiAon5BtlFCrJ5CsGOWBY64QFzZMqzhMyTdRKf3kkO5fq9GFMCDYWyuXDsyyqgVzfvn/yaOl+flmYetGqC2gl3QuaqNI/zTcvkE9rF2JQnKuRBMVkHIwCHzQ01fiK+gkwTdo7mBOT2YR1tzUOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oK+i4rEZwDD0dG99aO+gq3Cpsf/jnnWtWX3G9xlSdw=;
 b=t6v7AEBAYWhQ5XorKtmDQYc3uaiiD4qYYOJd4ZwxNtGjp/1Be1eeNaA1VZfKrhxZWG1P/1Du5HWZMdmaHRrOyjXHt3P5SCzvmAySQ6T4TVzk85W6ImSBAFyCz0BIgid1YoDPrs3TPzO6x4sQMUIzMsVeJaoHeIK1hmxkA5wGY+c=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:58:58 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::4e) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:58:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:56 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 49/67] drm/amd/display: Fix incorrect size calculation for
 loop in dcn401
Date: Thu, 6 Jun 2024 17:56:14 -0400
Message-ID: <20240606215632.4061204-50-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df9dd1d-9763-4818-1bc4-08dc8673dd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ndBCwBJCsRYmiGv0TGWac/+37quOTO61siRuVgvSfavU1C0QFyLGcaXWYXKo?=
 =?us-ascii?Q?LJe8e55M2b/skNtqPMCiHTyV85Tribs3KAYqZFkzMVp+QTLVwIxCYlmGvVty?=
 =?us-ascii?Q?p2STAI6TCCyXYp+UVamtQ4D/IfTgVWDxPEW9AZ/2xFIYZFzitbUpdRpxgIV/?=
 =?us-ascii?Q?p44EF9D9v4hi+/luhK/v1+AOfUXN0sJmKk5XSW4JfkFGP7KsLFbUDUNkwFzr?=
 =?us-ascii?Q?ND2C6XH/tDRoFl8rHv1epAsmsLDLVDTgdJE1DNI0GvKhN8lI35fPzxVac8c3?=
 =?us-ascii?Q?0MEBO/o21lXP+RPi7birRK3NYxemXek00exSAB3mLwfBxi88r2gTklaM5ouQ?=
 =?us-ascii?Q?x1M68MgWQq+pdLZ2lw5UcSZyS82Uhs4/9cnb9bQf2la/JDyW3JzzG13tFMDk?=
 =?us-ascii?Q?95ofrSzu36NNQPexLjTfk/tw9idMr/MwQo/tMqSuFIGBYrw/woLKex9bTLxR?=
 =?us-ascii?Q?rJOkIfnHHLl8sYso8YI2Ijja9Xge3SuOSfAvA04hAbxvQptUuR/wk3XzRzrq?=
 =?us-ascii?Q?khmu3SFc8LO0YYjtmg95lCnrTCG0BrgH78HfKCjNI5zdUnhFVz/keAbz34X9?=
 =?us-ascii?Q?InUF09xHoEQ/HMUNvDn9AlrabA2yH87A71+b8XIYH4fPUCxUHw1OnujMpSTR?=
 =?us-ascii?Q?KGJE743qZHTx0sSf53kJfSOPdpgs78KKwU0MUny4GPDsPILS06DpnqrzELRA?=
 =?us-ascii?Q?UHiNAfJT++bIbOzLUsM8SXZ8RjIWo3K2DyOISImzFPymuE3xStJc0RxUA/Aq?=
 =?us-ascii?Q?+y1c0afpvSJHZSHygt3XIjc72Xe3jl/4w13eR46SA4DnA81usSMAZ+5upkBG?=
 =?us-ascii?Q?R2T+XGLqp6/CNndqB2uC5NJEcXMFiSZ8LACAuTozOn/0i58x/75sGfCfw3bI?=
 =?us-ascii?Q?hjP8S447xFuA8X/Lb7tpdh7QaOZQOyOezt114zuFTqdd1XTooEk0BIZyzwdA?=
 =?us-ascii?Q?8VBx/qwoxvYmbEA+zlgo5rRHUzwL0Rgwc93U/0pGr+wjYa8HmgqBX9Pi95cc?=
 =?us-ascii?Q?DvGrkii6P0P7QWDodHgeFSVX2NkRensvxJnoXUaKpPX9xP0r+pF7Av5PI2kp?=
 =?us-ascii?Q?SucE7ab9caaX56Fkc8HjMclB11xI9PMrKLrIz7AjTXaL5/JKO1NkzeLP7zTL?=
 =?us-ascii?Q?d5mtmAE+uxpXaamTokFksiDvF1fiwjPIERNEBNLQjyd8e6H59oqknttVpdvP?=
 =?us-ascii?Q?fQPOeM/gwsu3zHQ2Uch/5VBn2oSNkyEORVAv179DBGl+BfVZa7+ZMta3K8Rk?=
 =?us-ascii?Q?WUcqTMpjN4sxbJjAZk6QvEmkG4esCblG7B+DNGlkpuBaq8qtAVC5isQ0SG/5?=
 =?us-ascii?Q?w6FrX9wKzs4PpmcrXmh+QSVGTai2o0GqZ25m/vRY1ADZ0d5cJ1dG4Yj+JG3G?=
 =?us-ascii?Q?Qarbjz5HO4hZgM6JtIBBNDjkKJNH/1+XkgxhZsHzf1mR7dgV+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:58:57.5818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df9dd1d-9763-4818-1bc4-08dc8673dd94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
fe_clk_en and be_clk_sel have size of 4 but sizeof(fe_clk_en) has
byte size 16 which is lager than the array size.

[HOW]
Use ARRAY_SIZE for calculating size.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index dac31c4cf2a7..6a467c49b4a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -885,7 +885,7 @@ static uint8_t dccg401_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t s
 	/* for DPMST, this backend could be used by multiple front end.
 	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
 		uint8_t i;
-		for (i = 0; i != link_enc_inst && i < sizeof(fe_clk_en); i++) {
+		for (i = 0; i != link_enc_inst && i < ARRAY_SIZE(fe_clk_en); i++) {
 			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
 				num_enabled_symclk_fe++;
 		}
-- 
2.34.1

