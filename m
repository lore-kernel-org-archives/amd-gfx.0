Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F51F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC82310E2FF;
	Fri,  6 Mar 2026 03:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n1qf41M6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA93310E2FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwPsU7vUVrDMIwSvE8fG8tItGkPYVVpi7Fbj6DEEfFw5jJkR1F+xU9RdlIXHU9dpCE68BQiUUGTzO1u+kY43dQsELtkn73qhB5G5nHU04BxXQnzPMJoVQb5waNZeqDl1ojBB4lInEHt2AGq5+03tIgjkoIt5984wY6DROFd36w7z+fWQoyrzGNXCEKqo5nW4qzelkSX8urS3lh91OWNL4SCU7YOeJpBs3IFCl95945lzwPQEbUtfDytGGmxHapYT+DBiMWxHxf2yamD4qnAse0vJOpa5H60E7Mjwu3tmv7B+ynV2mK9BYTWjxpd0ozlOysekPiaDR7tUZCan+01OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLcO5a0L/TRH7r13/1gHDMJE7cJhUPnhtiDmDi9w5SQ=;
 b=m9qY69j/lKWd2UGRR8vvvZuIR0Qj4QTvkqeFiyyhfzDDroivPbdhfF1NAsxOCR+Js/qzDOoHvHLFSaf8rZzKaWzwRKw/UmPmqWLGJyb9M3bASY1naOiRm0nEgkFog4BOWT0hUIF6mc28kwOgqGsoOa5flhNTf8zpctx7NAwrQIMipH38lI/7z1KEtp/sxV665fr2zHy8I2cZTzR4TcNVRP0nWMb0JX/F4UuVZVohZvjhrfuu1T7hjszAFkcdhSatmEz0vvQgJC08/TJj+GWmtx6lkUvUcOEfvDlZFW9G5ljOgf5/NxXn2dkKpZ7v732zmIc5giG2sBMi8y6Kwv1Vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLcO5a0L/TRH7r13/1gHDMJE7cJhUPnhtiDmDi9w5SQ=;
 b=n1qf41M6/2FYVa68Ciq/ZWpiNLMW0knK/EDfsp27Unh+CU+O3on9HbIF29+Xx0EaIU5YdOD5lbRpVh68HlMWXmE02eCCud+d42PyzzHf4KWxDAoYblh6ep70/UHZfGSpifNNFddF1LeziqquO7LaeUPsFIprAhOoRw27Eyoe29A=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 03:25:51 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2a) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 03:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:25:50 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:25:48 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/21] drm/amd/display: Add missing DCCG register entries for
 DCN20-DCN316
Date: Thu, 5 Mar 2026 20:13:35 -0700
Message-ID: <20260306031932.136179-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: f677b3b5-f114-4347-cb0c-08de7b3010bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: mwioiXDwPHew1Z5QtLo5oRoWRckTwF1SfnhwLW3BizXBx2J9Eh8PlF2yxH1PNvIdyRKHSCzT9iDa+DsnPrKH3vOc+hPkkGepJttuxI5N7kEnkPrW47oUOyVnebM/RbAMwAUXwhN60zQwlfbIrKVcyRDZdVUT5To7VU90hLyQ4j6v/k4dmNW/TMwDZEVmNkKpAvleH+3cgSUTgc7Cy6dkaH5h+zb5x5RX+E5PNxSiB+wZiBa8HJFmD22/COSkIkxXW9ILSDrrJA1AXHxcTGY94jkr1esM1rf+TjQZPRQTvUx6nmqYDyjAsKSQKdfcfJPiCZJdalFKynVgjnFQusIZPRLJF41TGrd48vGCfQ4iC+T6C4Olc58tw07rf/FjdLZpFkNNO6tAhh1UkHTm6jnLO5inKxUIqYqwC0jETIx816UnjWfHLO1cGJ+97JP8z+jaalPoVuAUIkbIRAR0STFv5YElT50PjRWS1OsFWl30gmDyIMnw3KnIGA4OGH+qHUUdCt9pr/s394M3nY15lsmarpa0evBtFR8ZQ+qOnSe/ioxLHs3D6vz8ooYiAflBDz6spAk30jAbpr2E16FfVrrqrswx+8a3SDOwICeDmZp6adar07zGVVSRdNa3xT4mPwhYgx5CmYMp5RDrY3Cv37dflrDJHto6clNYzJ0SC6MB02Mw3qYdiPOucP6206j4HezWYZJ6fkNdldf/HpOKY4c8kVcsn9H51UzCgHzZd58r60XMcKY019tm5KyE7wzTmlbb1Fq3Xomqa9BuLV94SzP6pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u/LUFNgEjS9rwku7Lab5yRlE9mYaPg5vpbfFvmxzFnz6C7lXaroWQQ2gCfDKGxoaivMoWSzj5SQnourRFRi5EI1w4T+VWwIzAhh+2CfJWj0NP0X574l/8nwqQxRJejKL1pLIMeHh8d4C2bgBGx1/9XMVBvJIl1v13PkC4GV/Y3ky8cNSRTGnRNaTJ04okaXt0yp415t4/BbwVEwbmqgZSiQvIyNCrD2LVWE/mZLtGfcHrE1eGsHTEpy9C4rR6Rxvn6d2emxDticD0pP5eENBYdg0BjPDPkT7IBB03xuJ7I82+6+LKu+L1lsriWO4KcEw1aoY+eRfEQB/OT7hOUV/JetzzOxh1OpsTEmQUGvVi8m25n7a1Squ+qtBeIswcaAi50zFBFDCQY2IZbCoSm6ltFQYVbExyNbRtV7nmFGBohto6DxbJI9XJy4zodM5CYM4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:25:50.1465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f677b3b5-f114-4347-cb0c-08de7b3010bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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

