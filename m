Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A95EC61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 03:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEA410EBC0;
	Wed, 26 Aug 2026 03:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4BE1Lf7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FC710E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 03:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRQ54bW7I4TsJNWtELvrj7qkJJsIpZrXrdxI1dlSVT0UOeS/ptc+4uz44X9mq2wKhkq/OeY0G6rUfIakdVA5Wdeneit/x35mbZ6mRcjSLDGApFAKbTNCnSiYTJuNKLapu4a/7ZcYUtOin7F5YffsFvPnFEH+VE3Fy+0Gx0aXXoBYPb0BP1BQVtby3pmgp//6mPD56ksYS5j85oBvtL2Azq683YruCbFCb8Wyr3wdMkcVMtrVAXS6o4Hpx/JHD3DXhxHZ6AOQVGTZe9W7/3fjkYBrPtwlMepBsyGLk1Xftt4Xak8GJxiNclsj7Toj7kCn0vmKRSFwVj97BOr6qgQceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPUm0azvDmhZ2JrSDLqb5xGsKn1dtejDNcSgRxDqf+c=;
 b=IgBYW17R1DIxbBxLNR1CSCHOUqEVdporLHk7lERa4ORL4qbAsjbufpoURTz5/tSfiXD2SYei+nocoT/vuH4DZWYypMrfpFQ+QHUh40pZUaux+CehL2CpBV+hThLn5bH6GrVf5hWJ9LN/3MsnV80a6B0fYEsBl+/Ma+7Y7dSGc2D5hCIKmwg/YZeHz2Zjkne1t+GEUt8wn38a7bXA+4WB3hlPf2eX/KxbeWaGXul571OE3DfCn+p+Lo//khs6hJwDGU3f2uw6URYuYmVFTwLQexZExIdMc4K/MLC9gl1OfulAya/TW/nlYOlrhb/v91dQYgip6Y1nwQsf7hEbUzTmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPUm0azvDmhZ2JrSDLqb5xGsKn1dtejDNcSgRxDqf+c=;
 b=t4BE1Lf7FbMXACKl1ARGIWKNwef6HNMOqw4Y82uLL7uEM279JyANrtceU/uTWFu/HiEmBvgyf0E5M14JXyeVvjkudZBP00rH7DZJGAO9xF3ZoDhPSuhAP0q8HbAS5LoGamCF13RDV5Vh+8slAKeeZGVoo+b1GqVdR63aSFxPPs8=
