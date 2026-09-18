Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9040AC982D0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 02:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A4710E7B8;
	Fri, 18 Sep 2026 02:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wOsiFNBy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E753710E7B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 02:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPfNDO87SexHZYt1wcqItSlzJOKAAsKgCUit/htZNjYbsQgZzyuqniSumry3Olk03zBVDqR2Ct1WqNGWAPxOf36Lxb8qSggkR9QOnogciXLkf62MB4xH2T95cYq+HXUAatZFynhtapyGe0gzOghe/Im8xuZ61E2OMz17W204U300aLTnyZLzmpR3rag1KRxyBT+CklY/1/XG0uGK8A+HxiWqgfmrZ8IZNlB3ZthDseX02qGuFpEoJnjBAJCGwisBh57eRwI6ug40l6V/JJ+hSCw8YY5RFPGc4gtgCjwhoZERv4dyGusvYa+HC0JDZeVkPzoBdvaZUFENapjzJRVueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I18v61+Iu1Nr9UqOb6K4VtOFOcLP0opPvfJZvYfjhsg=;
 b=JemfkU9H3ehUVzS4C5M9PUur5lJsJmGz4dPMt5Cj5/C17WszvM21CJBV4hWuccKHBuNfO4TeTUgZO6OtcKNmEYgWs5i9caHfeUNzWib+oSeW34lIWk9z2QPnBOaFtxjlgjQNn4ejUWZUWSiicEjdxq6WFmA5PRNQCRSdIpQllrWKjNbDQTwwHXl2cLpMLONXD4SOMY+F9f3P6oFR/UWTwfVz30HvRyBxfCsZDPQ0/MSz5cVkCXrkBcgoCEsS/ELEy5lmGOxFVhUmSuZSAkyMVgshglRMRnnYQLOEMGPh4Dj5ZUGoo63mkSZCTfoZy2WHKVEk991wQwDFUWQIuIc9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I18v61+Iu1Nr9UqOb6K4VtOFOcLP0opPvfJZvYfjhsg=;
 b=wOsiFNBy/bVBBMPN/EeughH+Ir21vyj+qg0VuJSHjXS3A8N8hd7ieIwAGylSK9/e24uq75LLt+EV3fieMgcbPpaUTlJ8mfYSI1EWXySRMRW90cYU6gunstA7zlRqG2TZwR3dywWz1UfoHv7u9klMM3+253T4Wl6vRtjwUrrIHDc=
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 02:13:56 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::6d) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 02:13:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 02:13:56 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 21:13:55 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Joseph Greathouse
 <joseph.greathouse@amd.com>, Lancelot Six <lancelot.six@amd.com>, "Vladimir
 Indic" <vladimir.indic@amd.com>
Subject: [PATCH] drm/amdkfd: Preserve v1 in gfx12.1 trap workaround
Date: Thu, 17 Sep 2026 21:13:42 -0500
Message-ID: <20260918021342.2566402-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 605841f4-a5c7-41c1-d9d2-08df152a7e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: lVPlkM343Q8egrYQlFEEmysn/c4l+YAAx2JoB4do6Tr9wa8jAzRugom5iPeKMaLnwxIoJO7kkjLG5OPRlo+iQatTQA+wbKDJ9XH3p0ra9lrmAGHoNNkeOWaD3TCfUjnTjCDj8Z05c9VrnFpHbuQ21FEkw81eyxrJdyfe+YUFHOO6M/05mWIzmTrhn4jx5UDIapUrEJy7QJQVAzD4cyswIVDVD5Y1oFAo02qO3lg4fdOfcxQCDl6ns3Od2TORiXJF9cYzuAUDoBSJZPweMFXZN7HVCDax9i74RFyLFiF2z/MxzLi+QW1W6i0LepS8E/OgRCf6MXPyoqrI2cIYu5cPuy5sIBhTJal8Ujh8Tqn0/eJipPXn40yFmINOfvmG0GSiN8lAYuXQNFJ0XMLOa/TzqxO1kj2OMptO7F2te1JFMDWlXrRD+VNfxGd5FX74TMKJ1xNDMDetfvyy3tGiDghnNII79F7Bm1Z36iVpIqNL1zaM2pjknp7FRUVAkTsxj9CW5TE80JJzwF0GCmshBgsUo5AkHCAfVOiaPoeLMHEVYn0RbdVbR76ZSjwWOokVqvIpQUA/DuOZpM59ZB5HfxTFShDeob5XQnyOxE7XhRjEeHriakxHz/VIlnMgXLzNytJ52BSGY4hXOgtkibqMCeOrH6lUp4ZE/5715INRbuyqMylTj/94nOVjV/ErUI/yqW48LIKh04MEQNek5Xg5scHrXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UuWmnyYvty+n88W1ov1YJRrP2bD/sbVV7makKx1tXukeZkNo2Lp771VFLCtbImURGs5S+2TXoWaqbqdWCPLsV7fMy6QN75iXSgstkJZ0djtw+W5upsbZGpuxrf4nrfr2FRPXmpHLCD5fQSJqK9rOg3KksbsteONGeoscZDy0xwiEYGDZrZx57bZskpt3HToUQQhK0gAgfYRfjCRlAXEm8ipvdtw2lrZ9vs9ylPbKR4JBsDMi2kmJD6i2pJTnUR05d1ME/tha30CbL8GcosNsVzYYD2wIrQhWUxiW8WW2LCGp71q4Ncwm7gedyBNXnuW1dtkd5IO/SuskpkXkf8Go8zS1dQsxCGlsKgCtfuvwNYnc9LDQwcc0E+Jl1X7O44WUTjEkeAh/u63U1PDpzVPG1J/+LmXElMLSLV0sPXOvwEypcJ1mLj1r1qanbtCy8ZU0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:13:56.0124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605841f4-a5c7-41c1-d9d2-08df152a7e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

