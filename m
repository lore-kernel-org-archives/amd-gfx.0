Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F49C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9D110E5FB;
	Wed, 28 Feb 2024 18:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EeLYsaR4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFD210E5FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbOFGAtOLfIoGM+oRTbMVbJhhUsujnG3laqtP2d/gapedzAzFmAa+8wJyrkEBi5/hsKXJFRES/re1KfjtQEJLgICZdm/gFwwGG9C86TQrmK8iNGoS3Lh7ONL+TBaAbqdYV2AFtD7VjNLkOf66mh7FM924XNa/FNeyWl7/EE3+s3mqcEBL6RiXWUVAjmAolrvBPrXP4tCNW4QVgypuw/sh7DiGHlGHRxgzSeKQyTwjG+2e4vswEo8RqdYOES/jq6zM57jRzlNgPBR5PGK+LFKnS2XAbjlKjUZxOKdgk59CGZqflQC8alTXnZ7VvIL66p7nK7zZL7HTRlT0bGCd4jYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNqiO6HbiIxjd8BXnMhLWURcq52tES6yRdQW3V65fTI=;
 b=ZLBpdPF+MAVFph1tOiJepwwEzDd12SNUSsOsqyjZnJhTYM4UQ2bylFHEkUpOf3b4RnmMOK9wRZF0gGhFE9E3JCidgrgVARWsg9SHLoFbnG9Aw93mpXkKBqScI+jfmOgSW8GW3Zlt/xEia0FwFNeY6lvomyBvQWNwsV5TVL82lkdsD6L0jFX+4TQCKDjR7Q4XqoLio8ELfV0zfyYHAEPv4TfM4SZBbvSFjnkG7CbpZvtzAizCwGjrAAt8Z9PauJtyD2m90QdE1K4NE9g5Q1pewLoCp48jCmw9nO1g9sjIG54ektS0zL5aAnlincew1RPVwbra/85LM1cCLcNE1IlrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNqiO6HbiIxjd8BXnMhLWURcq52tES6yRdQW3V65fTI=;
 b=EeLYsaR4hydbaUhBWbSH+V7l2dfVDC2WIrgAkF0595d/BUcKv/EYZ9MsFqAduFIpTB8z+pOLnS6NXamSnE7GKV/2XnLUG9TRies6+zEpFI7yR4Mq1r+bTOAdMtejPgmrRa9vHYfsQh8Qk2w+tQnBaiyN36z1pjHjL6U+vVNz6mY=
Received: from SA9PR10CA0006.namprd10.prod.outlook.com (2603:10b6:806:a7::11)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:46:12 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::ac) by SA9PR10CA0006.outlook.office365.com
 (2603:10b6:806:a7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 18:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:46:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:46:09 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Revalla Hari Krishna
 <harikrishna.revalla@amd.com>, Martin Leung <martin.leung@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 24/34] drm/amd/display: Refactor DPP into a component directory
Date: Wed, 28 Feb 2024 11:39:30 -0700
Message-ID: <20240228183940.1883742-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: e8139659-6198-4ed6-6869-08dc388d8928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEUrR8wUKQ2W2l6FzopSYxPS4PepJNxZIxsVKCjq5d88EMibDRSQl1APzL22kGVYSvBqr7k/C6bwxvmlLPKXDViDZ+HoH1reFptozrF4E2ZBq2b6mXDzoulTUoP+6HOLA7fDP9OqNVpiDxhCyiMfOlZ4B4chUOONTdJmZe03LBhK5htCsbxjL8j6NTaHRw+qINsT79I7nQejHQqanARVy15YVJGG13RxGLVAomXIuhb2vtYxE03z5eRrMUd67AM201RhmS+Kqb1hAuxwMjmrqvvrvYf0GaOkcIC/jJLagZjngGUEE+sFWu7l13GB8ZGfI9cYmcjYp37UXpvxM1ygKxrMl4rYNPcr9EE0e/iqBl/TsKo1AOh3FU3SzJ5IsCMD1+4fEKami06Z9wpF62C36c5xKIfDfSMLYQliDudb8rWKBigW6gW9ljGBwUjbj89cqM3A0KDPg7ULUQdUDINi+rRbzF/z7xE9urOsEhh8bMspH1N367H8I8nsI9+saCeBX14ZdSoxIYqL7d0+3+fV7AmLe5LEUznD/iNvQP6XsepZwZKDA1XGMM8AgBB8qgtKcappd3ws257NAiakan60pgKT5r/9Q+B3QCuk6yf/hD/nIhKM/zjZwqu7SaPm3c/+Uxtl5ZuDJ276ZCruwnlTSzwQ4YI5m32j8KmJkqNxH0OQ8GE7AItEJunmhukEO3N6jTo5wApORNjDwtJj3gZ7rRQF/+G6eNaoLFoRJYr9K6syp3k0TIr/bImSEbkboRyE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:46:12.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8139659-6198-4ed6-6869-08dc388d8928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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

