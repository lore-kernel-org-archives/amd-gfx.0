Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D4CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 18:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BB010E04C;
	Tue, 10 May 2022 18:35:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E4D10E04C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 18:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbK+RXu9OV8UxsiLIzFROX2WehbtjRRHvJZr8xnwk7pzppcMVQLtOiZ4wqIlvJTg2SZ5CV+3L4afqvBajDgAIAbb12lZmXSJ7n/HLY0HpjyifZ9tZ9uq34aGEQVBy0FlkHG6QqC99Ii/sbrXEMOxqFJFj5p1nQVK9gI6t9SKb1CCNvnoCy1wXT5NS8rORyRygNXz6wHGUN2ZcnmT0wq16T10AF9k8INzi2Yllm4uaEgO6DprVoZNzNUt0gyR73OMxo55ZnPlilej/IuTnBygh7iW2ZF70gVJjdAKVHZ1tJ4mXRKCFfnVGDXbRGQyQcz8g83qYmnG45UdSNrwj2X7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FxwN4FgoJNj9kaP5rZABBNDv2FSZX5VvQuPD9LT2P0=;
 b=g0a6rP+nklFURkmcSS2ptDALjB6S1iJnJvs4QGAh6hiV2xKyp0CKD2fh+AK0Mvmp2+J8jykKzo/ppuN4MlmpKFUsmo+LIwE3Wi9ick3f28IyV7oNCTkx4LPze80SAw3MYZaROFrcy1d3ZHSsDTz8sTGwdBdDY6dtMycwdFYKnWf9EhXJ8qI4D90o7btcrGiRH+KJYVgSvglZZdu1vOTr7wx7A45kJ3h4g6NhhBAboBhhjmomWoQyh/+SLa7LGVOWQqasaRg+KdKdcRYGkI9eIVmEfINsqPR8igGhepbYisMcVmzIdSkv2lvwcwASDnvoqfO0WmCmmfshJ9f7iI+waA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FxwN4FgoJNj9kaP5rZABBNDv2FSZX5VvQuPD9LT2P0=;
 b=Q/wrtmxezZi+9vXNZd+6vvkh8FVQfFmkLyWVEgWY2uNZimjH4t5NVV2YZb6cKkJASXVjjYMQ+YCqX/gr7aGuxklwc2EP+B1g3/08XLFgN4xp7+Slt/P8nYfdaVqNnLvN8RL2kMluJpC5p9dMfV93ktPzS2nAusqVcXNx+SuifeE=
Received: from BN9PR03CA0582.namprd03.prod.outlook.com (2603:10b6:408:10d::17)
 by CY4PR12MB1544.namprd12.prod.outlook.com (2603:10b6:910:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 18:34:59 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::f9) by BN9PR03CA0582.outlook.office365.com
 (2603:10b6:408:10d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 18:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 18:34:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:34:58 -0500
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 13:34:58 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <praful.swarnakar@amd.com>, <hersenxs.wu@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix incorrectly reading prev_dppclk
Date: Tue, 10 May 2022 14:34:31 -0400
Message-ID: <20220510183431.895489-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5db6897-9f3d-4aa9-c4c3-08da32b3c9bc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1544:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1544FE24B242035579B69FADF9C99@CY4PR12MB1544.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJe9kKeiCRpu2vQGQenvg1d8Csm1EZwiFB3dKkN63GQNc479AIrege8RzoO/1DUDfPFmUPYvFefWATctzFiANxx0oAZk5CCtTWz2H2pJJZx339sXYYpT14IGcVicV6Axx6nZWesMT62twMsuoBQ2O980WFQeo7IrOnxSQm0VwJ0hhUBvJYwDQzbCo4cUuLxlawNAXncnkwmCUNBMBHQhD9AWlBGDjcHKO+OQviR6uigeeHV6IE91f5GObntB0jH+lvQIzaMU1v2UITjnEuGa27x3EjwHsm8Az42bEADLLNH7KLXQVtDw0WjSLyruN0wkfu+EgA9U/5bk3IDP0m81sN7brWwKW9QiyysSWquVk+AGEokvXgU6aoMqrMSF9pP9JonbVa/RktRy0AiZYOe4Gxg9O5I2isoRgKMtARoXUDgCcZDMB6jjNBLCzRf1PHf7+A36rNjw3HiuRfc4IjBur7tp8Gi1J4uVruzH9S//bdCKb+bdAfNS0iCyX10aP+s87H5gUpRz0qIUck9m0uF5l/ZNCHJEhuR/bT6naMrraJgmEybPoVysMKVxoOY8Ngt/sTgFvCM13+ZvpeLb51TJcglW48e3JiK9pWjdRRidMNmGcDr53tWyXHeBVVj46BZxCuPOggc4lv2jyR9OdTBIgpi/QLzoLwwiuy3KCUQzkWEwSxT7Jv6nV3/a/JwqVzBVYAqpndRftozPxDxA0y8wzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(40460700003)(336012)(186003)(1076003)(508600001)(2616005)(47076005)(26005)(82310400005)(86362001)(36756003)(6666004)(36860700001)(81166007)(316002)(54906003)(6636002)(110136005)(5660300002)(8936002)(2906002)(83380400001)(4326008)(356005)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 18:34:59.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db6897-9f3d-4aa9-c4c3-08da32b3c9bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1544
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.corp-partner.google.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.corp-partner.google.com>

[Why]
we save the prev_dppclk value using "dpp_inst" but when reading this
value we use the index "i". In a case where a pipe is fused off we can
end up reading the incorrect instance because i != dpp_inst in this
case.

[How]
read the prev_dppclk using dpp_inst instead of i

Signed-off-by: Bhawanpreet Lakha Bhawanpreet.Lakha@amd.com
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 02943ca65807..cf1b5f354ae9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -122,7 +122,7 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		dpp_inst = clk_mgr->base.ctx->dc->res_pool->dpps[i]->inst;
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
+		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[dpp_inst];
 
 		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
 			clk_mgr->dccg->funcs->update_dpp_dto(
-- 
2.25.1

