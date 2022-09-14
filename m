Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34455ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BCB10E2D9;
	Wed, 14 Sep 2022 03:49:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3AD10E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2ue0TFVwl7glcQq7Pubp9cVO2oHF9mI6LbfdSOMUZRpRHzOUyEyK+EzD4LYFRhzCZT6UZxuwjSg5L9q3NgTMMeX5y9AteMo4LlFgr4R+i06FCUVsD+TNbSNt0LL/koFrf+XKTlaIkNihRpoQD4vkU+de+f91XBHeq6xBCZktxPCiq4/KQI+slR0tyG0QGha6NgJC0RdKh0i9BRQ3OtuE9MTEC0TGXu0Ysj/2E/QMSxyOAocBrUvx+ksoy7YxlmuHaMBAviwd644c+o/3F4vQrkx5YJlPJUzUAKCQJQLEzsHr9qqgMJaX/Jh/KYxREHIMXhe6X3t0K6vSvr5YYWNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z43r3GQmq04E+JSa1GafTxTNRMX5ifOP2hMGZFaFQBI=;
 b=Zk/JbnT08hZlwVwVoFXwkRtX49PptOL/pndd4lx4TTGOgLF8BN2b6/RnAYW1hhno0/cwKdYnLJWHDCpUgea7rVsvLeSoCm/Tu12qVL3rN6XYF0F0MN2XcmxiM2yQo1siBAX6NUPxEftXu/rNIZXvI6cdqE5WL391YDpRYG3v5fCmHXvA//IHWwFDoOOB79yIiUNeNCwuUwAsy4/5YvPlpadmiu5yyUDAJLc3RiZplfBsueNFxLgifz7+YDwPyfBLkr2DYD3bBbfHGuLUlibdAG5jOVHkLxPCIbMwF5sjErJFJUw6rdWgbfFppP6N1iv8Wt7ycm61Lf4lqtNqZh8IPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z43r3GQmq04E+JSa1GafTxTNRMX5ifOP2hMGZFaFQBI=;
 b=vo/Xrp2eJ7Df6Nn3JPI6CjrSP25ERUVmEdeyG5n9dHTqOnVwWJKrIvKW6HknrvBiOMSgYWSrPWJ4InV48wh0G5sMxVBElUbngygoS2zvChHOHUORU19hMcMRRv3KZ9KtyM2ErQNOWCJ2Bvo6D8i5lUf2D9gr4ZDn642YbBpMBpA=
Received: from BN9PR03CA0543.namprd03.prod.outlook.com (2603:10b6:408:138::8)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:48:49 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::29) by BN9PR03CA0543.outlook.office365.com
 (2603:10b6:408:138::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:48:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:48:46 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:48:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 02/47] drm/amd/display: Remove some unused definitions from
 DCN32/321
Date: Wed, 14 Sep 2022 11:47:23 +0800
Message-ID: <20220914034808.1093521-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 06da2d18-3d5d-40ac-2577-08da9604080c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQaL9IKSUUErPn5YDuG2fVu1bVNXOIJ1fsMss/ZsABLKhSmJL5PURe1/350MzazGZQgQ8wai0C3hA+0QsIfH9OBjo6tvjfBLP7Z0XzqDTs9Z+0w1tGbYJqII1biJHoPTHLdZTEg96KkxEh4GCP6jHJMlXX4DBT1/xFzkZd+fau2CbXk4wSONf3v1dZ0EFdvqXXzv1IQ4g0nuG0llq09Jh4t5ZPOSAnwV38UAF5GonSXjZylRnxQ44hghnZ0e7ZVqmI1L1yBCG+TsDDWWF5INI/nRflw2gR5tMfNie2c21TFzgD76NDu0FQkAnefA7xdl6YoODEAZFFLfC/JgQ+IzQsSbjXg/eLXeZgq1Ge5Xuwko2X0PXHWvDxYBq8IClkFfq93mB/gvg/y33NmogBdQ9hHhKRvvbaXiEEbiKXwg6mpx4Oi+CsWJ4J7+jcqbwGxlkeJuRpz63uDpT32/axCfT+luKQk6U5HyUczowwaKsfWbPAVAc28TFbsgZLvuBAPwtjwfvJQQxtidd7XkbtaNzTuFim89sFUHGSykKCp9++B82mJcjE7jEaRJ5R/wJ5JGPz1h/xNrn+hr4bQxpdpHo9kRxWrrqZ4Wu9IHUFVuk2++nlY0z2VOz39S32Y9taaQ5a6J3nwrF70279CTwCbNy1+ebTUELCpa8T0W8aRCjvMkC4oz4wWuKnWgyaQvM1yJCYUYpGT5jbsU7cDmQFfUo52QqxVYv0THjOPDW7p0C0mQGNJ/YmemxdLeeKs/lPkfMdJm1kBl3AtF1b2uj0ckqLmcuR0XDyKDbHXQ7u+mejPa3t4jMympmL/3g636kWYw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(8936002)(82740400003)(36860700001)(6916009)(40460700003)(426003)(26005)(8676002)(70206006)(1076003)(7696005)(70586007)(186003)(86362001)(4326008)(40480700001)(81166007)(5660300002)(6666004)(2616005)(82310400005)(54906003)(47076005)(36756003)(478600001)(2906002)(336012)(316002)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:48:48.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da2d18-3d5d-40ac-2577-08da9604080c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
After reg offset initialization was switched to runtime rather than
compile time, some of the defintions are not needed anymore and can
be removed.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 23 -----------------
 .../amd/display/dc/dcn321/dcn321_resource.c   | 25 -------------------
 2 files changed, 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 11f1435b8c07..e0038d576aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -90,29 +90,6 @@
 #include "dcn20/dcn20_vmid.h"
 #include "dml/dcn32/dcn32_fpu.h"
 
-#define DCN_BASE__INST0_SEG1                       0x000000C0
-#define DCN_BASE__INST0_SEG2                       0x000034C0
-#define DCN_BASE__INST0_SEG3                       0x00009000
-#define NBIO_BASE__INST0_SEG1                      0x00000014
-
-#define MAX_INSTANCE                                        6
-#define MAX_SEGMENT                                         6
-
-struct IP_BASE_INSTANCE {
-	unsigned int segment[MAX_SEGMENT];
-};
-
-struct IP_BASE {
-	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
-
-static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } } } };
-
 #define DC_LOGGER_INIT(logger)
 
 enum dcn32_clk_src_array_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 1bbc0bdf5dc3..60bf6e1b2972 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -93,31 +93,6 @@
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 
-#define DCN_BASE__INST0_SEG1                       0x000000C0
-#define DCN_BASE__INST0_SEG2                       0x000034C0
-#define DCN_BASE__INST0_SEG3                       0x00009000
-#define NBIO_BASE__INST0_SEG1                      0x00000014
-
-#define MAX_INSTANCE                                        8
-#define MAX_SEGMENT                                         6
-
-struct IP_BASE_INSTANCE {
-	unsigned int segment[MAX_SEGMENT];
-};
-
-struct IP_BASE {
-	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
-
-static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } } } };
-
 #define DC_LOGGER_INIT(logger)
 #define fixed16_to_double(x) (((double)x) / ((double) (1 << 16)))
 #define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
-- 
2.37.3

