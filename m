Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9C6C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334D110E52A;
	Mon, 29 Apr 2024 14:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfiIUA7j";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC19F10E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkqbAgMlaN6Yb9Mrtam1ZRr0uGGswuD1Sa+KdOmBa14Q1CXLSS9hU6TpKXknZQvvrOjAXJbWZ2nqoku7CzGPKGjiz959haFXI2wrlrdz5rYSbvNYRiw79wmh93hIXqmvuL+ZEeuEsLg6VywCYI9U0otUo5eq77lJaHQs5Y+sP+rKOc9SAyDcn+36yyPLLD7pCwxm4Hj6PqJuut/Fmv2uO6ShdlSYAWeBSjFIhpVQ9dhF8A6iTFnb/kq2X8Wbl2YhygLIaNQTcXrPXZIjF54tMSRizY2bXLXHOrwkesHo5y/8eu3oNabSL4UwOPlz7LFzewQFxPmMhPwsq0IBXK74zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps/et5ebeXZ9lhawrv6QiRXprD3EweTlSZ3gywGnUjI=;
 b=H+V3kAFTXbs58cKusG7rh/fXQlNgDqkgT0rHcJLBGM84JJJ9ZFY6eo3Gd+/5Y6yWZ/XVSUFZsN+GZrFWapoyydfzSgv5BoAh96iElX02Li0JBSWJ5CHpNL/EcpfFCK2p9Et9yMXh5ChWcFxmGUUL05hIqy6ZUtG/agEE+D6QXjCLEHtqmDDR4ongrtSZyDfkqpwSpXUJqYyr+zqRKr4rLlsP8v1RJm7eJ3TPgQLk9Wlcb18e+wKIm7wUcwefFH15RYvvmbUKbKq3ncIgAzyc68B1DqN5CacHSTPHEpg8LNu2QhEyVFkrzAQtoCHtOsIGMWt/F+7Os2B/bUO3daog6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps/et5ebeXZ9lhawrv6QiRXprD3EweTlSZ3gywGnUjI=;
 b=wfiIUA7jy5DprV8Z6hYU+1lsQykRvwNhQbPG/4IfZeXRdGOc5L1T3TCtX+eFFJ28Hkz8t5m42NH1eD/MDCAJgS+wa1HSNd3xpXOvaCU2QALZaELZ0Dz8pVHXjwnl58fdaTuuvLdZS3ef4YshshTEHpfv5zbpsXz+vqwcalrImQw=
Received: from BY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:180::39)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:48 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::4) by BY5PR13CA0026.outlook.office365.com
 (2603:10b6:a03:180::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/14] drm/amdkfd: Move trap handler coherence flags to
 preprocessor
