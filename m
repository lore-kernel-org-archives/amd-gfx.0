Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDE9C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69D310E60E;
	Tue, 10 Jan 2023 16:57:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D18810E609
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmEj8Zw+TSkBxK/Jc9wZ22HPpIpscIAhtLU/Lpy1mR15OddB8pWLOrxwKFLyacG3Lhq73akzcZdCzjIRK6xAaXxIjmiiecsLJ2oO7GImbCDoY3w0FaMXe4Nw1nozauxsbJthPZjGFkOEPZtVxMxCMa1rrhUQgWywVO/XdaC8XcQYNZA5y3n7r/5tloqfJE9oPPGmf0nv3SvefrWH/VfAd8uFSB1e+MhjAC6Hd5IT9mSuvfPfuSSBBJPMwafbB6aM3d3Mw92Fx7pNbd484qdhV81Lhn7xQ8BaSiCGwdYPrLpHO1csoZPaYQf1EZTdo3W8x/LfbyHdviIDNhln3thHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3IYr/tb6AfBNoO/2tQpzp7EgYHtw8oXP77wsxg7dok=;
 b=KVupfBHEypD4NIcS3LLyK1P+478jB90TznQddIyOzwCsuRBgglmEiwUKsHI917QF7EbAc7wDa+qFBtOz7nBvZGDSren46kUS2aFNFmw37IgG2BVmq2jB/DBXLBBDsvKGcvJHkLq5+cY/XEzmhC9ZzYRexa5M30aZWE9ztoSUFN+Jdm3yDJTqbqx914ZnWBuafpCaxjTPSR1424KNME50Ddltf7C1PYeoPeIpMIa2IK16Ya+wfGf9P/QDDUPn0neCevBI40J2LZBgKK70f02t0qXhNXHCYouN4NXmUJvMTfYIbP7f9xDrtYMN7GAvRbNTuMQV3R0dwWEqjk79PeUtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3IYr/tb6AfBNoO/2tQpzp7EgYHtw8oXP77wsxg7dok=;
 b=U4K00egu853Z2hDTYs15OmKlMfQg5u1Zm+HXTc/QheH25C4Upd8pXMfreWCfSIksxtU1APEuEosWnATlT73cbkPTKTWsZZ4WhZ4LKN9pJ6NCboyIvvViopJemYz3uRDcvYqwtm8UTcv5koyi7d/eZJkIlrybc8zTeoPJ7KF6U5c=
Received: from MW4PR04CA0181.namprd04.prod.outlook.com (2603:10b6:303:86::6)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:11 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::60) by MW4PR04CA0181.outlook.office365.com
 (2603:10b6:303:86::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:10 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:08 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/37] drm/amd/display: move dc_link_dpia logic to link_dp_dpia
