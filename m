Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72E2E69E95
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718E410E873;
	Mon,  2 Dec 2024 21:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b9C2cYTX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999AC10E86F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNdxZQs6TKnOh+HnPiWy333ixubxfJ1/46hpD6crzHxKHi3j56jNg98y4j6RzJbyuPkB4OBIfeH255pyxdjq3g7p3ELws3jbM12gttklX8CBKCCo11+kJ9ncpckHI28TuorCqBr7uMLFaeQhtBuglAnvkEMYu+WF1DYV3MJrxgV9CqhBTd+n9+RbMmw6ayz1COsNAbpBxJs91Xmt3JDY9+TkGWM3E5TfmQbG5uC+/9oh8BWm9zDts8slH+vVYHj/N6jhajgnB69KxpKnX2pr0qtW5t5aAm0WPNZdjDi1m8Ki86nA/bWM9bfKi97M6d3qKOfS7DGEE2CQLUHTodG03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osx6buC092mcVK8xtH/jG09maUOQ5ZuIYSoKCL1dv3g=;
 b=Goeweb7diQDceYDTltn8nCIbxpvvkDSRXrgimqLyyUwi6UhW/zRjszZZ49a8NX1p9S4LSYBO1+pW/B7Y4zhbUn2F0ujHWr++MZBdIt4xIbqg7R+Fck0lvEtiaC11OBG7YAFf2Q/sIMd9CZdDwRlCYTpkFL+cSQZR7RxSr5ljaL+fp160XX/1qVG7A2jciZt1JjLE/wbcZeibQZFdq4CpMI2YMGI1YlcDQ70vKPkGOdL11AA4lcyept2O9mH14M2A2W6CLi+TUUgQh9Dp4/p2kfMf3Xm1eu26NRJD9jmSjR3LEWVgAVNdq9YGr4Rsgqen6z/DvPnesRlCfUFiitJuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osx6buC092mcVK8xtH/jG09maUOQ5ZuIYSoKCL1dv3g=;
 b=b9C2cYTXJ5b4QQT3TSK+ABySRY9eEU2AeibDWgn9mA8eIMcBZgsMEtUpzFwaybVaUbvZSQmV8MC2fkS6ePPNOH4479Aq3fCeGhUKb2iF+K99lcvwgB4vSqD+MJfUZlCJNqDyE+G0GDFs6fwxQ2Smo24uGFxF3X0XTsxQ9ja9bx4=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 21:50:21 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::80) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Jay Cornwall <jay.cornwall@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/11] drm/amdkfd: Handle save/restore of lds allocated in
 1280B blocks