Received: from MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 03:27:26 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::9e) by MN2PR16CA0048.outlook.office365.com
 (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 03:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 03:27:26 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 22:27:14 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: drop the ras_ prefix from the ACA v5 file
 names
Date: Wed, 26 Aug 2026 11:26:05 +0800
Message-ID: <20260826032606.470702-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826032606.470702-1-xiang.liu@amd.com>
References: <20260826032606.470702-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 57672560-fca9-40dd-cc0e-08df0321f38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RyZ4dIIWrI7bVjDsu2NeMRO2y0NjjeewiNI1xy+GtogoDpvx1idAPLLWBaulXsHpyn+UGdDU44PN88WMNj0Yraq4+GZxf7CCP3waNWbjpuTJls+QdfkPOGbyV8bHnAkqHTcU4Er/g8bkoZYuSmrJ32Z6CBhUb9OVSc6N74cZYpAhn7xyoIwsGmc3IY/4406JRZD1g65oJeU1RidRoOCeNbF2Fn9VK3QrTvlW6/4fKNGlZa+Abn0DgOPI1IG4tOMCcilq9EOt8rFVp6QWkREkwJ56UNgG6gRBPcbKh4Olok2ST6i6DlBio43dXmXNKBvQqE4YrcAOS3pIs8ckujXyfw6p15gKcGqaJS7vJI/T6aqAHTf+AXOT+q9hJlKPSnf0u+uHOtdCEQPVudz5Q6x/o6KUqEdorFq4bizV8XMq3Vc31wnViArI9woGHeV24lcEmq6N/3i1zCzf6nfWM14f9nfUaKgZ2BgdIwkaBoSnnLwY62LufeC2V7cnTEO+bwX635teFqzWLneAbzOyslGlh+0pdj3By4nlVhLPv7aylKM2inpbCSvAyCEEGPjjsEVhMl5viJnVPMzHUHLQlnK+V+AtXcraLpHb2xAHpVXE5GLgCkrqdb7CoC8ZW4GMC5fh3QLVy8OSQdQr2ULmhvSxbgoFM5xqBUXtqMmwwfgRuR3oVU00NmXpcYkEpfo6EuX7d08Rw3M4anHk8lc/T5PWOw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RUdQFxOclxad4OACyTpuovI0hQ7QO6E52PDWGdvpWRbDdlp0ntsH5o4sHHq1aM17SLeL0pQv972F0R6EGh39W8xnm4ghD3FLluIEni/wKA8tDunkTp1dV1c0fTJPv4U6ypFwJS0/VCeEi5Yo4VMQ3z+yJELT6deCCmeFoYZlwwucrbGAw+Mz8eI4Trpb+cOdnf/rcKMHIhqCoDPtRfE/cuhxvqTSf5q1q2joF8Ph+V/2CWQvoD+8dfbh/bsmBG262FQmWwmtsCFVWrOnOZx2Ux8VTAuI3R5EStXFpg+bZW20EK7QmJePLKskvvZzgO2swZjv5AP1AfIInsDGOeAgbl7Jefw6XaUkYTqMO8AO5Gb7wcuwjbb1dDIYOW6ohQRTRtv4RMegZC4TgOC7W68fu+EdMPcDqz3Rjvw7dSSrKUa6c+CNKbvsl7Vad7JAHdeQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 03:27:26.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57672560-fca9-40dd-cc0e-08df0321f38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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

The prefix marks the files that back a hardware IP block. ACA is a bank
format rather than an IP, and the rest of its files are named after it
alone, so the v5 pair is the odd one out.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile                       | 2 +-
 drivers/gpu/drm/amd/ras/core/aca.c                          | 2 +-
 drivers/gpu/drm/amd/ras/core/{ras_aca_v5_0.c => aca_v5_0.c} | 2 +-
 drivers/gpu/drm/amd/ras/core/{ras_aca_v5_0.h => aca_v5_0.h} | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/gpu/drm/amd/ras/core/{ras_aca_v5_0.c => aca_v5_0.c} (99%)
 rename drivers/gpu/drm/amd/ras/core/{ras_aca_v5_0.h => aca_v5_0.h} (98%)

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index b2872affbf71..fb16bacaef2f 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -25,7 +25,7 @@ RAS_CORE_FILES = core.o \
 			ras_mp1_v15_0.o \
 			aca.o  \
 			aca_v1_0.o \
-			ras_aca_v5_0.o \
+			aca_v5_0.o \
 			ras_eeprom_mgr.o \
 			eeprom.o \
 			ras_umc.o \
diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index f316f49c24bd..b40098406174 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -25,7 +25,7 @@
 #include "aca.h"
 #include "ras_mce.h"
 #include "aca_v1_0.h"
-#include "ras_aca_v5_0.h"
+#include "aca_v5_0.h"
 #include "ras_mp1_v13_0.h"
 
 #define ACA_MARK_FATAL_FLAG    0x100
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/aca_v5_0.c
similarity index 99%
rename from drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
rename to drivers/gpu/drm/amd/ras/core/aca_v5_0.c
index 2c8dcc5886f3..30fd1cdef94e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/aca_v5_0.c
@@ -24,7 +24,7 @@
 #include "ras.h"
 #include "aca.h"
 #include "core_status.h"
-#include "ras_aca_v5_0.h"
+#include "aca_v5_0.h"
 
 #define ACA_HWIP_MAP(ip, hwid, acatypes) \
 	{ACA_ECC_HWIP__##ip, hwid, acatypes, ARRAY_SIZE(acatypes)}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h b/drivers/gpu/drm/amd/ras/core/aca_v5_0.h
similarity index 98%
rename from drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h
rename to drivers/gpu/drm/amd/ras/core/aca_v5_0.h
index a3eb6d50cc2f..7f2c296de0b2 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.h
+++ b/drivers/gpu/drm/amd/ras/core/aca_v5_0.h
@@ -22,8 +22,8 @@
  *
  */
 
-#ifndef __RAS_ACA_V5_0_H__
-#define __RAS_ACA_V5_0_H__
+#ifndef __ACA_V5_0_H__
+#define __ACA_V5_0_H__
 #include "ras.h"
 
 #define ACA_V5_REG__FIELD(x, h, l)          (((x) & GENMASK_ULL(h, l)) >> l)
-- 
2.34.1