Date: Tue, 10 Jan 2023 11:55:07 -0500
Message-ID: <20230110165535.3358492-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5cd647-dfc7-4624-fbe3-08daf32bb715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQm1LzhT7pa3nCxOKVfEgZWZbQ4yOgkmrozoMdy8G+G/UY/Mup655dJXqN7ryz1THF+3yd1RBQF98jmOECUc0n7Yz6S8ZyMywRKLfUjr8Mq8MZCbBJoiG7CbPN6MX7h5OqenLxwTKuUFtSW6jKhmrdIbwxH2Kym5MlHwS3DuCzeP/oVIoiT8GPpd8YPXvKN6RV5MeWexZvzDxzf6T4w7P4kX4rXpqGSZzw+82TjDHPG9Odcvi7YnDquwYD1SS4WLje0lpJNR4xBg+vGOlXuUV4n7/V7uQa0Ih9xUkXnhb0/Tt4OOPokWOsEa43zy9oSU2uAEwnML07yGImiVQxQs4fU5ZLLvL+WJ0CgQ/47ksYxOzdEufulaf1UFamB4o36AK+r+8vlHTO+pSukOMeKNweHSeoD5m77CzASLfsKNufogk5cHhKDGfH8mPQ6sdpx0QYlzK7QEGzK3KemxoQP6hOX6L46p+nTjQTo2Et3ZYTu4Xg/TOgZzbWdVOeCCtekF5j6/Klek1k3S2sV+4hddduq++TNUiBC0QHd6yQtNG/ikA6kWpvg94rlT75qWJWtxfARE4/vx0eWaq9e365oBNUNDdkEoOfRjWWBEcR2EsDrDyBjfsNey2XT1Jfnci//jIMuLQlMxcO6+IwwOmjntWlz/B9JLH1Y+BpWaq4NfQNpSICE2wh1r0J4WrJ7Ibo3p2hCAuWl0WCvb7FnPaxNh7+qmPz0de3+zbY4Egs1YSms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(186003)(1076003)(5660300002)(40480700001)(316002)(7696005)(16526019)(26005)(2616005)(478600001)(40460700003)(47076005)(6916009)(4326008)(54906003)(8676002)(336012)(70586007)(70206006)(41300700001)(82310400005)(8936002)(83380400001)(86362001)(36756003)(426003)(36860700001)(82740400003)(356005)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:10.5598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5cd647-dfc7-4624-fbe3-08daf32bb715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile                       | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                 | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile                  | 2 +-
 .../display/dc/{core/dc_link_dpia.c => link/link_dp_dpia.c}   | 3 ++-
 .../display/dc/{inc/dc_link_dpia.h => link/link_dp_dpia.h}    | 4 +---
 6 files changed, 7 insertions(+), 8 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_dpia.c => link/link_dp_dpia.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{inc/dc_link_dpia.h => link/link_dp_dpia.h} (98%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index c5b7bcba5a3d..98c508313350 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -66,7 +66,7 @@ include $(AMD_DC)
 
 DISPLAY_CORE = dc.o dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
 dc_surface.o dc_link_dp.o dc_debug.o dc_stream.o \
-dc_link_enc_cfg.o dc_link_dpia.o
+dc_link_enc_cfg.o
 
 DISPLAY_CORE += dc_vm_helper.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b20dde4b05d5..cb3a57190cb7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -33,7 +33,7 @@
 #include "gpio_service_interface.h"
 #include "core_status.h"
 #include "dc_link_dp.h"
-#include "dc_link_dpia.h"
+#include "link/link_dp_dpia.h"
 #include "link/link_ddc.h"
 #include "link_hwss.h"
 #include "link.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9f2f10a957f6..9edfcdf3db3b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -37,7 +37,7 @@
 #include "dpcd_defs.h"
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
-#include "inc/dc_link_dpia.h"
+#include "link/link_dp_dpia.h"
 #include "inc/link_enc_cfg.h"
 #include "link/link_dp_trace.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index b905c53e738b..69333ac9bab0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -24,7 +24,7 @@
 # PHY, HPD, DDC and etc).
 
 LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o link_dp_trace.o \
-link_hpd.o link_ddc.o link_dpcd.o
+link_hpd.o link_ddc.o link_dpcd.o link_dp_dpia.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/,$(LINK))
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
rename to drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.c
index e1db05966d83..47ad2cae483b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.c
@@ -25,11 +25,12 @@
  */
 
 #include "dc.h"
-#include "dc_link_dpia.h"
 #include "inc/core_status.h"
 #include "dc_link.h"
 #include "dc_link_dp.h"
 #include "dpcd_defs.h"
+
+#include "link_dp_dpia.h"
 #include "link_hwss.h"
 #include "dm_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.h
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
rename to drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.h
index 39c1d1d07357..1e97e4264dde 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.h
@@ -27,11 +27,9 @@
 #ifndef __DC_LINK_DPIA_H__
 #define __DC_LINK_DPIA_H__
 
+#include "link.h"
 /* This module implements functionality for training DPIA links. */
 
-struct dc_link;
-struct dc_link_settings;
-
 /* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
 #define DPIA_CLK_SYNC_DELAY 16000
 
-- 
2.39.0

