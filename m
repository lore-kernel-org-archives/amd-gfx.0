Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B3AECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D4910E3D2;
	Wed, 14 Sep 2022 05:12:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F04010E3D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr2D7SKQxuhk1veng8q2DG+Fp8SwDwpcOcE3o/IYlShJd/HSv4bWBWW6+bdwROH3+Im97wegAXtANAxu8Qtdrnj/MS8s+LiGLeEUNtZLB7cz0uG0jeDp0X7XaDjw2g/n6jtyF74agxvXmWKCV3+ksBU3lOHMyablGXs2La0681/41aR+L+Vo6Woz4yFQkdIZRCQJySA2w9oNVXCo1nyQSVO9ofxeQNY59eLhtCBG/42f2k/V4I0DmqvxoRzcnJRxI7HS0lJ+YPK2b0XvVc2Rqkrha4u6XvuXyBToL+pFzwRxnaRGmQE4zf89ciHA3NXqffj7CcJ9BWGJ4AGgMIPv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z43r3GQmq04E+JSa1GafTxTNRMX5ifOP2hMGZFaFQBI=;
 b=RidAW9DwmYPYqiJHzer5g3ejf2wRqomq947HHPNudBnIrINNKO19epfeZmWWwUVnMqDU3euNnKLB31PTDkxIGA8bY3cvdSS8WbLjqFaAXZlJlMykeV7R43KQpVTUCuWFAIWpdu5XQtPAYlzHoaJj2Ts2+vR7Ksb/Nw+0Fw3/W4mV10qYE9pHw/8aDsu6gbV7GoLJM4vg4PZfI9viHM0u+7MbCw03hXTluQ1ApzWPUNKwnsoPHlTytPAslC7eqL67xUK8WypNDepTP4f9+sZL33UsMjmxAkPzEcBsJnOfphY05qf73j9mbvDgp3Aei9Jhkb47V22BySjRTPQA5Y6+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z43r3GQmq04E+JSa1GafTxTNRMX5ifOP2hMGZFaFQBI=;
 b=5fxSWoI09TvKDe505pJ035hvUBrI+EOZkkAFjXnVrzBYnc76fMOXoio168MO4UWyamRosLj/Y6fgxGiiglFJkmWBnZfw4Hhaohn8bCSr2uaGuP3bVhJzvgcadSYMy0/aV4UPX+MZHyd/NdymoHB5EWLsNELRX3PKtQsajw4bUCc=
Received: from DM5PR07CA0103.namprd07.prod.outlook.com (2603:10b6:4:ae::32) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 14 Sep 2022 05:12:20 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::f8) by DM5PR07CA0103.outlook.office365.com
 (2603:10b6:4:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:12:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:11:58 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:11:48 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 02/47] drm/amd/display: Remove some unused definitions from
 DCN32/321
Date: Wed, 14 Sep 2022 13:10:01 +0800
Message-ID: <20220914051046.1131186-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a5c6b6-0a68-465a-c694-08da960fb345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgmkAWiVhaTrliU46FYNOwv8Le/S9+tPefQEuadZAkz88DwKFWQLU/2DJKGIB0MiZc4yY9aQ74hZhBFWDQuDlIlmjMlSVTPKxgyXBpHPF46GkRLCkrZ3HmbMzzTudyMbMBL06nKuI43Wd06VV8v29wS7ASDLzFGWqJ6wBzoWv20KtDefpEEAF6Yq04nlExOhDqDMNp2bIY6B+GdRFA4IIJZlM0SvasdRzyvG/my82HqZdSOo5ruNeR8Q6PTyo+6Bx0bLN4VNohH3zRUgGWzGqF7RmuxzoX5xz+yEDSjTlZhMXuWtDmqbYte6XUCbpmDvwi1GwzWdNSE/YpmBDpqkyADZ4MI98NuMcQOVbocBHjbkqyTmH7Vu0UIYMXRnNcglYRjtutMC6+B4EuBcke3Br4fQ/Fv7ky3ICpt9i8pJyZ7/qvc8krazkqdMUdH1agNvvoniz9NQ1pZbNX6gQJ5KCfWuEugXPAhnv8NFpUoZtBHjqB3dgEH7oPocXgXKondZNET7CNOQPNjEEf2Mrj2fKCJRT8ve6n5r2w3bt9Ta5VyAoHZAH+v70SEFBvrCrU/l9jYvVKDTx1hiQ8XGkgQ5wBNhDvvPik26CM/UV9P2U28iwIG180SXjIm3dvASPpP8OlpFGqsy9GtC8K2IKguVKI02LBy/t2Oa+IXeirYsWHyW/ChbVYffGEVDdvcNKqhmmITSVkkzt/YlMJHMVeTaUJvSnyKFExZtxrkN951XibW4VJqb8WsghXXFGD4DfevzusCxUHFuyOhfA7idpNyoqw0fTIDkoe9pSWxIYGdcJqfiWDT4jOmq1IkQMjm2yO0w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(336012)(83380400001)(70586007)(41300700001)(8676002)(6916009)(86362001)(40460700003)(6666004)(478600001)(8936002)(186003)(36860700001)(26005)(82310400005)(70206006)(1076003)(4326008)(426003)(47076005)(81166007)(2616005)(5660300002)(82740400003)(316002)(54906003)(356005)(2906002)(36756003)(7696005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:12:20.1779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a5c6b6-0a68-465a-c694-08da960fb345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

