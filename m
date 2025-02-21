Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB1EC021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FBB10EAED;
	Fri, 21 Feb 2025 16:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4Mt2d/Q";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F321510EAED
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msxsKELx3F9dKNAq0bdJ5hmUf8XuClxB66Zw2lFJrnqDb6CfefhNFOrIRVOJhejrlZvaRRxZhXIhWsNw5FKc9BVPUdEAa6TSjCCdgMScGeIAXaVhbc7rBUIlTDmiI0xHL1RTNTUmu8S4nsxRsmLOMz6PVM+3lUbpTQEormzJd5HLV/xlV5ZtArtxbDVP1PpP9GWXcPYJvyAPvXgel84dunczNhyCt/sDs1JKNRq/2Zb+a9jr1mYZt01gq6woWmqQdrtA30lA2PpsziY4CPBy/6yVjJT2uvrP/PD4ksSV9UUN6jOgagSTxOS+wvB/M2TP2oSoeV0qfm6wMkV+tS/WIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnMSXEUVMa1V8A9rcWO0O4vNJFyzvSu/LzC3TmfG47c=;
 b=wRLXKH+SCU8N5AMEESyHkAhB6mEaUHdxR7VX5QZakzDSQoZrkm/b63ank0IYlmdk2naBg7dfHGKr9q2j0fYVO8stEOeuTCk50FPPgvPvchYECcw6Mqfc/nEfENN4ZhReY/uINJAJUH3IPCFHlITFydDLIU4CjJdv2mkYu97hb7DKjkTAudAUiEubvYTxVNvQ4ItMNIDceu+ynnJc1W3UDQzidhq0HYsmiG0z6XtWUl3unwPCD/fFur8azfAIH+1D3wUb1zcCnc8a9vZ4yCNvCCbwvQB1E42zMoJwf/k3ua1PEVuy2VPnExoDWdUjyw+OqEfi1+9YosB6yX2sG4ltsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnMSXEUVMa1V8A9rcWO0O4vNJFyzvSu/LzC3TmfG47c=;
 b=e4Mt2d/QiEIYC+Pbtvye+oxAYIJWmWif9mzh9v/vHyhxv3a1Ilsr6/RMh7Bn/IG+AGCRHTkm9A+bxyzQIY9hmrnLRVfQnWjCbwGN6W8VKeGY1zwvhGzsNB+e2n0x+PWIeCWXTdVWzReaQpzjcfSLIK5IUfVAL45MlgAmH4NK7WA=
