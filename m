Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227B8C54FDF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 08:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843FF10EE2B;
	Thu, 30 Jul 2026 08:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xRLUZ3Yb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C395F10EE2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 08:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm0P7cfqcGWN7YPL/VXqQCVmQqK+TOfz5r7FJhMiUnVsx+mryYhzUFaKkKwXvfjw8uQRb4hPAwRPSlz06yZZ1Q0wfK4tY61ZIYt9iNqHjSlTLBqCXGLC/YjZb65hn0iUjjdtyoYCNrExm++ZkyAcVY41B6oiIsU1ECHJyC8hbJlo6V6Hxj6S4GQ25L8rGCNdsoHcLwuiFY7zssnvWVkg5ZhoA7e7hzcbtkJv9JjJ9V5BPV4pdZpWzDtR8gDSMR2q4rz4P0Z4jpXE/Nw2r4kitmUQjQSjEUAN9TzSAwtGPQRVg9qwinBaXL5htgyqqPknAyGbJFiLudP6KM92uTDzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6DiSyPUIDJW6appWC+L19SCZBIYSk7IEr/e1heoHG4=;
 b=uCZIK6li2do+TKasT3SzhhUvRNTMjQhwW0xB7BIh/y3Qt8qFRDyolAGpSFwXEGL1TV4/WUuNvzP7Ibu3UiIgXnwuiuApos+md7GbFC3bDLhNGe9gDJnCVNQf168vfwHv4xP0/u2yvhpr98fSd7aFKb8aAbXTGrwoD0zCV3pKRpt/RUeEm1oyEDPURzJjK8UOt2MKiGkIJNim1Rr0uTRa+GE0HCGzllJR8SOi/chyLlXrXpJFB2VcFtB8v4awYiRT+M2GLfTmUAGPr4kYir9hVDAdxUjSyWJFe4D40GZACJyuBEvOYsouVkXJREb+EzOn4QNbKycsk3ZS33u1CcRVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6DiSyPUIDJW6appWC+L19SCZBIYSk7IEr/e1heoHG4=;
 b=xRLUZ3Ybt5W9kkoaNKr5LGzTVcRoYAj4d+I3txT2NHEM2+UGWe8rwxtWdxXki8bp4uMPy9H8k5wUob2rimLJs1A8R3jrryAGTNSwBmjWx46zsAEYH40m1LXNtXWgxmZ878veSU5fl2LkT3hNb++CThw9jS7YMveYIIMbH6Hzk60=