Date: Mon, 29 Apr 2024 10:57:15 -0400
Message-ID: <20240429145726.3459450-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6b9da3-73c1-448b-94bb-08dc685cbc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0howuccPZY97vIq1PeaWAjQLRym5Fy3WpJXJYFRR0VQ7CsRRIQvylwrslj7F?=
 =?us-ascii?Q?UgyrcKX/5qDfIxV5d9E2aWPZE1M8hE1bdcCBVe+KX9O4kXhJYHcpEp3s3xHS?=
 =?us-ascii?Q?QLtkyYK9y91gWKfSD98Mg16WnZJpQDCBjMkjYOQjcEtQBW17Lq5YEYaSXRXi?=
 =?us-ascii?Q?+hWCh3H9GLEOuUZs17quvagcABvNr8LaqZiUwOwGI5kaeEodAg89PCEOXl60?=
 =?us-ascii?Q?UpCy2rHU7vzink1HZXsGF860rYEoNAAq2rAIdJVcWx+KdirfU/yI7dtidVAy?=
 =?us-ascii?Q?9RMoVdvTnA9vHbC1qyyI05z54PVpF/Hvxyr4uOs4EOXuvgw++TYbkX2fJN7b?=
 =?us-ascii?Q?SufooGAcUHF9568xB8SIEtwmaAzRPjGApPuCK3JobXrp236ijhGQuTY7ssl6?=
 =?us-ascii?Q?FRJ0G8CchxAlyPUVWbfyKZTJvNIwrF4+CvuemhDM0H/gt5lSlogHsYbnmMHQ?=
 =?us-ascii?Q?Gq+Ky9BkyK0gx2ezozWiTj5WiOfnv6OxpqHh/+MuvpA/6cqBIwEmPcfW3FxS?=
 =?us-ascii?Q?LzTZjI2mJvQkl/VPHIRW9u0bcJ0yqGhTqWz4ZgzH4IyozyhADpnZk/Yt13hO?=
 =?us-ascii?Q?IndFx6KtaMKH6ilAjKSB6cTORhv1aoCclJKmXuvyNO4V6fZBBoaJvsXlc0n+?=
 =?us-ascii?Q?/ZTpOiLOrBmow8HIn/at6viNbbFlzJ0cHvFiyIdVUoZqkZV5aG+ZWMi5epe5?=
 =?us-ascii?Q?5mmJLAadgbdt/35NzyvElCGZr1oZxQ9z6ZK+y2ssiTdP18gcWMYhk8UGur5g?=
 =?us-ascii?Q?NltRFF08XOOisYXYL09RikQvXPoSjNU2RLBmXHMagNM1BDtN5d75zaViOi/A?=
 =?us-ascii?Q?Jp6Su6xmbIbatEyMo1/c4vw0noEhuUfy6XsSaQp6fyWBbkQPrdedu/XbgQrf?=
 =?us-ascii?Q?FbR6EXSDo4djPQe2JxIbJcY8xtNoetqcdyISW1uCO6+XZZTysVZf0YqNfO0G?=
 =?us-ascii?Q?chzFfgU0wJsxH6iUA7hOzYti8nagd+nUCFS5R5qlh3JfkY5NUNv142/m/26E?=
 =?us-ascii?Q?LPssxoZGVG7GLgrfVcQoWMj6IJz7+c6K+5RC1ubTwYXi7yJ1398X6mZT8o75?=
 =?us-ascii?Q?Ue8mvo7a3a8EF5RBHajAJGqxdZkP/v8LClkuQyHbs0Bc0PLS/nD+Os4ErfY9?=
 =?us-ascii?Q?LlcBY9ht/wH7KugKanaoYMZaYrO2RFhY6IWps0jJFYw0muUSqHm8B7cjEd0H?=
 =?us-ascii?Q?tvckRycZxtJH6AUp3U2jTecDzdAoxV/MCtliSGK1+XgitP6mJdUbtj3Re9Aw?=
 =?us-ascii?Q?Agfk/sDnXiQi4+kay4ZOlw8JwrI3vmDRMV7Q8rmPE2LcLIj9lcscyL6uYta8?=
 =?us-ascii?Q?6nCMqCBMCK2kXqByfS2Rmk/WnDaZvbdqeSsBJEiOhHbKVNVKhpSsPRB+KLOS?=
 =?us-ascii?Q?ysc0MHmaeNXjChqwp79LMvBxHT3P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:47.7142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6b9da3-73c1-448b-94bb-08dc685cbc01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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

From: Jay Cornwall <jay.cornwall@amd.com>

No functional change. Preparation for gfx12 support.

v2: drop unrelated change (Alex)

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    | 127 +++++++++---------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index e1aaa5ce0784e..dae912688c955 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -46,6 +46,9 @@
 #define SW_SA_TRAP (ASIC_FAMILY >= CHIP_PLUM_BONITO)
 #define SAVE_AFTER_XNACK_ERROR (HAVE_XNACK && !NO_SQC_STORE) // workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
 
+#define S_COHERENCE glc:1
+#define V_COHERENCE slc:1 glc:1
+
 var SINGLE_STEP_MISSED_WORKAROUND		= 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
 var SQ_WAVE_STATUS_SPI_PRIO_MASK		= 0x00000006
@@ -298,15 +301,15 @@ L_FETCH_2ND_TRAP:
 	s_or_b32	ttmp15, ttmp15, 0xFFFF0000
 L_NO_SIGN_EXTEND_TMA:
 
-	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 glc:1			// debug trap enabled flag
+	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 S_COHERENCE		// debug trap enabled flag
 	s_waitcnt       lgkmcnt(0)
 	s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
 	s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
 	s_or_b32        ttmp11, ttmp11, ttmp2
 
