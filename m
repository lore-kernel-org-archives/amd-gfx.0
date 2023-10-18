Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0953CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2873B10E44A;
	Wed, 18 Oct 2023 17:44:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C9510E44D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht75IQYiKh+1qHX00MbxEAZWuVFDuT3S3jYbjzv+G2CcRkMVq/dY8PKh/+XpecmbPoDivmXSRPwO+A6aD6ZpXTvxJQpiyGlcpMBJoebDctvY4xyw9PRWYgSUTmsXnT8skvC6SrcU3lJ9Ss4w0XF7v9NOSCh7c5TzyqiF1y5wRbTkvrmtlocq5TrSgKmFyst+COILlmzeWBrFmSyV7Sw8qvcu3Q8EbNPNhSydbS6HrPrRekDCBFpHzfF39vvsIGvJKOhaHzYmFtyrkKyZoWngRXOeA8b2ixSpqxU8lOF9Caxtw0Bv04kUco74K02JNRpZfsXd89GitpC+c7uW1WBuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJRyzy/rpfU8CXPksLbYB8BO6lQC6242thDUWNoXEUI=;
 b=jCUBK3PRPZMK2x7jHtJ5U7QpVAKqObO/oQ7P60SAe1n166203J55Zm/3lGOVgFsTM13tePmiIriadBgNuDDtdsA9o6607jiqdTMwutaQ9mLU95F7Uf6OdjOz1qpbef7E0vUXRXkMfv4CTwRCOorTnFoAG1j9J3XQZ1Ke/S0NI/dR1z08pL00GLF4OBwwPjCffLb2QLochV2rQeVhOVyiC2pauzJk+F6KqYU9Hk8Fb68h1NqbzWG654tlU1phGeqGrqvvCK9X47CTDEhfsghy6qb/2mirDVA+xihrzXGgsoQbVNyMaE6VmBXfo1ClBjmeT4rjWrv3P/Ivs+qELzQfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJRyzy/rpfU8CXPksLbYB8BO6lQC6242thDUWNoXEUI=;
 b=Y80E8s0CcqNKZ1boGpalt9Cb/Caots4K3Aik+R8yf3PQZRq+Z/xExoCvX8qV0zLX6EczjF80ieaXKc0w1QyKsxnVF1epycJelJHd+JYmTbNiTgSEiO+Jodp5TswLFKqkMzJ2spdJsJYhyDVq5ldlvYEhtJtt7/FxQuFJTzTdqMU=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 18 Oct
 2023 17:43:59 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::85) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4 via Frontend
 Transport; Wed, 18 Oct 2023 17:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:43:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:43:07 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/26] drm/amd/display: fix num_ways overflow error
Date: Wed, 18 Oct 2023 13:41:25 -0400
Message-ID: <20231018174133.1613439-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: a80e9395-7da8-47e7-e75e-08dbd001cf0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChCoZZM2kaGLKRGPTEvbOPBE6fByV5U0sUAR26j3z9TwuZTXmov4BfMCGd1lYQarbujbH+EUr6GCl5VL6yMHyIiV/m9yrJgXn7jajXbsl9kQkQYwxmuefEMo1GkhM01wb0GF/gVrgyduMU5lI/vQc87sR3qdVkbC1BlsWd9IDwhTqBX2cq6yE92T1vk3rBDOFMdfe8Kt0l/8f3M1vCK0n3kz7cnYKk0v6WyXD8sczHLpjvH3/R4a/g+yV3edqlANuz2JzgJvzQyJPaRp1wVI3ysXIL166oOxhU/SWLa4y0GNbYR1uJ2dEVHxqGwxXi67+WTbNl1cX0M2LGEbV8e7P1kbOAMICYzkS+x8kjAsIo0uli12Cguf9it+LhaANL94elqGWjq66/QdRZvCk8l9f5FbqAlNpnG6LSuZB/D2J8khkshFqECngsXzYUWlOANHwQChZnRqNIN93CeqpVL5xDDBDGbYI5f2SLqAE6QJoLjLG/fLQ5/TcEgavLs2kqvw+Np5oSG8f7ROp7L2Eijv4/SjmYCMkJCIsJk0Kt7s4oJCA6MRmRX0+fWvGDdgVyc7uPCXc+G1/4LpWm1IIcZJMrRzwqAlGM9yYmk2FDjS1S3xkWaUhiSPV3+LRJOrFak8i0F/PwFf5SLND8R/SLCg4oFF4FgOXoHVz2s3EkO1wyS7eD14D6ZoQs7o1+I/S+UPJTtunCvPDAu0vS6JMI+DucK3PaAABJkuKOXdpMxr3/3Y2j883FfABA7Tk7YKALGdkLBCoDuFVSKq0BFAbse/Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(46966006)(40470700004)(36840700001)(478600001)(1076003)(7696005)(40460700003)(41300700001)(83380400001)(2616005)(82740400003)(356005)(86362001)(36756003)(6666004)(336012)(36860700001)(81166007)(2876002)(2906002)(40480700001)(426003)(316002)(6916009)(54906003)(8676002)(70586007)(5660300002)(4326008)(47076005)(70206006)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:43:58.9262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80e9395-7da8-47e7-e75e-08dbd001cf0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
Helper function calculates num_ways using 32-bit.  But is
 returned as 8-bit.  If num_ways exceeds 8-bit, then it
 reports back the incorrect num_ways and erroneously
 uses MALL when it should not

[How]
Make returned value 32-bit and convert after it checks
 against caps.cache_num_ways, which is under 8-bit

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 68dc99034eba..2173d84e4953 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -217,7 +217,7 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
 static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
 	int i;
-	uint8_t num_ways = 0;
+	uint32_t num_ways = 0;
 	uint32_t mall_ss_size_bytes = 0;
 
 	mall_ss_size_bytes = ctx->bw_ctx.bw.dcn.mall_ss_size_bytes;
@@ -247,7 +247,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
-	uint8_t ways, i;
+	uint8_t i;
+	uint32_t ways;
 	int j;
 	bool mall_ss_unsupported = false;
 	struct dc_plane_state *plane = NULL;
@@ -307,7 +308,7 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
 				cmd.cab.header.payload_bytes = sizeof(cmd.cab) - sizeof(cmd.cab.header);
-				cmd.cab.cab_alloc_ways = ways;
+				cmd.cab.cab_alloc_ways = (uint8_t)ways;
 
 				dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 
-- 
2.34.1

