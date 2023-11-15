Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14918C5AD4C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A468410E1A8;
	Wed, 15 Nov 2023 19:44:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197C310E58B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+0Stq0gsKkCy8+mDd/wvBvlnuZ3Aevltiv/KC1MgCv21afQSgwt9PjPNUpA+LrSWkg8WdSXU4alunrlYNc/a8MKade/ZZ/jSHugeCU+cxdAt1wfNLQPl8qNhcCQDrz9O877wYah49GU/RB96KUCHe0BD+gqrURBc9ts5PxKRmrUNpqsII58mGb4FRhfxbOWvu+A2VePYgfRX3beLKlAr03fBWS19L3n9dnvjST5wdIKUlOO/K1u9Be5QzaiS9g24sOK3DO/eeypWJy42mPyVQr6ACObZrED36B3aXb+pu5T9OM2RAVcoOIVOOPzNjkVGvsdDxfI/itTSGit1TsKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfVHgizQd+DsupPa0GOyTbLRPWkflvASmSy8JPypHDI=;
 b=NYB8+yPo06KXUju1lpolsxTWZ1vTZfw0bEavdyR7IrvGs+6sxbVR1LTowenIH83GEHut9GzjzjCbZl0lY1eric0LHoqFhmW0usUtXelAyrtQPTE1acII/4tIarBp4TOeP7R97rCQQeZcGgjYJujDk6l7i3vQE4IrVjTkP3e9iGeW0TF4n5Wngm55f9ODDzq6nn6+qkE9yWeJPivj3v3228fLIl3XsqHnTJaQRWSoYfgBe5VgDBUqPKEYUTmhveUaZ5e3EZZFXR7gqWtv41fbolr8s9JVRTp/RoGza7X4LJClsJBTCSc2/ImxQwQmlSYpEhIboiHE2zKAPlNWJIZrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfVHgizQd+DsupPa0GOyTbLRPWkflvASmSy8JPypHDI=;
 b=fGBzLM5liJ6WPmlHTTYtgCczHx+EqDntIJOwR4aLnf89nNH3hpo2crj+7/5q8WTN71Y34IvjvVuX7QgmEuci204PfNN/d92++EYfVBiARuf8B0L1FvJwElrH7rGGRqdroeYZ/yCD0A01jygiIybc95yJ1qlU5QoamaJr4F5GEQM=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 19:44:41 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::5d) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:41 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:40 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/35] drm/amd/display: Refactor OPTC into component folder