-	s_load_dwordx2	[ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 glc:1		// second-level TBA
+	s_load_dwordx2	[ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 S_COHERENCE	// second-level TBA
 	s_waitcnt	lgkmcnt(0)
-	s_load_dwordx2	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 glc:1		// second-level TMA
+	s_load_dwordx2	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 S_COHERENCE	// second-level TMA
 	s_waitcnt	lgkmcnt(0)
 
 	s_and_b64	[ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
@@ -399,7 +402,7 @@ L_SLEEP:
 	s_and_b32	s_save_ttmps_hi, exec_hi, 0xFFFF
 	s_mov_b32	exec_lo, 0xFFFFFFFF
 	s_mov_b32	exec_hi, 0xFFFFFFFF
-	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] slc:1 glc:1
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] V_COHERENCE
 	v_mov_b32	v0, 0x0
 	s_mov_b32	exec_lo, s_save_ttmps_lo
 	s_mov_b32	exec_hi, s_save_ttmps_hi
@@ -431,15 +434,15 @@ L_SLEEP:
 
 	s_mov_b32	exec_lo, 0x3FFF
 	s_mov_b32	exec_hi, 0x0
-	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] inst_offset:0x40 slc:1 glc:1
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] inst_offset:0x40 V_COHERENCE
 	v_readlane_b32	ttmp14, v0, 0xE
 	v_readlane_b32	ttmp15, v0, 0xF
 	s_mov_b32	exec_lo, ttmp14
 	s_mov_b32	exec_hi, ttmp15
 #else
-	s_store_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_save_ttmps_lo, s_save_ttmps_hi], 0x50 glc:1
-	s_store_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_save_ttmps_lo, s_save_ttmps_hi], 0x60 glc:1
-	s_store_dword   ttmp13, [s_save_ttmps_lo, s_save_ttmps_hi], 0x74 glc:1
+	s_store_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_save_ttmps_lo, s_save_ttmps_hi], 0x50 S_COHERENCE
+	s_store_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_save_ttmps_lo, s_save_ttmps_hi], 0x60 S_COHERENCE
+	s_store_dword   ttmp13, [s_save_ttmps_lo, s_save_ttmps_hi], 0x74 S_COHERENCE
 #endif
 
 	/* setup Resource Contants */
@@ -488,11 +491,11 @@ L_SAVE_FIRST_VGPRS32_WITH_TCP:
 #endif
 
 #if !NO_SQC_STORE
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 #endif
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128*3
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:128
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:128*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:128*3
 	s_branch	L_SAVE_HWREG
 
 L_SAVE_4VGPR_WAVE64:
@@ -511,11 +514,11 @@ L_SAVE_FIRST_VGPRS64_WITH_TCP:
 #endif
 
 #if !NO_SQC_STORE
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 #endif
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256*3
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:256
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:256*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:256*3
 
 	/* save HW registers */
 
@@ -562,7 +565,7 @@ L_SAVE_HWREG:
 	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
 	s_mov_b32       exec_lo, 0xFFFF
 	s_mov_b32	exec_hi, 0x0
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 
 	// Write SGPRs with 32 VGPR lanes. This works in wave32 and wave64 mode.
 	s_mov_b32       exec_lo, 0xFFFFFFFF
@@ -605,7 +608,7 @@ L_SAVE_SGPR_LOOP:
 	s_cmp_eq_u32	ttmp13, 0x20						//have 32 VGPR lanes filled?
 	s_cbranch_scc0	L_SAVE_SGPR_SKIP_TCP_STORE
 
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 0x80
 	s_mov_b32	ttmp13, 0x0
 	v_mov_b32	v2, 0x0
@@ -626,7 +629,7 @@ L_SAVE_SGPR_SKIP_TCP_STORE:
 	write_12sgpr_to_mem(s0, s_save_buf_rsrc0, s_save_mem_offset)
 
 #if NO_SQC_STORE
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 #else
 	// restore s_save_buf_rsrc0,1
 	s_mov_b32	s_save_buf_rsrc0, s_save_xnack_mask