Received: from PH7PR17CA0054.namprd17.prod.outlook.com (2603:10b6:510:325::18)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:37 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::77) by PH7PR17CA0054.outlook.office365.com
 (2603:10b6:510:325::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:36 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:27 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Increase halt timeout for DMCUB to 1s
Date: Fri, 21 Feb 2025 11:01:41 -0500
Message-ID: <20250221160145.1730752-21-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 75008818-fc34-4460-2974-08dd52912936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wzxWTWSMsQjHw8rvN4f0c/B4qR+Hc7y6v9yTa+1fXVum9Z3sc7apt5XMVn8r?=
 =?us-ascii?Q?HemU7zvVi9KrcNdQyuURtd++49wX5O/ahABsNXBHHUzJI2ZJHsysRDXAgRe8?=
 =?us-ascii?Q?796KLbwUK1WiDQP6qegQNRytDk/ex2rjRd60S4BBuyMWycCkkyzwcPpROGj3?=
 =?us-ascii?Q?sS1qGEdd3v7xS2aLZ+3+BY/nkHQetoNMj8QgodY1tIE6SqhVezc1c600GlIw?=
 =?us-ascii?Q?dk9zKWkq97/6+XbAKlQ5oMpDtkmJMJzhdRrMO49O3WzYrHeyknvfXp8UFIEh?=
 =?us-ascii?Q?DyeeVcX5GxPcvlMUuH96keAogoqXntcooQ510lkYJu1UjrccLfx0ss1Qu3bb?=
 =?us-ascii?Q?Iacy1AW/xfzWN5aGfVSlYHWEgDTf23HlhMGsOrGe2FkzGAxR+fdu65nsrx/z?=
 =?us-ascii?Q?DS9XDfsD3y/RRWY+ZSJwj6ssjQKgmTOz3p1URHCOLR5HvbXv2O+J+m4jVCDW?=
 =?us-ascii?Q?h5BOPCQcNDIi+LOr5oBwqDtCB2iM3N3zc/Ykp/0wlYZPBRt/PkKfWu4RfBCb?=
 =?us-ascii?Q?Y96lLJvbeXjVZpVkAkoVWGwvle3ZEEf5O6iUOmPIvzH71PzOog3jAZqTMX+j?=
 =?us-ascii?Q?h8re/6x1zB0+tZ0vDK2LtVS67EBX2INAOS2avcy6/Cd5CQ3b+xmpLL1PQmVT?=
 =?us-ascii?Q?m2gD5UhxdCumZqaEjdTgs4chHK0NC8b/IyqK0UZx0whWdrt6gxJIv66aAlAC?=
 =?us-ascii?Q?b/PZYMq6CBKglskrzttJQuM8vacN+QnkosIZkHUGF4pAG2HDMwurMKDd1XAO?=
 =?us-ascii?Q?S8CGW3yFKd7C9rcj0ScPJZ3CC0aPJw+BO8q+ptY74cfe4wKg7oOeJ0/IaIRF?=
 =?us-ascii?Q?RqKzBhaU3S6EHseEjcldRfq9CWl3pd7pK6Mh4Ww7z80xnen1DWv8lop2YJr+?=
 =?us-ascii?Q?DrdVLfvea1Cg/9pEKtdoKXfJgMJe7uHYc2ch8CMeixLgMnC+TLhVMPY+kKRb?=
 =?us-ascii?Q?o7jAzvXOjYv0iL0pVhBJl1CZdVF56BGZAcVMnObVR9KEAppLNXr6FR8fb9yi?=
 =?us-ascii?Q?0u9peaSrvYCPju3mByA8swtNDMIttW7yTVKmDu7yuKfISaYKllQ18y6Vee1C?=
 =?us-ascii?Q?x89M3j48LDrrRqcu9c1w9kgwZUM/g/M/brXvhukTaBz7Xx2HwfgFFQpk8nIU?=
 =?us-ascii?Q?efAjPuBOpJ/wcM363cg01RoDO34uCjfQPs9rMeJBne4Cjaf6T6e1jkUkdWmJ?=
 =?us-ascii?Q?ziAu9BI3m9rjJ1z2YjSiD7krHfuMAOJP6SoUSYlvHHMg7O0T2Is7+e41UkBP?=
 =?us-ascii?Q?zrogHmwK9xl5FDbsX/tN3S1NtFEC+o9+CGINeE0Yfq6M0Fb2iSNRuuh/97ao?=
 =?us-ascii?Q?eU18z279sYFGGn1qzX7j+1ZBvV5kr2jG9YW8VlS4YjDHj+VhgzO/26Rd/pna?=
 =?us-ascii?Q?xDXgXDkTo69gSSq2vqSI7lV6gjM+CL7c4T9aFyCfrK49w/1zMrQKhZpAy6Vh?=
 =?us-ascii?Q?pPKKO9r7nmyom4NBt13aWKFof2boNuDLGU8Ab5vb5S+WvWyGnrTt+2RT23Qx?=
 =?us-ascii?Q?hiv7snHVhl5uUdg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:36.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75008818-fc34-4460-2974-08dd52912936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If we soft reset before halt finishes and there are outstanding
memory transactions then the memory interface may produce unexpected
results, such as out of order transactions when the firmware next runs.

These can manifest as random or unexpected load/store violations.

[How]
Increase the timeout before soft reset to ensure the DMCUB has quiesced.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 15 ++++++++++-----
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 3d0bba602b53..1fac75dfc650 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -83,8 +83,8 @@ static inline void dmub_dcn31_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn31_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100;
-	uint32_t in_reset, scratch, i, pwait_mode;
+	const uint32_t timeout = 1000000;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
 
@@ -125,9 +125,14 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
+
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index e5e77bd3c31e..652173b10401 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -88,7 +88,7 @@ static inline void dmub_dcn35_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn35_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100;
+	const uint32_t timeout = 1000000;
 	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
-- 
2.34.1

