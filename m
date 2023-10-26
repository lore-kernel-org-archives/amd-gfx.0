Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C7DC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424FC10E810;
	Thu, 26 Oct 2023 14:20:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BE210E805
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLXxlPlpjBQpx7og50FdSE4Txrr3ZFvJSZWQPzBSVvZK2kZf9WSE9s6KyN0uczqXCuim79r0zw8xy1REyMoLX/y6AFiIpeyLZUjbq7+ihMpb77VYpIFIZkbv3zFm9aCwWJilNh6ipYkD0nOCuzJeLCzpQiDNyxMVdKJLaYSaUlteA7unh4UExhEDDoAPXs8Ycv5B3NNrtW05u25H+dZ8o3t3VZobeYWTu9z2opeaoToToZdK953pxd53X0bErGVz8fh7qClSK3XGdYwRQUEqVA9fCwnhhNS7NfLkbdliiSk1pKyvyDUWt07p+shM0YZ7m2rbLqmgMabqJcOE1KUcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzTOzSOgV21ORgUIWHd2LpH3AT7iiiTVrbWbIyBBgJE=;
 b=Qq7WDSjwPXXZ+zG25ZZDIoXzIXZKsff0mzTgRi6bio10a6v9zHTSsQfXzPryOJUewXI4lZYjltxNZKa5u/tOqkx+uHwUAiS2NwpdddNYV/RRXLDBw/1wARv7QqM6M4I5DSuHEPqAROzxtZr/eNQvRxe0Jud+AswADYxZhhpwSGdPqbXjQUMUWIuPX2xbIu6C0IgZ/9DBjsNgBOQ2kzAiYtlgvd118qwnxGgwhbUMGBcydU9tL1eHUcW9WQWLILlDAtXqi4XMWSAOQdccXeaV6MPfdDo5A/2cHc55xZCVIT/ANLxEMgUAvk9N+Qn8aOR1dutWku+98fECVI/f05gwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzTOzSOgV21ORgUIWHd2LpH3AT7iiiTVrbWbIyBBgJE=;
 b=VUN/24NhqswvETL6kobyvAInazbiGC3T7sV9KdXJVl1rsf0fJCN9I0axhcxnUoSSfrQ3Me0M9+DVpyfknhjOPwEC1KNNKQUJgxPWoVe04zZ34B+CFKXLLKZk0Eorad4Epfy+JzA19IV3lq7zgvQDq4pvDb7LyPzi+H2sfTjxJMo=
