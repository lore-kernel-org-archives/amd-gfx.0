Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CADC3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DDD2072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DDP62stv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DDD2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BA66E1B1;
	Sat,  2 May 2020 21:35:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C656E1B1
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL+jMelsX4Cka3Lx1QvUpCYnsdBC1YXXwZMVWuzgSJV8WwSVoPPnF5MQEtzy113e67fsn6w5HiVUFS9/uul4HtTUSmeu64V1pJwXwA5gFkyp61KWLGGDOCpycXpCDS4LoNuCxrhVPvCf4h+8WFbfKJmZpzMfCPhu8mrB7iXAmJSZAyLKKVLFaHaFqxahNzP85/zX4FSSSRJdnmbtXHHSgIhAS+hi4SxAwq3bQHqZqKW7cC/lK35kFw2YUT89aO8/ZUQOTJD6yKAwDKQhiDkXeCcJRmRnWnAxkxRPFT+tS8JzI0jgkz+doGwmkZRhbuO2cjHhqRDjQq+++XZBr3PotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1TO2o6J20DCupDpe+otPFVV9tvxoLa6HVwHm/lMZ2k=;
 b=gSr3YXrlm6h+M/ous+kiLZ4uj7N6yWQhgLt26bNAoh/nCmCzmpX3P7GNsAAbAeruWar4M3Y8Il+W6VaZYnjmIJZqK/pBVOJ8bV5kYeQCv8Ry7gWGmBNQC1A8JHiyfFTd7Wp0fjOchNOGW82GBuXCyqgsKRQyde1rSpsWfa9aP9I8gZ7dQKLUApoMp2TkwmFYEr0SetkmjC7bZq4IGMdKoBcbxP0bpQRUfwUllf+a7opBp9KgrobaHwoqTyx03L0Awoq1qb4RvwyoaWqHKaNIR4KQhhpmpoVdyhdmgoE6GMiY4wJNwwXtHkxqe+JdWb5bUcpTcGLL1/F82PkBfXrFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1TO2o6J20DCupDpe+otPFVV9tvxoLa6HVwHm/lMZ2k=;
 b=DDP62stvsRvnSdJPLEadvNFwvQp0FafRSFRluPCnPdU/m5ZVUOjI3gIG8y7Cdg8iftXIvJLvW6zCrxHnh/xAyi4Wqm7qIAJODBx/utcaL3sLfOXsVZYmEPkXovHlENk5B6Ja99WCvsqXbkqqpi+NEd1oxNxnNepPm08arfyyLAM=
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by MN2PR12MB3711.namprd12.prod.outlook.com (2603:10b6:208:161::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 2 May
 2020 21:35:11 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::be) by BN6PR19CA0053.outlook.office365.com
 (2603:10b6:404:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27 via Frontend
 Transport; Sat, 2 May 2020 21:35:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:35:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:11 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:10 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:35:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: move location of dmub_srv.h file
Date: Sat, 2 May 2020 17:34:42 -0400
Message-ID: <20200502213443.39232-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(82740400003)(426003)(2616005)(1076003)(44832011)(356005)(81166007)(478600001)(6916009)(70206006)(2906002)(70586007)(4326008)(336012)(8676002)(5660300002)(316002)(47076004)(86362001)(36756003)(82310400002)(186003)(8936002)(26005)(54906003)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fdcad20-fb26-4b58-10ef-08d7eee0b17f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3711:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3711775296A518425C51095B8BA80@MN2PR12MB3711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3N+rr4NXGA000CROFjR7V+5gc5ckRHX92Ue3AZdr7ka3RjlMFOuzu0BjIZXA7NB8ZHHDcEktm5nzsaxfItEJBT5IliAukYVOAdaojmyINW2CzB38SXpRNM1Q9O/KQkJTprvLWnp0o18cB2Nd46hGDV26A/FyJ9M8JxMI9yQu7kgOoxDCTihMWCAjJpB7d8+o2BopZZTWRgznnoyaImI2UwLLJ5AkI3fqE9gzxCbeAVZbABWRA8dZ6+9bD/Znq99OjensFeZ/Ejl+va9B0hN/2ohHUr1+UVPw2mcP4331LAobuKk31ZiAE53UChvOLMovgxvwhsxeo9uUOQP6gVHmm1CsSq/fSehCHHf4+kR4oKfd7VFy6ZbEr+2Np7avEqkM/Ier87PHbbsSiI5mOsabqtApuRuwjBB3jrYEH1O3G1thsIFNoNImP+5vfwBAenw/O+yeXWrFRdgiBZ2KzgEQtrpvA84TI5E2JPP5SDw1oMSCC9QDQ+tjrbvBNqYJdwo1iRcBloTZBw2L59kWboUeXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:35:11.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdcad20-fb26-4b58-10ef-08d7eee0b17f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3711
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Make a separation of what belongs in the differen dmub
headers

dmub_srv.h is for exposing dmub srv interface to rest of
driver.

other headers inside dmub/inc exposes cmds and definitions
that are owned by the firmware

[How]
keep firmware owned definitions in dmub/inc

move stuff that is purely driver interface headers to dmub/
since those are interface calls that are defined for rest of
driver to use

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c             |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c        |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c         |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h         |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h             |  1 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c        |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c        |  3 +--
 .../gpu/drm/amd/display/dmub/{inc => }/dmub_srv.h    |  9 +++++----
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c    |  2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c    |  2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c      |  2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c      |  2 +-
 .../amd/display/modules/info_packet/info_packet.c    |  1 -
 drivers/gpu/drm/amd/include/atomfirmware.h           | 12 +++++++-----
 16 files changed, 25 insertions(+), 25 deletions(-)
 rename drivers/gpu/drm/amd/display/dmub/{inc => }/dmub_srv.h (99%)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 065d5d7686e7..0cde4b1e71f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -30,7 +30,7 @@
 #include "dc.h"
 #include "dc/inc/core_types.h"
 #include "dal_asic_id.h"
-#include "dmub/inc/dmub_srv.h"
+#include "dmub/dmub_srv.h"
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 #include "dc/dc_dmub_srv.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b3b7efd973ca..076af267b488 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -32,7 +32,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_debugfs.h"
 #include "dm_helpers.h"
-#include "dmub/inc/dmub_srv.h"
+#include "dmub/dmub_srv.h"
 
 struct dmub_debugfs_trace_header {
 	uint32_t entry_count;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0a12d13349c1..45cfb7c45566 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -66,7 +66,7 @@
 
 #include "dce/dce_i2c.h"
 
-#include "dmub/inc/dmub_cmd_dal.h"
+#include "dmub/dmub_srv.h"
 
 #define CTX \
 	dc->ctx
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6ed67e6e8739..c08de6823db4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 
 #include "dm_services.h"
-#include "atom.h"
+#include "atomfirmware.h"
 #include "dm_helpers.h"
 #include "dc.h"
 #include "grph_object_id.h"
@@ -46,7 +46,7 @@
 #include "dmcu.h"
 #include "hw/clk_mgr.h"
 #include "dce/dmub_psr.h"
-#include "dmub/inc/dmub_cmd_dal.h"
+#include "dmub/dmub_srv.h"
 #include "inc/hw/panel_cntl.h"
 
 #define DC_LOGGER_INIT(logger)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 907e0c5374bb..eea2429ac67d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -25,7 +25,7 @@
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
-#include "../dmub/inc/dmub_srv.h"
+#include "../dmub/dmub_srv.h"
 
 static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 				  struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 6689ae33dee8..a3a09ccb6d26 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -27,7 +27,7 @@
 #define _DMUB_DC_SRV_H_
 
 #include "os_types.h"
-#include "dmub/inc/dmub_cmd.h"
+#include "dmub/dmub_srv.h"
 
 struct dmub_srv;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 859d254c0e3f..f63fc25aa6c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -29,7 +29,6 @@
 #include "dc.h"
 #include "dc_types.h"
 #include "grph_object_defs.h"
-#include "dmub/inc/dmub_cmd_dal.h"
 
 enum dc_link_fec_state {
 	dc_link_fec_not_ready,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index c15a4f5b4c62..da0b29abfbda 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -27,7 +27,7 @@
 #include "dce_abm.h"
 #include "dc.h"
 #include "dc_dmub_srv.h"
-#include "dmub/inc/dmub_srv.h"
+#include "dmub/dmub_srv.h"
 #include "core_types.h"
 #include "dm_services.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3c6606e0532d..044a0133ebb1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -26,8 +26,7 @@
 #include "dmub_psr.h"
 #include "dc.h"
 #include "dc_dmub_srv.h"
-#include "dmub/inc/dmub_srv.h"
-#include "dmub/inc/dmub_gpint_cmd.h"
+#include "dmub/dmub_srv.h"
 #include "core_types.h"
 
 #define MAX_PIPES 6
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
similarity index 99%
rename from drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
rename to drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 9f10bfe3d2df..26d94eb5ab58 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -64,10 +64,11 @@
  * other component within DAL.
  */
 
-#include "dmub_types.h"
-#include "dmub_cmd.h"
-#include "dmub_gpint_cmd.h"
-#include "dmub_rb.h"
+#include "inc/dmub_types.h"
+#include "inc/dmub_cmd.h"
+#include "inc/dmub_gpint_cmd.h"
+#include "inc/dmub_cmd_dal.h"
+#include "inc/dmub_rb.h"
 
 #if defined(__cplusplus)
 extern "C" {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 45638d61b73d..edc73d6d7ba2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "../inc/dmub_srv.h"
+#include "../dmub_srv.h"
 #include "dmub_reg.h"
 #include "dmub_dcn20.h"
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index 5bed9fcd6b5c..e8f488232e34 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "../inc/dmub_srv.h"
+#include "../dmub_srv.h"
 #include "dmub_reg.h"
 #include "dmub_dcn21.h"
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
index 4094eca212f0..ca0c8a54b635 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
@@ -24,7 +24,7 @@
  */
 
 #include "dmub_reg.h"
-#include "../inc/dmub_srv.h"
+#include "../dmub_srv.h"
 
 struct dmub_reg_value_masks {
 	uint32_t value;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 66ba0b2d80d2..0e3751d94cb0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "../inc/dmub_srv.h"
+#include "../dmub_srv.h"
 #include "dmub_dcn20.h"
 #include "dmub_dcn21.h"
 #include "dmub_fw_meta.h"
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 20c30daa374c..7cd8a43d1889 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -29,7 +29,6 @@
 #include "mod_shared.h"
 #include "mod_freesync.h"
 #include "dc.h"
-#include "dmub/inc/dmub_cmd_dal.h"
 
 enum vsc_packet_revision {
 	vsc_packet_undefined = 0,
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index a6f6e6bf5992..b36ea8340afa 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -972,11 +972,13 @@ struct atom_ext_display_path
 };
 
 //usCaps
-enum ext_display_path_cap_def
-{
-  EXT_DISPLAY_PATH_CAPS__HBR2_DISABLE               =0x0001,
-  EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN             =0x0002,
-  EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK              =0x007C,           
+enum ext_display_path_cap_def {
+	EXT_DISPLAY_PATH_CAPS__HBR2_DISABLE =           0x0001,
+	EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN =         0x0002,
+	EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK =          0x007C,
+	EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204 =      (0x01 << 2), //PI redriver chip
+	EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT = (0x02 << 2), //TI retimer chip
+	EXT_DISPLAY_PATH_CAPS__HDMI20_PARADE_PS175 =    (0x03 << 2)  //Parade DP->HDMI recoverter chip
 };
 
 struct atom_external_display_connection_info
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