If MODE.DST_VGPR_MSB != MODE.SRC0_VGPR_MSB upon trap entry then
v1 would be trashed.

Adjust workaround to prefetch random address 0xFFFFFFFFxxxxxxxx.
This is unused address space on gfx12.1 besides the TBA and TMA
which are harmless to prefetch.

Also remove unused WAVE_START exception handler.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Joseph Greathouse <joseph.greathouse@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 16 ++++----------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 21 +++----------------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 8cf3527dc156..73889430d2e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4601,19 +4601,11 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
-	0xbfa00001, 0xbfa003f1,
+	0xbfa00001, 0xbfa003e1,
 	0xb0804009, 0xb8f8f804,
-	0xb8faf811, 0xbf0d887a,
-	0xbfa10008, 0xb9800211,
-	0x00000000, 0xbeee0180,
-	0x7e020280, 0xee17406e,
-	0x00040000, 0x00000001,
-	0xbe804a6c, 0xbefa007e,
-	0xbefe0081, 0xd760007b,
-	0x00010101, 0xbeee0180,
-	0x7e020280, 0xee17406e,
-	0x00040000, 0x00000001,
-	0xd7610001, 0x0001007b,
+	0xbefa007e, 0xbefe0081,
+	0xbeee0180, 0xee17406e,
+	0x00040000, 0x00000000,
 	0xbefe007a, 0x9178ff78,
 	0x00008c00, 0xb8fbf811,
 	0xbf0c877b, 0xbfa20002,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 233ed8b6d122..9d54a77da6cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -246,28 +246,13 @@ L_SKIP_RESTORE:
 	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
 
 #if VMEM_ON_TRAP_ENTRY_WA
-	s_getreg_b32	ttmp14, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
-	s_bitcmp1_b32	ttmp14, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
-	s_cbranch_scc0	L_NOT_WAVE_START
-
-	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT, 1), 0
-
-	s_mov_b64	[ttmp2, ttmp3], 0
-	v_mov_b32	v1, 0
-	global_prefetch_b8	v1, [ttmp2, ttmp3] scope:SCOPE_SE th:TH_LOAD_RT
-
-	s_rfe_b64	[ttmp0, ttmp1]
-
-L_NOT_WAVE_START:
 	s_mov_b32	ttmp14, exec_lo
 	s_mov_b32	exec_lo, 1
-	v_readlane_b32	ttmp15, v1, 0
 
-	s_mov_b64	[ttmp2, ttmp3], 0
-	v_mov_b32	v1, 0
-	global_prefetch_b8	v1, [ttmp2, ttmp3] scope:SCOPE_SE th:TH_LOAD_RT
+	// No-op prefetch to random address 0xFFFFFFFFxxxxxxxx, faults or hits TBA/TMA.
+	s_mov_b64	[ttmp2, ttmp3], 0xFFFFFFFF00000000
+	global_prefetch_b8	v0, [ttmp2, ttmp3] scope:SCOPE_SE th:TH_LOAD_RT
 
-	v_writelane_b32	v1, ttmp15, 0
 	s_mov_b32	exec_lo, ttmp14
 #endif
 
-- 
2.34.1