Received: from PH8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:2cd::9)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::615) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 08:35:29 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::26) by PH8PR07CA0002.outlook.office365.com
 (2603:10b6:510:2cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 08:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Thu, 30 Jul 2026 08:35:26 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 03:35:24 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: rename rascore directory to core
Date: Thu, 30 Jul 2026 16:34:34 +0800
Message-ID: <20260730083435.540592-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: d798e4aa-3c47-47ce-5c44-08deee158177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: uSrG3Bx6p+TxyTU7oIjQUfe2ulYan9mW9JJs2/rxT9+89FFnhuqekJyTu93wvhzFDTe65OgFVrKAVVu1NxB1+ZpnLqUuQBAwGVuoOMjXd6uon3RxrvloSv87kpQ51+QyxhZCjGWbqkQuoyVZgaWYehW8kjkTyPla7Z2SUNIkxhCxkGj/xfumDcbrlH7QuY9H4JUe96HWLAMG6ZicsZFDQz1uF4gxIelok9phQEfn+uU6k7trkMg2/ztQ5H4+D+8Gvk1EQHOPu3lIy6nxud/ux/fIjXucT1gTb1K623gg4QrhYT1Tdx2WtINlHcSY3hyVahn6TqxBOj0anzKOfO9mxDBm89jva+/EjScPKwgRaMCzRGSCW2FqVKu5MHLrPfQRMwu/MEsR2oSbykA0tlVRYQjEJIOsmwxD3vrFCfmtyMTbhq12uSApbCjuuERTCOpCgzehwwc+uhYexkfLqv0zFDzzqW8qYCWzUJdttJMc1YqQiAxFC1yN5lwBWr9ILYXxyCZc8kgx4YQNPv+Nq6jvFwNfVwWaceBPRArEMbFIfvQ8Rk8rXppmxbcIG1txLLhIHuKH3muLQvkzCxKQLKyVbkSaVOtuPhoqBgI3SoCPMU72uWKjkkkP4FUG0YZTU5asI5KrPoOV77hLCrPYA92aRPvyYwOrOamqXauDFp3wgOa8Yi/kVNH699znzXQ2TKGZY+vRnWQNzxItGUHeBaFaQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Syykr1Aclx4Zimrpfp9TSnO8Dl0MMB99c6MBU16zDTh6Q9qECwVzM4elTYuBcpncvVuL6xTVmfj3Wk48ZbaYQOzeujAS/p0aCO95i/ZbR96t3YXStPHD0OFn7ENetN3XhArcqaoG6HW5L7f9W+EYDfXl+cwn8FuOoyyOy65uNO26SIIEpJNZMCdxNP2OLu70pAY5PBSHfJEf9yflefKeTMEsSttGGwcHOXSB3Is/rlkxc5doVmNyoqcXJRWL2I8TodazSlUYQApdC9OX/rXVa7p6nWmeoP8NxhuGDzoYWYHVr5JTg7mHsmA+nqNzAz57xep3q8fsy4WZzrqc/76VBQEyJO+yZBnt3xMYHbDtKvgfZ8UH7cpTRnUZQh+gLXz+cXHUwUkuE+p+BMZ6pmcCIdwItKAuBM0g38yhqesR3sZXkKepnyiaAkoVWx7vJfFH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 08:35:26.5907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d798e4aa-3c47-47ce-5c44-08deee158177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12
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

Rename the RAS core directory from rascore to core and update
build-path references accordingly.

The change is mechanical and done with git rename semantics so
history tracking is preserved.

No functional change intended.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/Makefile                            | 4 ++--
 drivers/gpu/drm/amd/ras/{rascore => core}/Makefile          | 2 +-
 drivers/gpu/drm/amd/ras/{rascore => core}/ras.h             | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca.c         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca.h         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca_v1_0.c    | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca_v1_0.h    | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_cmd.c         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_cmd.h         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_core.c        | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_core_status.h | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_cper.c        | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_cper.h        | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom.c      | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom.h      | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom_fw.c   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom_fw.h   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx.c         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx.h         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx_v9_0.c    | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx_v9_0.h    | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_log_ring.c    | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_log_ring.h    | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1.c         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1.h         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1_v13_0.c   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1_v13_0.h   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio.c        | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio.h        | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio_v7_9.c   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio_v7_9.h   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_process.c     | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_process.h     | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp.c         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp.h         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp_v13_0.c   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp_v13_0.h   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_ta_if.h       | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc.c         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc.h         | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc_v12_0.c   | 0
 drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc_v12_0.h   | 0
 42 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/Makefile (95%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca_v1_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_aca_v1_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_cmd.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_cmd.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_core.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_core_status.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_cper.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_cper.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom_fw.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_eeprom_fw.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx_v9_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_gfx_v9_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_log_ring.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_log_ring.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1_v13_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_mp1_v13_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio_v7_9.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_nbio_v7_9.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_process.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_process.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp_v13_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_psp_v13_0.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_ta_if.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc.h (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc_v12_0.c (100%)
 rename drivers/gpu/drm/amd/ras/{rascore => core}/ras_umc_v12_0.h (100%)

diff --git a/drivers/gpu/drm/amd/ras/Makefile b/drivers/gpu/drm/amd/ras/Makefile
index bbdaba811d34..803e250d1666 100644
--- a/drivers/gpu/drm/amd/ras/Makefile
+++ b/drivers/gpu/drm/amd/ras/Makefile
@@ -23,10 +23,10 @@ ifeq ($(AMD_GPU_RAS_MGR),)
 	AMD_GPU_RAS_MGR := ras_mgr
 endif
 
-subdir-ccflags-y += -I$(AMD_GPU_RAS_FULL_PATH)/rascore
+subdir-ccflags-y += -I$(AMD_GPU_RAS_FULL_PATH)/core
 subdir-ccflags-y += -I$(AMD_GPU_RAS_FULL_PATH)/$(AMD_GPU_RAS_MGR)
 
-RAS_LIBS = $(AMD_GPU_RAS_MGR) rascore
+RAS_LIBS = $(AMD_GPU_RAS_MGR) core
 
 AMD_RAS = $(addsuffix /Makefile, $(addprefix $(AMD_GPU_RAS_FULL_PATH)/,$(RAS_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
similarity index 95%
rename from drivers/gpu/drm/amd/ras/rascore/Makefile
rename to drivers/gpu/drm/amd/ras/core/Makefile
index 06b265ec1cde..454f83f62930 100644
--- a/drivers/gpu/drm/amd/ras/rascore/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -40,6 +40,6 @@ RAS_CORE_FILES = ras_core.o \
 			ras_eeprom_fw.o
 
 
-RAS_CORE = $(addprefix $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
+RAS_CORE = $(addprefix $(AMD_GPU_RAS_PATH)/core/,$(RAS_CORE_FILES))
 
 AMD_GPU_RAS_FILES += $(RAS_CORE)
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras.h
rename to drivers/gpu/drm/amd/ras/core/ras.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/core/ras_aca.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca.c
rename to drivers/gpu/drm/amd/ras/core/ras_aca.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h b/drivers/gpu/drm/amd/ras/core/ras_aca.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca.h
rename to drivers/gpu/drm/amd/ras/core/ras_aca.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v1_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_aca_v1_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h b/drivers/gpu/drm/amd/ras/core/ras_aca_v1_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_aca_v1_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/core/ras_cmd.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
rename to drivers/gpu/drm/amd/ras/core/ras_cmd.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/core/ras_cmd.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
rename to drivers/gpu/drm/amd/ras/core/ras_cmd.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/core/ras_core.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_core.c
rename to drivers/gpu/drm/amd/ras/core/ras_core.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core_status.h b/drivers/gpu/drm/amd/ras/core/ras_core_status.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_core_status.h
rename to drivers/gpu/drm/amd/ras/core/ras_core_status.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cper.c
rename to drivers/gpu/drm/amd/ras/core/ras_cper.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h b/drivers/gpu/drm/amd/ras/core/ras_cper.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_cper.h
rename to drivers/gpu/drm/amd/ras/core/ras_cper.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h b/drivers/gpu/drm/amd/ras/core/ras_eeprom.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_fw.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom_fw.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/core/ras_eeprom_fw.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
rename to drivers/gpu/drm/amd/ras/core/ras_eeprom_fw.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx.c b/drivers/gpu/drm/amd/ras/core/ras_gfx.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx.c
rename to drivers/gpu/drm/amd/ras/core/ras_gfx.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx.h b/drivers/gpu/drm/amd/ras/core/ras_gfx.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx.h
rename to drivers/gpu/drm/amd/ras/core/ras_gfx.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c b/drivers/gpu/drm/amd/ras/core/ras_gfx_v9_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_gfx_v9_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h b/drivers/gpu/drm/amd/ras/core/ras_gfx_v9_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_gfx_v9_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_gfx_v9_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c b/drivers/gpu/drm/amd/ras/core/ras_log_ring.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
rename to drivers/gpu/drm/amd/ras/core/ras_log_ring.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h b/drivers/gpu/drm/amd/ras/core/ras_log_ring.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
rename to drivers/gpu/drm/amd/ras/core/ras_log_ring.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
rename to drivers/gpu/drm/amd/ras/core/ras_mp1.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
rename to drivers/gpu/drm/amd/ras/core/ras_mp1.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c b/drivers/gpu/drm/amd/ras/core/ras_nbio.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
rename to drivers/gpu/drm/amd/ras/core/ras_nbio.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h b/drivers/gpu/drm/amd/ras/core/ras_nbio.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio.h
rename to drivers/gpu/drm/amd/ras/core/ras_nbio.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c b/drivers/gpu/drm/amd/ras/core/ras_nbio_v7_9.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c
rename to drivers/gpu/drm/amd/ras/core/ras_nbio_v7_9.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h b/drivers/gpu/drm/amd/ras/core/ras_nbio_v7_9.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h
rename to drivers/gpu/drm/amd/ras/core/ras_nbio_v7_9.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/core/ras_process.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_process.c
rename to drivers/gpu/drm/amd/ras/core/ras_process.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.h b/drivers/gpu/drm/amd/ras/core/ras_process.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_process.h
rename to drivers/gpu/drm/amd/ras/core/ras_process.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp.c
rename to drivers/gpu/drm/amd/ras/core/ras_psp.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp.h
rename to drivers/gpu/drm/amd/ras/core/ras_psp.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h b/drivers/gpu/drm/amd/ras/core/ras_ta_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
rename to drivers/gpu/drm/amd/ras/core/ras_ta_if.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc.c
rename to drivers/gpu/drm/amd/ras/core/ras_umc.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc.h
rename to drivers/gpu/drm/amd/ras/core/ras_umc.h
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
rename to drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
rename to drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
-- 
2.43.0