From: Ivan Lipski <ivan.lipski@amd.com>

Commit f5472343f468 ("drm/amd/display: Migrate DCCG registers access
from hwseq to dccg component.") moved register writes from hwseq to
dccg2_*() functions but did not add the registers to the DCCG register
list macros. The struct fields default to 0, so REG_WRITE() targets
MMIO offset 0, causing a GPU hang on resume (seen on DCN21/DCN30
during IGT kms_cursor_crc@cursor-suspend).

Add
- MICROSECOND_TIME_BASE_DIV
- MILLISECOND_TIME_BASE_DIV
- DCCG_GATE_DISABLE_CNTL
- DCCG_GATE_DISABLE_CNTL2
- DC_MEM_GLOBAL_PWR_REQ_CNTL
to macros in  dcn20_dccg.h, dcn301_dccg.h, dcn31_dccg.h, and dcn314_dccg.h.

Fixes: f5472343f468 ("drm/amd/display: Migrate DCCG registers access from hwseq to dccg component.")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h   | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h   | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h | 5 ++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index ffcd2e139e76..463f5826a1ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -38,7 +38,11 @@
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1),\
 	SR(DISPCLK_FREQ_CHANGE_CNTL),\
-	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL)
+	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL),\
+	SR(MICROSECOND_TIME_BASE_DIV),\
+	SR(MILLISECOND_TIME_BASE_DIV),\
+	SR(DCCG_GATE_DISABLE_CNTL),\
+	SR(DCCG_GATE_DISABLE_CNTL2)
 
 #define DCCG_REG_LIST_DCN2() \
 	DCCG_COMMON_REG_LIST_DCN_BASE(),\
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h
index 067e49cb238e..e2381ca0be0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h
@@ -34,7 +34,13 @@
 	DCCG_SRII(DTO_PARAM, DPPCLK, 1),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 2),\
 	DCCG_SRII(DTO_PARAM, DPPCLK, 3),\
-	SR(REFCLK_CNTL)
+	SR(REFCLK_CNTL),\
+	SR(DISPCLK_FREQ_CHANGE_CNTL),\
+	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL),\
+	SR(MICROSECOND_TIME_BASE_DIV),\
+	SR(MILLISECOND_TIME_BASE_DIV),\
+	SR(DCCG_GATE_DISABLE_CNTL),\
+	SR(DCCG_GATE_DISABLE_CNTL2)
 
 #define DCCG_MASK_SH_LIST_DCN301(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
index bf659920d4cc..b5e3849ef12a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
@@ -64,9 +64,12 @@
 	SR(DSCCLK1_DTO_PARAM),\
 	SR(DSCCLK2_DTO_PARAM),\
 	SR(DSCCLK_DTO_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL),\
 	SR(DCCG_GATE_DISABLE_CNTL2),\
 	SR(DCCG_GATE_DISABLE_CNTL3),\
-	SR(HDMISTREAMCLK0_DTO_PARAM)
+	SR(HDMISTREAMCLK0_DTO_PARAM),\
+	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL),\
+	SR(MICROSECOND_TIME_BASE_DIV)
 
 
 #define DCCG_MASK_SH_LIST_DCN31(mask_sh) \
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
index a609635f35db..ecbdc05f7c45 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
@@ -70,11 +70,14 @@
 	SR(DSCCLK2_DTO_PARAM),\
 	SR(DSCCLK3_DTO_PARAM),\
 	SR(DSCCLK_DTO_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL),\
 	SR(DCCG_GATE_DISABLE_CNTL2),\
 	SR(DCCG_GATE_DISABLE_CNTL3),\
 	SR(HDMISTREAMCLK0_DTO_PARAM),\
 	SR(OTG_PIXEL_RATE_DIV),\
-	SR(DTBCLK_P_CNTL)
+	SR(DTBCLK_P_CNTL),\
+	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL),\
+	SR(MICROSECOND_TIME_BASE_DIV)
 
 #define DCCG_MASK_SH_LIST_DCN314_COMMON(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
-- 
2.43.0