Received: from CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:20:35 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::42) by CH0PR03CA0087.outlook.office365.com
 (2603:10b6:610:cc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 07:20:33 -0700
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:32 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/25] drm/amd/display: On boot disable domain22 force power on
Date: Thu, 26 Oct 2023 10:20:01 -0400
Message-ID: <20231026142020.67861-7-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a5d5e8-f5a6-4e2a-ad23-08dbd62eb80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McwxrA2WkxOAFhrkBLEprk+mdVPnoVV+JGjsAGHfA+aWb+M/7bU9UcjNW6iPrXTJTCz0Xo4c9R04HLz3rxocay1Wav8Q+YBtSxzFnfOf6rfnh3ehFxjFEWMedW3ZEX2xEZp00u3mNX/+ToPlH5Dvbe0NGV54XhTRT1VONS0UD0JBs2dlCLy8lMBZKf6n7dWZtUo0cl+vnLiUvZt8Yg2hihvNFQOrl1vFIHcLIzVDPS3c0vwEANPnDEDlw8Z29NTlf6+bL/NASL4/VNHRZAbX9aD3bk04r1c8qsSr5GCu9NDQbxNlSX7I97JLOU33w+swb8LeVanhLpMTf9nT0K6Rl+tPeIGNJ7fVyWPc/2KAG7F1SsJxVtOYoK0qwbxtrQme28Nza88OoXsH21mrmwf+Bn8IHOHzHA5nt7O0ORo2r9Al9EdEaNQ2/1L70gpjdZuCuXcU9NuWlqXYdU/9of+FNXLezqh5qRTJRPeDkENwka45hJ7/hDwE2GnkaV2O6QXg7plfVP59xESS0aok+Ejr3aX/JFafe2A5Q6DBRs0zCHDY3YXpW2XvdUbWsTTcFYAS3gwc6co4X3EjO4BuepePjU7COD10hFfovp3VJYRr4Zhsg5aHGQZk9wt44E5GU8czXOKQNM+ifgttp6S2vbnOrSfribzzLIlHduDHhWG0NbF0m22l/FahKtQ5miEcJwJLEP4i0I2U+Yv1htvgk52mc5ibOlRLIxNFekDX0gDf1DUYZVPZWuidtdp5LRA08WrqzVeW51e/81+/PdjPkK4Omg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(26005)(2906002)(6916009)(36756003)(36860700001)(8676002)(8936002)(4326008)(40460700003)(6666004)(41300700001)(1076003)(70206006)(478600001)(54906003)(5660300002)(82740400003)(356005)(81166007)(70586007)(316002)(83380400001)(86362001)(336012)(47076005)(426003)(40480700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:34.6238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a5d5e8-f5a6-4e2a-ad23-08dbd62eb80d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
HDCP2 enablement fails when domain22 is set to force
power on

[How]
Disable force power on for domain22 on startup

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c   | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h   |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h        |  2 ++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 0f60c40e1fc5..46f71ff08fd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -332,6 +332,13 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	pg_cntl->pg_res_enable[PG_DCIO] = power_on;
 }
 
+void pg_cntl35_set_force_poweron_domain22(struct pg_cntl *pg_cntl, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+
+	REG_UPDATE(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, power_on ? 1 : 0);
+}
+
 static bool pg_cntl35_plane_otg_status(struct pg_cntl *pg_cntl)
 {
 	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
@@ -501,7 +508,8 @@ static const struct pg_cntl_funcs pg_cntl35_funcs = {
 	.mpcc_pg_control = pg_cntl35_mpcc_pg_control,
 	.opp_pg_control = pg_cntl35_opp_pg_control,
 	.optc_pg_control = pg_cntl35_optc_pg_control,
-	.dwb_pg_control = pg_cntl35_dwb_pg_control
+	.dwb_pg_control = pg_cntl35_dwb_pg_control,
+	.set_force_poweron_domain22 = pg_cntl35_set_force_poweron_domain22
 };
 
 struct pg_cntl *pg_cntl35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
index 3de240884d22..069dae08e222 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
@@ -183,6 +183,7 @@ void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
 	unsigned int optc_inst, bool power_on);
 void pg_cntl35_dwb_pg_control(struct pg_cntl *pg_cntl, bool power_on);
 void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl);
+void pg_cntl35_set_force_poweron_domain22(struct pg_cntl *pg_cntl, bool power_on);
 
 struct pg_cntl *pg_cntl35_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 34737d60b965..ff46e36cb254 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -311,6 +311,9 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->res_pool->pg_cntl) {
 		if (dc->res_pool->pg_cntl->funcs->init_pg_status)
 			dc->res_pool->pg_cntl->funcs->init_pg_status(dc->res_pool->pg_cntl);
+
+		if (dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22)
+			dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22(dc->res_pool->pg_cntl, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
index 00ea3864dd4d..b9812afb886b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
@@ -47,6 +47,8 @@ struct pg_cntl_funcs {
 	void (*optc_pg_control)(struct pg_cntl *pg_cntl, unsigned int optc_inst, bool power_on);
 	void (*dwb_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
 	void (*init_pg_status)(struct pg_cntl *pg_cntl);
+
+	void (*set_force_poweron_domain22)(struct pg_cntl *pg_cntl, bool power_on);
 };
 
 #endif //__DC_PG_CNTL_H__
-- 
2.25.1