Date: Mon, 2 Dec 2024 16:49:51 -0500
Message-ID: <20241202214952.1125211-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0ac68c-fdbd-4967-9930-08dd131b520a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TG+PZyfsuISkGtckAtNPExnTlZE5aEzC3Zj4WH50WZLiXqw3aepnNMZwARRF?=
 =?us-ascii?Q?N8kYaIVbrFFZpeRphfqWhhTgTzCexn1LqcmqAfBQHnF5FipoKkFtRaIoy106?=
 =?us-ascii?Q?xfM/2K7uDBmSYGoowe39RvafM4PJPnteLC2ge4CuxiYYjS0ZCqnY6KS7uD16?=
 =?us-ascii?Q?5o7MiCLl64QH/30UbAWVYKdFwh0nVSgnPyrrx3i0et2Sc7Cy26L9Zovj2ugv?=
 =?us-ascii?Q?etbgLLVy8h07oxigsXVl+tvOanf8lGsdIGNW+EDGb+KbEnuFocBBcmKL9T/3?=
 =?us-ascii?Q?qHgZurTi/nIZN2VX/B/3CsbkXaH7JrTf/nwWS7EWhI5EwTZi1/8McTiu6E8x?=
 =?us-ascii?Q?7/BEYZq3jFv7ucM5gttvAKhuaCXDlpidEIGadxL+P6kpPzNTKV35MLqKzHcx?=
 =?us-ascii?Q?e30h/9YAz/IKeNstyNvzsPlkGMoyTkqNYeYUOTq58ZD7oNWoFj7RUT7s4uQ/?=
 =?us-ascii?Q?V2LctW59SJ3g79Zygr+9mBw6A/AcY5HkthXVrHM6YRX9WWlkO4MwOxRGd2jv?=
 =?us-ascii?Q?cvn8tGg+7d8exX36NP4M7jwj+PgfSTqrzSp4Mdp843CC4ZSI7EHTcIfsE7+/?=
 =?us-ascii?Q?Ia0TsMEAb4TAYtmlZgamR/f3nUVS9RdFhpaeuiUyruFvyAW+/s4ZWB7XQyFf?=
 =?us-ascii?Q?DSQXlLQ5jBBVQGPO46c8gx3PBpoz2HDWXZUa0dSEixUQ9vqV4YtT/QF/PqPs?=
 =?us-ascii?Q?z0TXa/ebpoJMjv/dUjadb4jKyj/9Yp1hcJJqFKwCGtqADC20y/OrpRfdu6K7?=
 =?us-ascii?Q?8O3bRAowMehXzQEb10bzwc0Lh1lIpd4nDemRyAf4K6FfO6KM9V0EPEb9NFUy?=
 =?us-ascii?Q?yMTTc0QxcHosrxdJHRqFtBokVILWPKLfzRy4lN7xcsLgXVOFWt/MCDHsl6Jj?=
 =?us-ascii?Q?jmFa3vtLGeC/53rfqoVNHAJny9lyRqzC8BIa2xogGG0LloXWreLBelXK5TYq?=
 =?us-ascii?Q?EtiS7OdvQbbqsKfdoKhg8bo1asL10wj70urrbJYKmDhHxwx8ziphU+VTZwVs?=
 =?us-ascii?Q?4SF5FcsxBudoS8ZjOhYsQZGiOlGjbpRGNuLHMCooF8+rbw/0phq75ARpAdFe?=
 =?us-ascii?Q?SGPjoitvwVP7ZVebiruhzi6rTV6hH9+Yo+dSKm32SIGVtWZeXTsB5VPmSAs/?=
 =?us-ascii?Q?L8x74rlWMVtHyad7wMmz4KlkAhAtSgoAi4guXjA9Z5vsZhpWrEaNj5QU2g/S?=
 =?us-ascii?Q?uF63U4N/8GnXHYkkJ3lS6RUg8oRD5rFClRhEh5kIyj4d5G14/0QoD5MmsAT5?=
 =?us-ascii?Q?9a867bqNl4wv6sNaKuwcF14s4VIJMIzsaBoy+4SfvAQSyzKR0J5cm2l3SamN?=
 =?us-ascii?Q?dUHChWz4pETBpX2+nhr5AFuWMXLYsf7cOjnFfny0/NWFSiRF6wizZv1qfuOS?=
 =?us-ascii?Q?YU/pLEZ03Pw2MKxhX8guqYHzLqBZlsQMx4ZvvGOO3RWbuKuJhyLRS6OMvsXB?=
 =?us-ascii?Q?1aHspb3zRxJzV4a8FvidIwd5AQzu+joU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:21.7168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0ac68c-fdbd-4967-9930-08dd131b520a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
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

From: Lancelot SIX <lancelot.six@amd.com>

The gfx-9 trap handler is reading LDS allocation size in 256 bytes
granularity (from SQ_WAVE_LDS_ALLOC), but it using the assumption that
this value is always even (i.e. the LDS allocation is really done in
multiple of 512 bytes).  This was true so far, but gfx-950 allocates LDS
in chunks of 1280 bytes, making this assumption invalid.  This can cause
the trap handler to try to save / restore past the end of LDS, and past
the LDS allocated slot in the save are, overriding data from the
following wave.

This patch updates the trap handler to support LDS allocated in 1280
bytes blocks:
- During restore, copy from main memory directly to LDS in batch of 1280
  bytes.
- During save, continue to use 512 bytes blocks (we only have 2 VGPRs we
  can use to hold data), making sure to mask the upper half of the wave
  when handling when the LDS size is not a multiple of 512 bytes.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Co-authored-By: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 60 +++++++++----------
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 25 +++++++-
 2 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 5931a17b4da3e..388b44ed5928c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4124,7 +4124,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