@@ -709,7 +712,7 @@ L_SAVE_LDS_WITH_TCP_W32:
 L_SAVE_LDS_LOOP_W32:
 	ds_read_b32	v1, v0
 	s_waitcnt	0
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 
 	s_add_u32	m0, m0, s3						//every buffer_store_lds does 128 bytes
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
@@ -747,7 +750,7 @@ L_SAVE_LDS_WITH_TCP_W64:
 L_SAVE_LDS_LOOP_W64:
 	ds_read_b32	v1, v0
 	s_waitcnt	0
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 
 	s_add_u32	m0, m0, s3						//every buffer_store_lds does 256 bytes
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
@@ -814,10 +817,10 @@ L_SAVE_VGPR_W32_LOOP:
 	v_movrels_b32	v2, v2							//v2 = v[2+m0]
 	v_movrels_b32	v3, v3							//v3 = v[3+m0]
 
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128*3
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:128
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:128*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:128*3
 
 	s_add_u32	m0, m0, 4						//next vgpr index
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128*4		//every buffer_store_dword does 128 bytes
@@ -859,10 +862,10 @@ L_SAVE_VGPR_W64_LOOP:
 	v_movrels_b32	v2, v2							//v2 = v[2+m0]
 	v_movrels_b32	v3, v3							//v3 = v[3+m0]
 
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
-	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256
-	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256*2
-	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256*3
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
+	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:256
+	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:256*2
+	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE offset:256*3
 
 	s_add_u32	m0, m0, 4						//next vgpr index
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 256*4		//every buffer_store_dword does 256 bytes
@@ -899,7 +902,7 @@ L_SAVE_SHARED_VGPR_WAVE64_LOOP_SQC:
 
 L_SAVE_SHARED_VGPR_WAVE64_LOOP:
 	v_movrels_b32	v0, v0							//v0 = v[0+m0]
-	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
 	s_add_u32	m0, m0, 1						//next vgpr index
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128
 	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
@@ -1017,10 +1020,10 @@ L_RESTORE_VGPR_NORMAL:
 	s_cbranch_scc0	L_RESTORE_SGPR
 
 L_RESTORE_VGPR_WAVE32_LOOP:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:128
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:128*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:128*3
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:128
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:128*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:128*3
 	s_waitcnt	vmcnt(0)
 	v_movreld_b32	v0, v0							//v[0+m0] = v0
 	v_movreld_b32	v1, v1
@@ -1032,10 +1035,10 @@ L_RESTORE_VGPR_WAVE32_LOOP:
 	s_cbranch_scc1	L_RESTORE_VGPR_WAVE32_LOOP				//VGPR restore (except v0) is complete?
 
 	/* VGPR restore on v0 */
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1 offset:128
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1 offset:128*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1 offset:128*3
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:128
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:128*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:128*3
 	s_waitcnt	vmcnt(0)
 
 	s_branch	L_RESTORE_SGPR
@@ -1051,10 +1054,10 @@ L_RESTORE_VGPR_WAVE64:
 	s_cbranch_scc0	L_RESTORE_SHARED_VGPR
 
 L_RESTORE_VGPR_WAVE64_LOOP:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*3
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:256
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:256*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:256*3
 	s_waitcnt	vmcnt(0)
 	v_movreld_b32	v0, v0							//v[0+m0] = v0
 	v_movreld_b32	v1, v1
@@ -1077,7 +1080,7 @@ L_RESTORE_SHARED_VGPR:
 	s_mov_b32	exec_lo, 0xFFFFFFFF
 	s_mov_b32	exec_hi, 0x00000000
 L_RESTORE_SHARED_VGPR_WAVE64_LOOP:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE
 	s_waitcnt	vmcnt(0)
 	v_movreld_b32	v0, v0							//v[0+m0] = v0
 	s_add_u32	m0, m0, 1						//next vgpr index
@@ -1089,10 +1092,10 @@ L_RESTORE_SHARED_VGPR_WAVE64_LOOP:
 
 	/* VGPR restore on v0 */
 L_RESTORE_V0:
-	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1
-	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1 offset:256
-	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1 offset:256*2
-	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save slc:1 glc:1 offset:256*3
+	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE
+	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:256
+	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:256*2
+	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:256*3
 	s_waitcnt	vmcnt(0)
 
 	/* restore SGPRs */
@@ -1207,9 +1210,9 @@ L_RESTORE_HWREG:
 	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_buf_rsrc0
 	s_addc_u32	s_restore_ttmps_hi, s_restore_buf_rsrc1, 0x0
 	s_and_b32	s_restore_ttmps_hi, s_restore_ttmps_hi, 0xFFFF
