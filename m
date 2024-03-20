Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A81C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA1E10EEC6;
	Wed, 20 Mar 2024 06:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2g4k6vTJ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2182510EE9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQi+kJEcvar/n3RKpobhtu+mWSsSjHzI4vic01jSAidRym9C2hYU5WMRoTaZQZ4CmSn3Wq/hK1pk9jC3OxOhVKW2G6Fg9y8E92yZAq6Lpr9SzT0e3wvXXv1EmLVz3QaxsgAVIS+A4l+GQbkSohlaumsZS8DZYWxLtiP3jrLC7k1w9MJKrr5vgQKb/w6Hkz5VpLCxSgja8nWybl11Abc7loc/aSKz3u7Ws87qoR9Hv0TRxwvT0CackrQYyYSAOCyGOhdjo9a3KyLiYCEoyy3AZkdkFzzCle/I69HMDus8/P9D17G4/2pJddiN3rL0fc3lvo/0jbQF2t8NmDQrb4lV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhNFdeAPSVgwjfD1QTRhoto2fWxN9IkJZqk6bPVQ2eQ=;
 b=CqgNxy7KOtr6vaulBzYeCfwXwzFeeSrtUdaffZ9/aFQ5snA8TTDGGJ450tO3MZo3qN9jdXJe0aLlPIdcC16kWz5mifzQLWn2DPJFVTP50yuey2vf9/SbOkL0mow06g+rfDX0wP4suco+MXlLMu+bRfLpOF891pgSR/yOtjEROox1dyVqVSzAakESV8Wz1HYScs1muYsxrYQnPFPR+XYSAIciPK3O5OxM7WLVFQuJ5+F+0gS7FP8UM5HJiosL/zakYLYrcNNmnr0HL1/eB4Yjp22CZZUOdf2U0l32hIhKjge6CpEiW1OuTLhETklt1t196gYxQfyzngwhkq1VjTWx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhNFdeAPSVgwjfD1QTRhoto2fWxN9IkJZqk6bPVQ2eQ=;
 b=2g4k6vTJBioneXCe2TatGcxja1/C98AzqfzhM2bjuaeDFtEFfrJzPUFrk65rbVTjr5mVk3aePVCK/DJW0+N+J1KWIY+7xULRffRtZzYKlhY+EgloHbCpjwnCKK/tBTF97GtrpEboYCVzHkMc0aLReMdRBrdJBDtej/zpqwprk4Y=
Received: from BLAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:36e::17)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 06:37:10 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::7a) by BLAPR05CA0021.outlook.office365.com
 (2603:10b6:208:36e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:09 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim <sungkim@amd.com>,
 Xi Liu <xi.liu@amd.com>
Subject: [PATCH 16/22] drm/amd/display: Increase clock table size
Date: Wed, 20 Mar 2024 14:35:50 +0800
Message-ID: <20240320063556.1326615-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f592192-027a-4f6d-224a-08dc48a82be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqhxGD5DpjmQ4Q6DExSc2UryVk/zb9K5pRMKCvkbehlaHz7xLBbK7qThXutt9CZFSy/AHlkWxfZNnXLQV1LCfr8bXI6t3q0OrnI8hSlcMvsLx2e64kx7SKXmUJ0Q2H6JJSihs6NP8irZYglWzcb8+nhqKVmh9GLoWDev7jaVK/Od32yF/JrFIuxtWnLelYCDz735mS2gv9NeF+GxCRR6CkFKHupExwox/g0mVEMCPxBTRcIiJJXCF+06tFXVAhnc2oRULcmoOsMjHgopaViQ7pWvXQwLXUKE2dhAXiaBWMj+zMI+BBndUXDjZAxj0cprh0f/W1VI1dWUyrOnP4+1cOvtR9iv9R3XskKwxQ4netOcpAy/i8gdLx9kvn8JB435Id211TrG/3T0W4mnbAPtEBvTZLYOPsKkGvrRUv5tta5NmF6zFK3PJOaTHgVTJC+RXjcQuKsU0W0CVYReQfk9u6+vxpEWOrvXldc224t2gIRjC60IROyQj8cqaZKCU6MJ8gpG3/Q91kyAb/HZ2WoWb9HDcjWfKO+BgRhHDcqA+fW6FzUCzND+6Ysjc7N7fSkdHo9MZRbKGY2FdJKJhmhvSWAS7KH48Tk08GV8URDNPDeeBBFaMMg9FdVFHDBI/PavUGC9TosZT57/U08DvekoBrHIl7yAfHnlCjBuaj3BP5QQgKvLmpSoo9P8i0TuZc1oN9l5NRjV7evmPGWeXUj+rsBkxO2KkIw4j6RC9/OmR6C37LuA0vMW2pboazB1YSPG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:10.7113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f592192-027a-4f6d-224a-08dc48a82be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

From: Sung Joon Kim <sungkim@amd.com>

[why&how]
To prevent out of bounds error, we need
to increase the clock table size.

Reviewed-by: Xi Liu <xi.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../amd/display/dc/dml2/dml2_translation_helper.c  | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 0a4dff45731f..cf98411d0799 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -29,10 +29,7 @@
 #include "dml2_translation_helper.h"
 
 #define NUM_DCFCLK_STAS 5
-
-#if defined(CONFIG_DRM_AMD_DC_DCN3_51)
 #define NUM_DCFCLK_STAS_NEW 8
-#endif
 
 void dml2_init_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
@@ -258,21 +255,20 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	struct dml2_policy_build_synthetic_soc_states_scratch *s = &dml2->v20.scratch.create_scratch.build_synthetic_socbb_scratch;
 	struct dml2_policy_build_synthetic_soc_states_params *p = &dml2->v20.scratch.build_synthetic_socbb_params;
 	unsigned int dcfclk_stas_mhz[NUM_DCFCLK_STAS];
-#if defined(CONFIG_DRM_AMD_DC_DCN3_51)
 	unsigned int dcfclk_stas_mhz_new[NUM_DCFCLK_STAS_NEW];
 	unsigned int dml_project = dml2->v20.dml_core_ctx.project;
-#endif
+
 	unsigned int i = 0;
 	unsigned int transactions_per_mem_clock = 16; // project specific, depends on used Memory type
 
-	p->dcfclk_stas_mhz = dcfclk_stas_mhz;
-	p->num_dcfclk_stas = NUM_DCFCLK_STAS;
-#if defined(CONFIG_DRM_AMD_DC_DCN3_51)
 	if (dml_project == dml_project_dcn351) {
 		p->dcfclk_stas_mhz = dcfclk_stas_mhz_new;
 		p->num_dcfclk_stas = NUM_DCFCLK_STAS_NEW;
+	} else {
+		p->dcfclk_stas_mhz = dcfclk_stas_mhz;
+		p->num_dcfclk_stas = NUM_DCFCLK_STAS;
 	}
-#endif
+
 	p->in_bbox = in_bbox;
 	p->out_states = out;
 	p->in_states = &dml2->v20.scratch.create_scratch.in_states;
-- 
2.34.1