-	0xbf820001, 0xbf8202ea,
+	0xbf820001, 0xbf8202d8,
 	0xb8f8f802, 0x8978ff78,
 	0x00020006, 0xb8fbf803,
 	0x866eff78, 0x00002000,
@@ -4321,9 +4321,9 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0xe0724300, 0x701d0300,
 	0xbefe00c1, 0xbeff00c1,
 	0xb8fb5306, 0x867bc17b,
-	0xbf840064, 0xbf8a0000,
+	0xbf840052, 0xbf8a0000,
 	0x867aff6f, 0x04000000,
-	0xbf840060, 0x8e7b867b,
+	0xbf84004e, 0x8e7b867b,
 	0x8e7b827b, 0xbef6007b,
 	0xb8f02985, 0x80708170,
 	0x8e708a70, 0x8e708170,
@@ -4336,8 +4336,8 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0x000204c1, 0x867aff78,
 	0x00400000, 0xbf850003,
 	0xb8faf803, 0x897a7aff,
-	0x10000000, 0xbf850030,
-	0x24040682, 0xd86e4000,
+	0x10000000, 0xbf85001d,
+	0x24040682, 0xd86c0000,
 	0x00000002, 0xbf8cc07f,
 	0xbe840080, 0xd2890000,
 	0x00000900, 0x80048104,
@@ -4348,29 +4348,20 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0x80048104, 0xc069003a,
 	0x00000070, 0xbf8cc07f,
 	0x80709070, 0xbf06c004,
-	0xbf84ffee, 0xbe840080,
-	0xd2890000, 0x00000901,
-	0x80048104, 0xd2890001,
-	0x00000901, 0x80048104,
-	0xd2890002, 0x00000901,
-	0x80048104, 0xd2890003,
-	0x00000901, 0x80048104,
-	0xc069003a, 0x00000070,
-	0xbf8cc07f, 0x80709070,
-	0xbf06c004, 0xbf84ffee,
-	0x680404ff, 0x00000200,
+	0xbf84ffee, 0x680404ff,
+	0x00000100, 0xd0c9006a,
+	0x0000f702, 0xbf87ffe5,
+	0xbf820016, 0xd1060002,
+	0x00011103, 0x7e0602ff,
+	0x00000200, 0xbefc00ff,
+	0x00010000, 0xbe800077,
+	0x8677ff77, 0xff7fffff,
+	0x8777ff77, 0x00058000,
+	0xd8ec0000, 0x00000002,
+	0xbf8cc07f, 0xe0765000,
+	0x701d0002, 0x68040702,
 	0xd0c9006a, 0x0000f702,
-	0xbf87ffd2, 0xbf820015,
-	0xd1060002, 0x00011103,
-	0x7e0602ff, 0x00000200,
-	0xbefc00ff, 0x00010000,
-	0xbe800077, 0x8677ff77,
-	0xff7fffff, 0x8777ff77,
-	0x00058000, 0xd8ec0000,
-	0x00000002, 0xbf8cc07f,
-	0xe0765000, 0x701d0002,
-	0x68040702, 0xd0c9006a,
-	0x0000f702, 0xbf87fff7,
+	0xbefe016a, 0xbf87fff6,
 	0xbef70000, 0xbef000ff,
 	0x00000400, 0xbefe00c1,
 	0xbeff00c1, 0xb8fb2b05,
@@ -4497,15 +4488,15 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0x701d0300, 0x807c847c,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7c, 0xbf85ffeb,
-	0xbf9c0000, 0xbf8200ee,
+	0xbf9c0000, 0xbf8200f4,
 	0xbef4007e, 0x8675ff7f,
 	0x0000ffff, 0x8775ff75,
 	0x00040000, 0xbef60080,
 	0xbef700ff, 0x00807fac,
 	0x866eff7f, 0x04000000,
-	0xbf84001f, 0xbefe00c1,
+	0xbf840025, 0xbefe00c1,
 	0xbeff00c1, 0xb8ef5306,
-	0x866fc16f, 0xbf84001a,
+	0x866fc16f, 0xbf840020,
 	0x8e6f866f, 0x8e6f826f,
 	0xbef6006f, 0xb8f82985,
 	0x80788178, 0x8e788a78,