From: Revalla Hari Krishna <harikrishna.revalla@amd.com>

[WHY & HOW]
Move all dpp files to a new dpp directory.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Revalla Hari Krishna <harikrishna.revalla@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |  1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |  4 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  2 -
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   | 77 +++++++++++++++++++
 .../amd/display/dc/dpp/dcn10/CMakeLists.txt   |  6 ++
 .../display/dc/{ => dpp}/dcn10/dcn10_dpp.c    |  2 +-
 .../display/dc/{ => dpp}/dcn10/dcn10_dpp.h    |  0
 .../display/dc/{ => dpp}/dcn10/dcn10_dpp_cm.c |  4 +-
 .../dc/{ => dpp}/dcn10/dcn10_dpp_dscl.c       |  2 +-
 .../amd/display/dc/dpp/dcn20/CMakeLists.txt   |  5 ++
 .../display/dc/{ => dpp}/dcn20/dcn20_dpp.c    |  2 +-
 .../display/dc/{ => dpp}/dcn20/dcn20_dpp.h    |  0
 .../display/dc/{ => dpp}/dcn20/dcn20_dpp_cm.c |  2 +-
 .../amd/display/dc/dpp/dcn201/CMakeLists.txt  |  4 +
 .../display/dc/{ => dpp}/dcn201/dcn201_dpp.c  |  2 +-
 .../display/dc/{ => dpp}/dcn201/dcn201_dpp.h  |  0
 .../amd/display/dc/dpp/dcn30/CMakeLists.txt   |  5 ++
 .../display/dc/{ => dpp}/dcn30/dcn30_dpp.c    |  4 +-
 .../display/dc/{ => dpp}/dcn30/dcn30_dpp.h    |  0
 .../display/dc/{ => dpp}/dcn30/dcn30_dpp_cm.c |  4 +-
 .../amd/display/dc/dpp/dcn32/CMakeLists.txt   |  4 +
 .../display/dc/{ => dpp}/dcn32/dcn32_dpp.c    |  2 +-
 .../display/dc/{ => dpp}/dcn32/dcn32_dpp.h    |  0
 .../amd/display/dc/dpp/dcn35/CMakeLists.txt   |  4 +
 .../display/dc/{ => dpp}/dcn35/dcn35_dpp.c    |  2 +-
 .../display/dc/{ => dpp}/dcn35/dcn35_dpp.h    |  0
 33 files changed, 128 insertions(+), 24 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp_cm.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp_dscl.c (99%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn20/dcn20_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn20/dcn20_dpp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn20/dcn20_dpp_cm.c (99%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn201/dcn201_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn201/dcn201_dpp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn30/dcn30_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn30/dcn30_dpp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn30/dcn30_dpp_cm.c (99%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn32/dcn32_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn32/dcn32_dpp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn35/dcn35_dpp.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn35/dcn35_dpp.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 92a5c5efcf92..9a5bcafbf730 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -33,6 +33,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hwss
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/resource
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dsc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/optc
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dpp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 7991ae468f75..4e9fb1742877 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index ae6a131be71b..8dc7938c36d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -24,9 +24,9 @@
 
 DCN10 = dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
-		dcn10_dpp.o dcn10_opp.o \
+		dcn10_opp.o \
 		dcn10_hubp.o dcn10_mpc.o \
-		dcn10_dpp_dscl.o dcn10_dpp_cm.o dcn10_cm_common.o \
+		dcn10_cm_common.o \
 		dcn10_hubbub.o dcn10_stream_encoder.o dcn10_link_encoder.o
 
 AMD_DAL_DCN10 = $(addprefix $(AMDDALPATH)/dc/dcn10/,$(DCN10))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index b7e57aa27361..0f951f4293e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -24,7 +24,7 @@
  */
 #include "dc.h"
 #include "reg_helper.h"
-#include "dcn10_dpp.h"
+#include "dcn10/dcn10_dpp.h"
 
 #include "dcn10_cm_common.h"
 #include "custom_float.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 3dae3943b056..9b6070c99794 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN.
 
-DCN20 = dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
+DCN20 = dcn20_hubp.o \
 		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index 2b0b4f32e13b..3880db59e457 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN.
 DCN201 = dcn201_hubbub.o\
-	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_dpp.o \
+	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
 
 AMD_DAL_DCN201 = $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index b5b2aa3b3783..c6ca70f3c061 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -25,13 +25,11 @@
 
 DCN30 := dcn30_hubbub.o \
 	dcn30_hubp.o \
-	dcn30_dpp.o \
 	dcn30_dccg.o \
 	dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
 	dcn30_dio_stream_encoder.o \
 	dcn30_dwb.o \
-	dcn30_dpp_cm.o \
 	dcn30_dwb_cm.o \
 	dcn30_cm_common.o \
 	dcn30_mmhubbub.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index ddb344056d40..b8327237ed44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -26,7 +26,7 @@
 #include "dm_services.h"
 #include "core_types.h"
 #include "reg_helper.h"
-#include "dcn30_dpp.h"
+#include "dcn30/dcn30_dpp.h"
 #include "basics/conversion.h"
 #include "dcn30_cm_common.h"
 #include "custom_float.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 5314770fff1c..a58c37165f5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -11,7 +11,7 @@
 # Makefile for dcn32.
 
 DCN32 = dcn32_hubbub.o dcn32_dccg.o \
-		dcn32_mmhubbub.o dcn32_dpp.o dcn32_hubp.o dcn32_mpc.o \
+		dcn32_mmhubbub.o dcn32_hubp.o dcn32_mpc.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
 		dcn32_hpo_dp_link_encoder.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index 0e317e0c36a0..d5b4533d2f62 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -13,7 +13,7 @@
 DCN35 = dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o dcn35_dccg.o \
 	dcn35_hubp.o dcn35_hubbub.o \
-	dcn35_mmhubbub.o dcn35_opp.o dcn35_dpp.o dcn35_pg_cntl.o dcn35_dwb.o
+	dcn35_mmhubbub.o dcn35_opp.o dcn35_pg_cntl.o dcn35_dwb.o
 
 AMD_DAL_DCN35 = $(addprefix $(AMDDALPATH)/dc/dcn35/,$(DCN35))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/Makefile b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
new file mode 100644
index 000000000000..99bd36073561
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
@@ -0,0 +1,77 @@
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
+# Makefile for the 'dpp' sub-component of DAL.
+#
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+DPP_DCN10 = dcn10_dpp.o dcn10_dpp_dscl.o dcn10_dpp_cm.o
+
+AMD_DAL_DPP_DCN10 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn10/,$(DPP_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN10)
+
+###############################################################################
+
+DPP_DCN20 = dcn20_dpp.o dcn20_dpp_cm.o
+
+AMD_DAL_DPP_DCN20 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn20/,$(DPP_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN20)
+
+###############################################################################
+
+DPP_DCN201 = dcn201_dpp.o
+
+AMD_DAL_DPP_DCN201 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn201/,$(DPP_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN201)
+
+###############################################################################
+
+DPP_DCN30 = dcn30_dpp.o dcn30_dpp_cm.o
+
+AMD_DAL_DPP_DCN30 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn30/,$(DPP_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN30)
+
+###############################################################################
+
+DPP_DCN32 = dcn32_dpp.o
+
+AMD_DAL_DPP_DCN32 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn32/,$(DPP_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN32)
+
+###############################################################################
+
+DPP_DCN35 = dcn35_dpp.o
+
+AMD_DAL_DPP_DCN35 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn35/,$(DPP_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN35)
+
+###############################################################################
+
+endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
new file mode 100644
index 000000000000..1318c6fba3e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
@@ -0,0 +1,6 @@
+dal3_subdirectory_sources(
+  dcn10_dpp.c
+  dcn10_dpp_cm.c
+  dcn10_dpp_dscl.c
+  dcn10_dpp.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 4e391fd1d71c..e1da48b05d00 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 
 #include "reg_helper.h"
-#include "dcn10_dpp.h"
+#include "dcn10/dcn10_dpp.h"
 #include "basics/conversion.h"
 
 #define NUM_PHASES    64
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 2f994a3a0b9c..20481b144609 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -28,9 +28,9 @@
 #include "core_types.h"
 
 #include "reg_helper.h"
-#include "dcn10_dpp.h"
+#include "dcn10/dcn10_dpp.h"
 #include "basics/conversion.h"
-#include "dcn10_cm_common.h"
+#include "dcn10/dcn10_cm_common.h"
 
 #define NUM_PHASES    64
 #define HORZ_MAX_TAPS 8
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
index 5ca9ab8a76e8..808bca9fb804 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 
 #include "reg_helper.h"
-#include "dcn10_dpp.h"
+#include "dcn10/dcn10_dpp.h"
 #include "basics/conversion.h"
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
new file mode 100644
index 000000000000..9c2d7096348e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
@@ -0,0 +1,5 @@
+dal3_subdirectory_sources(
+  dcn20_dpp.c
+  dcn20_dpp_cm.c
+  dcn20_dpp.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
index 1516c0a48726..56ebd7164dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 
 #include "reg_helper.h"
-#include "dcn20_dpp.h"
+#include "dcn20/dcn20_dpp.h"
 #include "basics/conversion.h"
 
 #define NUM_PHASES    64
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
index 58dc69926e8a..131a8de8e0f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 
 #include "reg_helper.h"
-#include "dcn20_dpp.h"
+#include "dcn20/dcn20_dpp.h"
 #include "basics/conversion.h"
 
 #include "dcn10/dcn10_cm_common.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
new file mode 100644
index 000000000000..7711cd3c47a7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
@@ -0,0 +1,4 @@
+dal3_subdirectory_sources(
+    dcn201_dpp.c
+    dcn201_dpp.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
index f809a7d21033..345202fee40f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 
 #include "reg_helper.h"
-#include "dcn201_dpp.h"
+#include "dcn201/dcn201_dpp.h"
 #include "basics/conversion.h"
 
 #define REG(reg)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.h
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
new file mode 100644
index 000000000000..0faee2a1e32b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
@@ -0,0 +1,5 @@
+dal3_subdirectory_sources(
+  dcn30_dpp.c
+  dcn30_dpp_cm.c
+  dcn30_dpp.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index a3a769aad042..0c31b12cacaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -26,9 +26,9 @@
 #include "dm_services.h"
 #include "core_types.h"
 #include "reg_helper.h"
-#include "dcn30_dpp.h"
+#include "dcn30/dcn30_dpp.h"
 #include "basics/conversion.h"
-#include "dcn30_cm_common.h"
+#include "dcn30/dcn30_cm_common.h"
 
 #define REG(reg)\
 	dpp->tf_regs->reg
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 2f5b3fbd3507..ce1b3cf7e1bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -26,9 +26,9 @@
 #include "dm_services.h"
 #include "core_types.h"
 #include "reg_helper.h"
-#include "dcn30_dpp.h"
+#include "dcn30/dcn30_dpp.h"
 #include "basics/conversion.h"
-#include "dcn30_cm_common.h"
+#include "dcn30/dcn30_cm_common.h"
 
 #define REG(reg)\
 	dpp->tf_regs->reg
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
new file mode 100644
index 000000000000..7743edc4599f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
@@ -0,0 +1,4 @@
+dal3_subdirectory_sources(
+  dcn32_dpp.c
+  dcn32_dpp.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c
index 681e75c6dbaf..41679997b44d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c
@@ -26,7 +26,7 @@
 #include "dm_services.h"
 #include "core_types.h"
 #include "reg_helper.h"
-#include "dcn32_dpp.h"
+#include "dcn32/dcn32_dpp.h"
 #include "basics/conversion.h"
 #include "dcn30/dcn30_cm_common.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.h
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
new file mode 100644
index 000000000000..91df5db26435
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
@@ -0,0 +1,4 @@
+dal3_subdirectory_sources(
+  dcn35_dpp.c
+  dcn35_dpp.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
index 3341ef71009b..0146b36b93d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
@@ -25,7 +25,7 @@
  */
 
 #include "core_types.h"
-#include "dcn35_dpp.h"
+#include "dcn35/dcn35_dpp.h"
 #include "reg_helper.h"
 
 #define REG(reg) dpp->tf_regs->reg
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
rename to drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h
-- 
2.34.1

