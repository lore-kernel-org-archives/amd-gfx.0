Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01890C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA31E10E12B;
	Wed, 14 Feb 2024 18:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y8IVJqcv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ABE10E252
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R329ITZh3J7JG89bKIKS0N+kiLIPxhkqkBvM+rKteTVjijMl9S/uXgJAZefSt7CESGM0/0oW3NqruF9B+pRpkJ2zKwk15zklhPcWNnpkyvudnJ5VW31yO00MvU54E9fEFV1qOryWDFnJIBbalJy2k8Lwd8eU8KSGsBRO7ZczdU3s8pcM4i2QZ++VbQiZ03mNMQiYGnrwC9RqXnPAEx/6hGGjn7uhbdrGUPQ856siYnSWI4YKgtvPvZZVFVKT5/NMXfSAG1ed3qtIf9iNYFZ2srzZ7G6h6sDEmICjhFS6qQfAv4JjNHIaC1fTvYXfe+QlCZIRdfmfqqgHoSNkYBPZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjYJzV80knMv2YQ+uvJJGwIGyJfcZ8YQ9sYIZfj7p+A=;
 b=LAqmvDMdagCioECQPmHPk0QjXNA9b6tycRd4jZkboUzCn+vaU8/ege70W0+fbqsJehwIFB5TKaB1wC8jfx18uxIu1cIgkcXsjXX+DR/MgO0FeI4ayQeBpOAHO6h32S+/AWo/Zt43KuRLFjDJy2d1F/OgcqUPdO0h+EWF27+xIIyIOla8+wFArjG5Yofd23tR8HjDfi6d4cJbEjXBAF3InGlzKoA9aLs5KEPECAVGMJiWL2XKuEmgQ+GaYG0kaNJADiaLZCLuUQRfUnJbZW7nVOuUhlvVYEbIXKIbO3zmbakdyStAp2k9jgFDQHC+GHeilfPeQePcB5h9AN0lCFNsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjYJzV80knMv2YQ+uvJJGwIGyJfcZ8YQ9sYIZfj7p+A=;
 b=Y8IVJqcvnuKFcIlbDsCkCrsSOvUaohJ8OCXPn+hDFLo4JuTmx0R71PwSuvM7cSGCgJM4PJGNFSIhdoqf57bfTtTtkG/LluAkmUoIVhJkzBjGwYz8Sa3fvgOa/0Z6UmJJITVeAPs80Z/BBrNB5ndYEF+JnXeFsLXXnkUhyjf/fE8=
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 18:40:34 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::8e) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:34 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:31 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 02/17] drm/amd/display: Initialize variable with default value
Date: Wed, 14 Feb 2024 11:38:33 -0700
Message-ID: <20240214184006.1356137-3-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea80f77-4075-44d3-cb98-08dc2d8c6e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UrY8Gts0CmZNoRofDt9oS24Qy0V/mGxuqP/sNEPiXnJCv7yF0uebAWy2ZAFY0Crvc8DXFxeghgMnPMkGE7K+3P4OvvqKFKnHP6Jtwx+Y50/EYSRfujfDdckX/mTga69q3gfK/xoMe97K0L8xNWA4LQ9OPGH6L/ojgX0KXTgJbl7ETfTygajy03lRrBnrj2t2EQYfI2Beh37MPralcmp6sruI7MttHwWXMt69ym2FhhQQLeJ1OoeCJN2ZTRzdp9hzKmCHg3yeIQAmpgAtrjGT9YuQZN3NIkb8mie7i0mU17t68a6uHMfWjz+0pdn0hsvO8yoTJqTkIi4fP1HDz0wVT5eTBPUONEHXENreeNLmPJgZPC7eLQT47LCO8Y3iDtuRc6VJyedqDf3XtzOti3CcDrh2fihO8AjSTObEucAl7YEms9iCzdNl8nSOMKdPHONcM0d0p0ufzrJSNsBb1myZfEk1diKSCIW05MeojwHd+kHnzTF9IDGk646ExN1iQoiLSGQQlNoaJQ6e2GSHatR5fzkZRtinL8s+F6X+MHzSRwK2v3Uz0brJlwwqLyzCrS6/aFxLqtek33Q0lEJnyskhEyntcn3A14Q4EFKn5kvw7k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(4744005)(2906002)(8936002)(8676002)(4326008)(5660300002)(426003)(336012)(2616005)(83380400001)(16526019)(1076003)(82740400003)(26005)(36756003)(81166007)(356005)(86362001)(70586007)(316002)(54906003)(70206006)(6916009)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:34.7307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea80f77-4075-44d3-cb98-08dc2d8c6e41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

Set a default value for target_div.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 26feefbb8990..b77804cfde0f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -132,7 +132,7 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 	int dprefclk_wdivider;
 	int dprefclk_src_sel;
 	int dp_ref_clk_khz;
-	int target_div;
+	int target_div = 600000;
 
 	/* ASSERT DP Reference Clock source is from DFS*/
 	REG_GET(DPREFCLK_CNTL, DPREFCLK_SRC_SEL, &dprefclk_src_sel);
-- 
2.43.0