@@ -4516,9 +4507,12 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0x01000000, 0xbefc0080,
 	0xe0510000, 0x781d0000,
 	0xe0510100, 0x781d0000,
-	0x807cff7c, 0x00000200,
-	0x8078ff78, 0x00000200,
-	0xbf0a6f7c, 0xbf85fff6,
+	0xe0510200, 0x781d0000,
+	0xe0510300, 0x781d0000,
+	0xe0510400, 0x781d0000,
+	0x807cff7c, 0x00000500,
+	0x8078ff78, 0x00000500,
+	0xbf0a6f7c, 0xbf85fff0,
 	0xbefe00c1, 0xbeff00c1,
 	0xbef600ff, 0x01000000,
 	0xb8ef2b05, 0x806f816f,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index 0f4877a601409..0eabb7a8cab94 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -75,8 +75,10 @@ var SQ_WAVE_STATUS_ECC_ERR_MASK         = 0x20000
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT	= 12
 #if ASIC_FAMILY >= CHIP_GC_9_5_0
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE	= 11
+var LDS_RESTORE_GRANULARITY_BYTES	= 1280
 #else
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE	= 9
+var LDS_RESTORE_GRANULARITY_BYTES	= 512
 #endif
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE	= 6
 var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE	= 3			//FIXME	 sq.blk still has 4 bits at this time while SQ programming guide has 3 bits
@@ -572,12 +574,21 @@ if SAVE_AFTER_XNACK_ERROR
 
 	v_lshlrev_b32 v2, 2, v3
 L_SAVE_LDS_LOOP_SQC:
+#if ASIC_FAMILY < CHIP_GC_9_5_0
 	ds_read2_b32 v[0:1], v2 offset0:0 offset1:0x40
 	s_waitcnt lgkmcnt(0)
-
 	write_vgprs_to_mem_with_sqc(v0, 2, s_save_buf_rsrc0, s_save_mem_offset)
 
 	v_add_u32 v2, 0x200, v2
+#else
+	// gfx950 needs to save in multiple of 256 bytes.
+	ds_read_b32 v0, v2
+	s_waitcnt lgkmcnt(0)
+	write_vgprs_to_mem_with_sqc(v0, 1, s_save_buf_rsrc0, s_save_mem_offset)
+
+	v_add_u32 v2, 0x100, v2
+#endif
+
 	v_cmp_lt_u32 vcc[0:1], v2, s_save_alloc_size
 	s_cbranch_vccnz L_SAVE_LDS_LOOP_SQC
 
@@ -601,6 +612,9 @@ L_SAVE_LDS_LOOP_VECTOR:
 //	v_add_u32 v2, vcc[0:1], v2, v3
       v_add_u32 v2, v2, v3
       v_cmp_lt_u32 vcc[0:1], v2, s_save_alloc_size
+#if ASIC_FAMILY >= CHIP_GC_9_5_0
+      s_mov_b64 exec, vcc
+#endif
       s_cbranch_vccnz L_SAVE_LDS_LOOP_VECTOR
 
       // restore rsrc3
@@ -763,8 +777,13 @@ L_RESTORE:
   L_RESTORE_LDS_LOOP:
 	buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1		       // first 64DW
 	buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:256	       // second 64DW
-    s_add_u32	    m0, m0, 256*2						// 128 DW
-    s_add_u32	    s_restore_mem_offset, s_restore_mem_offset, 256*2		//mem offset increased by 128DW
+#if ASIC_FAMILY >= CHIP_GC_9_5_0
+	buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:512	// third 64DW
+	buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:768	// forth 64DW
+	buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:1024	// fifth 64DW
+#endif
+    s_add_u32	    m0, m0, LDS_RESTORE_GRANULARITY_BYTES					// 128/320 DW
+    s_add_u32	    s_restore_mem_offset, s_restore_mem_offset, LDS_RESTORE_GRANULARITY_BYTES	//mem offset increased by 128/320 DW
     s_cmp_lt_u32    m0, s_restore_alloc_size					//scc=(m0 < s_restore_alloc_size) ? 1 : 0
     s_cbranch_scc1  L_RESTORE_LDS_LOOP							    //LDS restore is complete?
 
-- 
2.47.0

