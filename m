Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38256FEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AAF10E7A0;
	Wed, 25 Mar 2026 07:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K2tet/HA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A3310E7A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL8cfyusinoFLw4Y7+Qq1fLGHYCWY3abISo3fs/H7oE9EdiYvzKavb6NwbQcMzwGcHu8PY+7Qj7iW1bUVX9NsHSZTJeaUCYqN3UzVOn4VVNlJU+ie9Uhn7+dXfqvI4YQx+YM1Oi0kIBR6GEpfAK62LbYbARh5I/oAxYQAvNI6WOmed95g4o+RA68c6Zs4t8u55yzgeVNyP6ssgt6GF33ybZ7Oj7A2hEnUZEOPB3qcoL3DmOoOjymNqybnZsWMsrjt+QY5xAvhMH5yTiUKNgRxkZS8Z+n7EdctPoKvDyF2YS9ZRI5vjM/c/7xEqZUowd8GwOxJfBsVh27ej7W/PuNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGayQRv9UslUftf2Z8WAtL8osJXvCFWMHu2bninMHtU=;
 b=ugtSa88/0xa5KADV4Qd/Hh6uPArqXbV/RnEjITBvUZthY5ft78yYKE/AmZZ6HcgfcFu+t4rtoG7cpKps/lYO+2jIbSavaOGG19qkpkP5jprgODzKWjUyIu09daVh76VqEO7eXiLTMRDfk6xbK1OzbY68ZaKSj3d3Rzqe5hIcPiWiqJbnja2OJO4FlG45B5H2SQXuCuBhjteQEsC+7FG5qwUTJ9VwqMrEEyM7eqzO7Fba4zuYxv5A1p8UoMOL2c0yNKRL69hQsoPwzfzXegsXZ4S1powx3EeaVjUrUEdti8ohGAuRYnC5Mur0uCaP/GHOYg2tFLGFGfH8Kwc4CndHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGayQRv9UslUftf2Z8WAtL8osJXvCFWMHu2bninMHtU=;
 b=K2tet/HAzkdRYJZxK2zmQkjGkCRBkGMMUs0aJOHgn0XIEEe4mrc/tCKlXQDrZUVALYBZBg6CFUrDhXarFvXxGEausCz6l46biJMyFiVeMoZaVQJEetIRYSwtMeWt/ulME7mExgHcmU1NH/OmmeonL0NPjeiKwrX9P8a1eqfOkso=
Received: from BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:06 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::56) by BL0PR05CA0018.outlook.office365.com
 (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 07:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:09:05 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:01 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 08/29] drm/amd/display: Fix Silence Conversion Warnings in Dmub
Date: Wed, 25 Mar 2026 15:06:14 +0800
Message-ID: <20260325071003.4022594-9-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdd1b4e-6fee-4ccb-df07-08de8a3d66ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LFl5TlXGbOrNY9ANXZXs+MGRraCiheG8P/mo4KDpKtGMku0N6uxf1ZWYYF+8FVXdljp/MP4Ird8Wiv6fOerUx9jTUFXIoOYAzBmW0BH42jfkEBQnhFKkUtBlJhoYFZ+af5rIewvtDTuJFB4+GlKEZpMwayf14slX2P6oG4uWmdyw4JrhSEVp/J4wqYoNBvRduXixqJHBuZlfewPOV1NPzzxXwYm2xpH66lcVfwrzEzy8ev8WFX/DgEmbQZ362dt/Hc3n/2XKCHBu63Fn5zfT+508OVl78ZzIzeCjh8jPMUnmGqW3fVab+8ZUvAqLr2iCgGCQ042w+/Jme4/cRzbbs8X43BQt0mJYoSw27IBMAJnXRMSonTayM2nkNRBizpCIko5FFpCBFdh+7K4TVMy2u6k0unlNrGddBtW7EfM2A6gPSIBU+KPN21pBGJTKzS1Uhh5VW4CqqSYmNGPxUOfCInaQIp4OOX9996uYu1z94LfkaAliLzXKB+mHEVGKsoCYd1A1XbOAk21/9DH9klLkZY5U2WCpvgKcOIkSJbcH0w8D09bBc/mZTA6DPu/MxXRskwPJh3yOInDi2wkwFKT5SbZxcECWkPwE/H0qdF6nSRsi81NVn0C0n2RkHX8h9i0cd14ZY8QQBcjmfttXwIpT5VJ74vmGt+K4Xq7RcSKWUgdtBtlYcmgg9DGJfBBvanDUgpCMRWYAQfhc66YgNRKDMYfvLnOG2IIa73mk44bg5eUEdMygOPcOHBoLpJcGDtqF535sp9QsuouD6q0G3KsvHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DWpgaKuhdpvrOeZPB2XTkL04B2S8HBxJfok0grdYMkFxKx+3N8Pq1thp+Ay/fMmYPBIxoqoDDUBV+tXSGh9vqfe+dkBVrQkE4zwrvu+Ro1STAgcAfsXGeZnoOnQ9m95OVhK+nYqHWMQDPiUsTD7gOH7Nlilu+6E1C3vXTZyZvMUHTSx9VFSBQqg61qc13IC4qVNtZl3jn7ED9O1ww1bK28bG47K12JVv4d2Qf7crqVFWRpUhg1qI6+/c3vabdCfTMhGWsLxAomSw3+Lk/HqKE9stKsnmSYfdMJl2Gb1krnDYt71DrC9tpc9LRUYPY1iwsjzRednDNK7rHZ4KV11wPrJv9j8SyrjPvoVsAFfehFngUNJsQjPcxLK1meh4sbIfICAcOD0uzdpLUfZeHsRRgpc0rBvVtJFAzbaYt58AbNxIRyn/KKglQ5HqC6M3tgLB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:05.8440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdd1b4e-6fee-4ccb-df07-08de8a3d66ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Fix Conversion that might result in a loss of data  warnings in dmub/src/:

- dmub_dcn20/31/32/35/42/60/401.c: Add ASSERT(value <= 0xFF) and
  explicit (uint8_t) cast when storing REG_GET results into uint8_t
  debug struct fields. Add != 0 for bool assignments from uint32_t
  bitfield reads.
- dmub_reg.c: Cast va_arg shift value to uint8_t with ASSERT guard
  before passing to set_reg_field_value_masks().
- dmub_srv.c: Widen num_pending to uint64_t to match uint64_t
  arithmetic; use != 0 for bool assignments from unsigned expressions.

No functional change intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 18 ++++++++++-----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 21 +++++++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 15 ++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 17 +++++++++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 21 +++++++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c | 23 ++++++++++++-------
 .../gpu/drm/amd/display/dmub/src/dmub_reg.c   |  3 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  8 +++----
 8 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 54df2147e4dc..73221ca53b7d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -460,20 +460,26 @@ void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index a0cefc03b21d..244244f3df80 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -466,25 +466,32 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 }
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 2f99a2772599..5d86f649db4b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -486,19 +486,24 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 639f9835e5e9..f9b16eb8ef8e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -402,7 +402,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	union dmub_fw_boot_options boot_options = {0};
 
 	if (!dmub->dpia_supported) {
-		dmub->dpia_supported = dmub_dcn35_get_fw_boot_option(dmub).bits.enable_dpia;
+		dmub->dpia_supported = dmub_dcn35_get_fw_boot_option(dmub).bits.enable_dpia != 0;
 	}
 
 	boot_options.bits.z10_disable = params->disable_z10;
@@ -508,19 +508,24 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 16ed07f0e96d..3d2307d0ce49 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -473,25 +473,32 @@ void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index f687359b7d83..7b870b831199 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -41,7 +41,7 @@ void dmub_dcn42_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	union dmub_fw_boot_options boot_options = {0};
 
 	if (!dmub->dpia_supported) {
-		dmub->dpia_supported = dmub_dcn42_get_fw_boot_option(dmub).bits.enable_dpia;
+		dmub->dpia_supported = dmub_dcn42_get_fw_boot_option(dmub).bits.enable_dpia != 0;
 	}
 
 	boot_options.bits.z10_disable = params->disable_z10;
@@ -676,25 +676,32 @@ void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub)
 	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
+	ASSERT(is_dmub_enabled <= 0xFF);
+	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
-	dmub->debug.is_pwait = is_pwait;
+	ASSERT(is_pwait <= 0xFF);
+	dmub->debug.is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
+	ASSERT(is_soft_reset <= 0xFF);
+	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
+	ASSERT(is_sec_reset <= 0xFF);
+	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	dmub->debug.is_traceport_en  = is_traceport_enabled;
+	ASSERT(is_traceport_enabled <= 0xFF);
+	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
+	ASSERT(is_cw0_enabled <= 0xFF);
+	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	dmub->debug.is_cw6_enabled = is_cw6_enabled;
+	ASSERT(is_cw6_enabled <= 0xFF);
+	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
index ca0c8a54b635..94f4931d3d44 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
@@ -57,8 +57,9 @@ static void set_reg_field_values(struct dmub_reg_value_masks *field_value_mask,
 		mask = va_arg(ap, uint32_t);
 		field_value = va_arg(ap, uint32_t);
 
+		ASSERT(shift <= 0xFF);
 		set_reg_field_value_masks(field_value_mask, field_value, mask,
-					  shift);
+					  (uint8_t)shift);
 		i++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 3bba256a288d..10d23f5f5d94 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1034,8 +1034,8 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 static void dmub_srv_update_reg_inbox0_status(struct dmub_srv *dmub)
 {
 	if (dmub->reg_inbox0.is_pending) {
-		dmub->reg_inbox0.is_pending = dmub->hw_funcs.read_reg_inbox0_rsp_int_status &&
-				!dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub);
+		dmub->reg_inbox0.is_pending = (dmub->hw_funcs.read_reg_inbox0_rsp_int_status &&
+				!dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub)) != 0;
 
 		if (!dmub->reg_inbox0.is_pending) {
 			/* ack the rsp interrupt */
@@ -1320,7 +1320,7 @@ void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_t
 
 enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_cmd *cmd)
 {
-	uint32_t num_pending = 0;
+	uint64_t num_pending = 0;
 
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
@@ -1348,7 +1348,7 @@ enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_c
 
 	dmub->reg_inbox0.num_submitted++;
 	dmub->reg_inbox0.is_pending = true;
-	dmub->reg_inbox0.is_multi_pending = cmd->cmd_common.header.multi_cmd_pending;
+	dmub->reg_inbox0.is_multi_pending = cmd->cmd_common.header.multi_cmd_pending != 0;
 
 	return DMUB_STATUS_OK;
 }
-- 
2.43.0