Date: Wed, 15 Nov 2023 14:40:41 -0500
Message-ID: <20231115194332.39469-29-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: b9603d2d-77b9-4e8d-d08d-08dbe6134fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RSDy2kJZyYViJCDBMVqXl5zAOZ441q68Kr7I2Z/jrTwrC1rTUsWpZ10CAAPBi20lRAxv59hfAv/87TlLMO/jkpaFU/l3xLqiMFnRX6dYFK3RjvdvQeNm2+nolQMgTe2ERvYRGLcOXv0H3mC3axNAYa9PwE9qGYiGktX8q3pRqDeZKcYTycCYr+yv5NXtw2Cp25KOkzl97SIsWByFvxcbemv1bCU6ijSWy4fD0kh2yf8NqHyKXxaFPATBF3whwQbmYQuojP2bvD3VZIBHy7aidUsEbVt0pk15s7kIEDdBxcyy8cUPpZJeNn85GRTtaQx0xj/F1nNGfjw5IQffwXF2jVAPWnPHMmOITsF0L+C0l+cJuFLUsZXVUK5m2Qilafokz1mmikHKCjk5iZydJo1B++ua+iQegA145vFcJg1Eux0QFTRsJTsOWHDZFiEEvHArPrPwDaVSPji5WTLuaCHMDSMSHSmvfcZ8ZiSuCORIcLD/QVCTQ/HaIVpe8JvHd7R6IORg+b8uRfwMqA4rY7L0erUdUrK00Q7X55/D6GrOERC+ffyGYjiVtAeEfNEFvGU5+3uUO4n/HohM9qur/JLeKZ9mcCVKnAJ0cjn3EZ4t/il3/fhPBDDl/XDZktos7j7L52uQ2+rEsez96Dj/j8UAq/9ksaD0SIVJ99+yKxwaZyb4k7UAOdG5yBNhFefGLr3WUvSf9MHXLiDxeTwNkuqNdHL9tzbQ+gt38KfL0Ggoh5C+7AOSqmsG3qGHU7Ubg9hAE8R9gwk6sCaay2rSgiFOpsbXTOifRUkh6Tte22v0Cx1YDx/mx/bbwuXxVBPHR8n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(356005)(82740400003)(40460700003)(41300700001)(81166007)(66899024)(47076005)(83380400001)(36860700001)(1076003)(336012)(26005)(426003)(2616005)(44832011)(2906002)(8676002)(8936002)(4326008)(16526019)(36756003)(86362001)(30864003)(316002)(5660300002)(54906003)(70586007)(70206006)(6916009)(40480700001)(478600001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:41.8539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9603d2d-77b9-4e8d-d08d-08dbe6134fb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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
Cc: stylon.wang@amd.com, Parandhaman K <parandhaman.k@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Parandhaman K <parandhaman.k@amd.com>

[why]
Move all optc files to unique
folder optc.

[how]
creating optc repo in dc, and moved the dcnxx_optc.c and .h files into
corresponding new folders inside the optc and cleared the linkage
errors by adding relative paths in the Makefile.template.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Parandhaman K <parandhaman.k@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/optc/Makefile  | 108 ++++++++++++++++++
 .../display/dc/{ => optc}/dcn10/dcn10_optc.c  |   0
 .../display/dc/{ => optc}/dcn10/dcn10_optc.h  |   0
 .../display/dc/{ => optc}/dcn20/dcn20_optc.c  |   0
 .../display/dc/{ => optc}/dcn20/dcn20_optc.h  |   2 +-
 .../dc/{ => optc}/dcn201/dcn201_optc.c        |   0
 .../dc/{ => optc}/dcn201/dcn201_optc.h        |   0
 .../display/dc/{ => optc}/dcn30/dcn30_optc.c  |   0
 .../display/dc/{ => optc}/dcn30/dcn30_optc.h  |   0
 .../dc/{ => optc}/dcn301/dcn301_optc.c        |   0
 .../dc/{ => optc}/dcn301/dcn301_optc.h        |   0
 .../display/dc/{ => optc}/dcn31/dcn31_optc.c  |   0
 .../display/dc/{ => optc}/dcn31/dcn31_optc.h  |   0
 .../dc/{ => optc}/dcn314/dcn314_optc.c        |   0
 .../dc/{ => optc}/dcn314/dcn314_optc.h        |   0
 .../display/dc/{ => optc}/dcn32/dcn32_optc.c  |   0
 .../display/dc/{ => optc}/dcn32/dcn32_optc.h  |   0
 .../display/dc/{ => optc}/dcn35/dcn35_optc.c  |   0
 .../display/dc/{ => optc}/dcn35/dcn35_optc.h  |   0
 31 files changed, 122 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn10/dcn10_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn10/dcn10_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn20/dcn20_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn20/dcn20_optc.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn201/dcn201_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn201/dcn201_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn30/dcn30_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn30/dcn30_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn301/dcn301_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn301/dcn301_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn31/dcn31_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn31/dcn31_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn314/dcn314_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn314/dcn314_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn32/dcn32_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn32/dcn32_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn35/dcn35_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn35/dcn35_optc.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 7b0959da2cac..92a5c5efcf92 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -32,6 +32,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hwss
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/resource
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dsc
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/optc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index ab51a065cf0e..390e7a99be54 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 1eb7418ced3a..0dd62934a18c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -24,7 +24,7 @@
 
 DCN10 = dcn10_init.o dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
-		dcn10_dpp.o dcn10_opp.o dcn10_optc.o \
+		dcn10_dpp.o dcn10_opp.o \
 		dcn10_hubp.o dcn10_mpc.o \
 		dcn10_dpp_dscl.o dcn10_dpp_cm.o dcn10_cm_common.o \
 		dcn10_hubbub.o dcn10_stream_encoder.o dcn10_link_encoder.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 92fdab731f4a..9033b39e0e0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -32,7 +32,7 @@
 #include "dce/dce_hwseq.h"
 #include "abm.h"
 #include "dmcu.h"
-#include "dcn10_optc.h"
+#include "dcn10/dcn10_optc.h"
 #include "dcn10/dcn10_dpp.h"
 #include "dcn10/dcn10_mpc.h"
 #include "timing_generator.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 93ac45802e44..bd760442ff89 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -3,7 +3,7 @@
 # Makefile for DCN.
 
 DCN20 = dcn20_init.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
-		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_optc.o dcn20_mmhubbub.o \
+		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index c069a894db92..a101e6511555 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -3,7 +3,7 @@
 # Makefile for DCN.
 DCN201 = dcn201_init.o \
 	dcn201_hubbub.o\
-	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_optc.o dcn201_dpp.o \
+	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_dpp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
 
 AMD_DAL_DCN201 = $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 9dcf06c0954d..cd95f322235e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -28,7 +28,6 @@ DCN30 := \
 	dcn30_hubbub.o \
 	dcn30_hubp.o \
 	dcn30_dpp.o \
-	dcn30_optc.o \
 	dcn30_dccg.o \
 	dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index cbf59d7e78c4..090011300dcd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -11,8 +11,7 @@
 # Makefile for dcn30.
 
 DCN301 = dcn301_init.o dcn301_dccg.o \
-		dcn301_dio_link_encoder.o dcn301_panel_cntl.o dcn301_hubbub.o \
-		dcn301_optc.o
+		dcn301_dio_link_encoder.o dcn301_panel_cntl.o dcn301_hubbub.o
 
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 212287008c0a..11a2662e58ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -11,7 +11,7 @@
 # Makefile for dcn31.
 
 DCN31 = dcn31_hubbub.o dcn31_init.o dcn31_hubp.o \
-	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
+	dcn31_dccg.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index 6ea47e00d62d..d5c177346a3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -11,7 +11,7 @@
 # Makefile for dcn314.
 
 DCN314 = dcn314_init.o \
-		dcn314_dio_stream_encoder.o dcn314_dccg.o dcn314_optc.o
+		dcn314_dio_stream_encoder.o dcn314_dccg.o
 
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 3bb17dd01e4c..905b74b53092 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -11,9 +11,9 @@
 # Makefile for dcn32.
 
 DCN32 = dcn32_hubbub.o dcn32_init.o dcn32_dccg.o \
-		dcn32_dccg.o dcn32_optc.o dcn32_mmhubbub.o dcn32_hubp.o dcn32_dpp.o \
-		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
-		dcn32_resource_helpers.o dcn32_mpc.o
+		dcn32_mmhubbub.o dcn32_dpp.o dcn32_hubp.o dcn32_mpc.o \
+		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
+		dcn32_hpo_dp_link_encoder.o
 
 AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index 85a307babab9..fa7ec82ae5f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -11,7 +11,7 @@
 # Makefile for DCN35.
 
 DCN35 = dcn35_init.o dcn35_dio_stream_encoder.o \
-	dcn35_dio_link_encoder.o dcn35_dccg.o dcn35_optc.o \
+	dcn35_dio_link_encoder.o dcn35_dccg.o \
 	dcn35_hubp.o dcn35_hubbub.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_dpp.o dcn35_pg_cntl.o dcn35_dwb.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/Makefile b/drivers/gpu/drm/amd/display/dc/optc/Makefile
new file mode 100644
index 000000000000..bb213335fb9f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/optc/Makefile
@@ -0,0 +1,108 @@
+
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the 'optc' sub-component of DAL.
+#
+
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+OPTC_DCN10 = dcn10_optc.o
+
+AMD_DAL_OPTC_DCN10 = $(addprefix $(AMDDALPATH)/dc/optc/dcn10/,$(OPTC_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN10)
+
+###############################################################################
+
+OPTC_DCN20 = dcn20_optc.o
+
+AMD_DAL_OPTC_DCN20 = $(addprefix $(AMDDALPATH)/dc/optc/dcn20/,$(OPTC_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN20)
+
+###############################################################################
+
+OPTC_DCN201 = dcn201_optc.o
+
+AMD_DAL_OPTC_DCN201 = $(addprefix $(AMDDALPATH)/dc/optc/dcn201/,$(OPTC_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN201)
+
+###############################################################################
+
+###############################################################################
+
+###############################################################################
+
+OPTC_DCN30 = dcn30_optc.o
+
+AMD_DAL_OPTC_DCN30 = $(addprefix $(AMDDALPATH)/dc/optc/dcn30/,$(OPTC_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN30)
+
+###############################################################################
+
+OPTC_DCN301 = dcn301_optc.o
+
+AMD_DAL_OPTC_DCN301 = $(addprefix $(AMDDALPATH)/dc/optc/dcn301/,$(OPTC_DCN301))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN301)
+
+###############################################################################
+
+OPTC_DCN31 = dcn31_optc.o
+
+AMD_DAL_OPTC_DCN31 = $(addprefix $(AMDDALPATH)/dc/optc/dcn31/,$(OPTC_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN31)
+
+###############################################################################
+
+OPTC_DCN314 = dcn314_optc.o
+
+AMD_DAL_OPTC_DCN314 = $(addprefix $(AMDDALPATH)/dc/optc/dcn314/,$(OPTC_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN314)
+
+###############################################################################
+
+OPTC_DCN32 = dcn32_optc.o
+
+AMD_DAL_OPTC_DCN32 = $(addprefix $(AMDDALPATH)/dc/optc/dcn32/,$(OPTC_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN32)
+
+###############################################################################
+
+OPTC_DCN35 = dcn35_optc.o
+
+AMD_DAL_OPTC_DCN35 = $(addprefix $(AMDDALPATH)/dc/optc/dcn35/,$(OPTC_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN35)
+
+###############################################################################
+
+###############################################################################
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
index f7968b9ca16e..c2e03ced392e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
@@ -26,7 +26,7 @@
 #ifndef __DC_OPTC_DCN20_H__
 #define __DC_OPTC_DCN20_H__
 
-#include "../dcn10/dcn10_optc.h"
+#include "dcn10/dcn10_optc.h"
 
 #define TG_COMMON_REG_LIST_DCN2_0(inst) \
 	TG_COMMON_REG_LIST_DCN(inst),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
rename to drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
rename to drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
-- 
2.42.0