-	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x50 glc:1
-	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x60 glc:1
-	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 glc:1
+	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x50 S_COHERENCE
+	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x60 S_COHERENCE
+	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 S_COHERENCE
 	s_waitcnt	lgkmcnt(0)
 
 #if HAVE_XNACK
@@ -1247,7 +1250,7 @@ function write_hwreg_to_mem(s, s_rsrc, s_mem_offset)
 #else
 	s_mov_b32	exec_lo, m0
 	s_mov_b32	m0, s_mem_offset
-	s_buffer_store_dword	s, s_rsrc, m0 glc:1
+	s_buffer_store_dword	s, s_rsrc, m0 S_COHERENCE
 	s_add_u32	s_mem_offset, s_mem_offset, 4
 	s_mov_b32	m0, exec_lo
 #endif
@@ -1262,10 +1265,10 @@ function write_16sgpr_to_mem(s, s_rsrc, s_mem_offset)
 		s_add_u32	ttmp13, ttmp13, 0x1
 	end
 #else
-	s_buffer_store_dwordx4	s[0], s_rsrc, 0 glc:1
-	s_buffer_store_dwordx4	s[4], s_rsrc, 16 glc:1
-	s_buffer_store_dwordx4	s[8], s_rsrc, 32 glc:1
-	s_buffer_store_dwordx4	s[12], s_rsrc, 48 glc:1
+	s_buffer_store_dwordx4	s[0], s_rsrc, 0 S_COHERENCE
+	s_buffer_store_dwordx4	s[4], s_rsrc, 16 S_COHERENCE
+	s_buffer_store_dwordx4	s[8], s_rsrc, 32 S_COHERENCE
+	s_buffer_store_dwordx4	s[12], s_rsrc, 48 S_COHERENCE
 	s_add_u32	s_rsrc[0], s_rsrc[0], 4*16
 	s_addc_u32	s_rsrc[1], s_rsrc[1], 0x0
 #endif
@@ -1279,32 +1282,32 @@ function write_12sgpr_to_mem(s, s_rsrc, s_mem_offset)
 		s_add_u32	ttmp13, ttmp13, 0x1
 	end
 #else
-	s_buffer_store_dwordx4	s[0], s_rsrc, 0 glc:1
-	s_buffer_store_dwordx4	s[4], s_rsrc, 16 glc:1
-	s_buffer_store_dwordx4	s[8], s_rsrc, 32 glc:1
+	s_buffer_store_dwordx4	s[0], s_rsrc, 0 S_COHERENCE
+	s_buffer_store_dwordx4	s[4], s_rsrc, 16 S_COHERENCE
+	s_buffer_store_dwordx4	s[8], s_rsrc, 32 S_COHERENCE
 	s_add_u32	s_rsrc[0], s_rsrc[0], 4*12
 	s_addc_u32	s_rsrc[1], s_rsrc[1], 0x0
 #endif
 end
 
 function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
-	s_buffer_load_dword	s, s_rsrc, s_mem_offset glc:1
+	s_buffer_load_dword	s, s_rsrc, s_mem_offset S_COHERENCE
 	s_add_u32	s_mem_offset, s_mem_offset, 4
 end
 
 function read_16sgpr_from_mem(s, s_rsrc, s_mem_offset)
 	s_sub_u32	s_mem_offset, s_mem_offset, 4*16
-	s_buffer_load_dwordx16	s, s_rsrc, s_mem_offset glc:1
+	s_buffer_load_dwordx16	s, s_rsrc, s_mem_offset S_COHERENCE
 end
 
 function read_8sgpr_from_mem(s, s_rsrc, s_mem_offset)
 	s_sub_u32	s_mem_offset, s_mem_offset, 4*8
-	s_buffer_load_dwordx8	s, s_rsrc, s_mem_offset glc:1
+	s_buffer_load_dwordx8	s, s_rsrc, s_mem_offset S_COHERENCE
 end
 
 function read_4sgpr_from_mem(s, s_rsrc, s_mem_offset)
 	s_sub_u32	s_mem_offset, s_mem_offset, 4*4
-	s_buffer_load_dwordx4	s, s_rsrc, s_mem_offset glc:1
+	s_buffer_load_dwordx4	s, s_rsrc, s_mem_offset S_COHERENCE
 end
 
 #if SAVE_AFTER_XNACK_ERROR
-- 
2.44.0

