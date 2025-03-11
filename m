Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A754C28B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A06210E2DD;
	Tue, 11 Mar 2025 21:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGkccqRI";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E9110E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJt95mSTO9y6Ogfbbxe3oTz50Dno+0A5fdbgO7mf/jwzAFeTGsoxOTU2y8nD3Y/ZKoqKMbisNFayJHzIJYJjzAzj29LmdB/AoJhWRsrgCr4illoNQxed3mDABIl8SJbBnP1xSOcit0azVbKr7zRBPCRSNhW/P8lVQqN4xwex+mUY7qajU3NCJllcwDLddEIi4OJZ2E2UFg4OpaNwG2QJHdI/iEn2zwf0iB1hmlcNY5TA+ZfsPfK9tGdkA5QrjhXZqsXF5gcL/XiqGZCFGp14kemM4srlWzRsOjQu5gcY5cgGaUuONq6GEGC2Towcnvaec7UuC/DFiUUpngtO/ZcrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNLpIktK+41hL0lRZnR8bfuldA8u5LYQWNC81QM22q8=;
 b=u44Ue+ZTfGJRsJALRynymkYcx7eyFR6hZTNGxQ8CGgQJyy4HGBQ3QY3pKxDAXyHQ0stQg/kVZry/XiuqF8uLlfEBVD3LcKiMHZuN9MV+W+6C193zFxZkq6utDNiqzCUOd1at2brziFW6jUqCCQTsLpV6Gm21BXCVnMfRBJtN0dZXnFpnzL3caWtDArFlalbVvOrfOoT/wf+/IfScnRiBKXpWyqYqondUZ2rEtvrXTrR8HlVIygkPADMMaSkEUW8FO4rBC2E190YfHNbVMSR7W2ZGD3MZt5dfIoMngZG+yYqULYHgJtDPrCyrMneWZxErQoVih6NFD4Xytu+39hfryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNLpIktK+41hL0lRZnR8bfuldA8u5LYQWNC81QM22q8=;
 b=hGkccqRIL2pYkRMdkX7n6NcnRpgZqrvLIEkYWcPNFoj3347xXyrMiwcShpPWrk1wY9/0WbxrsxITp9EHzq5ZdhY5G4TU4Mzr5x6d+SoefkzAVrkjoO/CkRIU2eCPX4tmyyxtE+B2dGFuNh+3znmCA1v1Bk5e/5oRsL83+pYFST0=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:49:19 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::b1) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:49:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:49:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ryan Seto <ryanseto@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 02/11] drm/amd/display: Prevent VStartup Overflow
Date: Tue, 11 Mar 2025 15:42:03 -0600
Message-ID: <20250311214618.3106637-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ed5c5e-e72e-4d81-ea96-08dd60e693ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PriMNoCqRGSMuuDwAh5oVzpFtHU89gjWsBmIZ5rATU9AUUQGfNazVu/CNHIP?=
 =?us-ascii?Q?BsNYESfDBfy8WrBie6681wxHe2ZEIyiTRxeqqQWX6U38hmD3iTfBbvJIEX4z?=
 =?us-ascii?Q?6oRCvwnDHviUi8BNJhJCj3SeANOYqKluq0Lor7+dhfbs+x/o1MMNsaO+MSx+?=
 =?us-ascii?Q?k7BoxGhbqH0xm3Abte6m/ZabvoEpDevhptKd3sYBVcdZ4UVB/jlzAZXvwVpH?=
 =?us-ascii?Q?UsBIgxCsA4PH3WzomxhPnN3LjcuKSFpkgHmtx0fIDvRN4c51z0HBEnn0wGCq?=
 =?us-ascii?Q?JYxgzuKNK9LMC1LfWLzM7zPT/Purc8h4adtJT4jTyh3a2X5odOmz3ZKfpVV6?=
 =?us-ascii?Q?jDnCeSU9ScGKilsxeUv8sshLZGnWTl39mVcy6mfSFAqd9EPZpOaOjACreMNv?=
 =?us-ascii?Q?9QP/kwkMbXB7yc3BGZYOI+Sc8Xizmu308O0Vx598aD/LasO9MIcAPwX06Vlf?=
 =?us-ascii?Q?ObZUMywINm8cg+RQCE6WV4v9C/bNgnbR6EccKv3sF0q5W/jyakkM/pFi+D9N?=
 =?us-ascii?Q?SLmDEL8lpnriT8euEhvZMZ0bvFo2MUwDSK8U6zJ7KsP83DGVre8yHxYRT2te?=
 =?us-ascii?Q?HtxupDVYhqjZaV0iEmOFxfPo4LBGTQknLHslpJ+b44w7no3cL+UU9IUuFnRK?=
 =?us-ascii?Q?1/Ge7VJ2qhnWWz0ONCjfW8Oy7ccx4NbKj74HvHwvOacUAMyHBC/6oirZOXHw?=
 =?us-ascii?Q?ASrkuxb7iAIF6bqQYmOir8eWxd2VlV30UhMTdTYlDJ2sAg02PpAAJXeAsdgd?=
 =?us-ascii?Q?O5YrszO8TFlVTlT1r80oBDGUgaqMbYJGNBopBrpu3+UJd9NslYnjSRYWBUiT?=
 =?us-ascii?Q?MixTOYAFtT5SmiyIy9ZbcZXSPH8wqpWvAy3esST6NL7JsL5LLYRki3G/9+BL?=
 =?us-ascii?Q?RL0Gaa4h6nkXxSzLGQUfERStn8OWRonvBFFIRCh8atnQdvmNeH6Py2cxg4P+?=
 =?us-ascii?Q?lvZNVr8N/UJVkg2eK/3hIyx7y8U3enN7vcXoh6YqwESoaHjHk9wgeMDE8nuL?=
 =?us-ascii?Q?GlsR9EMQHoN+/aFDiSS5oM9E2vAhuKFsNGj48qoqqyEqLMu+kxC6KBK+z78T?=
 =?us-ascii?Q?XmYq5Ydlii6CvrD5N8feZw33q6ZKAcbCRPEJQ7XPzxHpxc3zLKDkSbNWQJBy?=
 =?us-ascii?Q?l0GJlDHwVFYRdxqVYoLMKu5K5Cwtipeez/gALRpfQAe6Qy/neun6WmKxX10W?=
 =?us-ascii?Q?VSLQsVp3M9wizhmp+I+f98vFOlcD3gByEMstnVkuEFFYM+m1PeDUMCAUa53K?=
 =?us-ascii?Q?OQDzvXYvoSIgBhJanOkPw5fG1WhOlEp/jE6j9Aeho8r5Er0cnvCK6g6qZcYb?=
 =?us-ascii?Q?Xmar0qs9eOp8xiruJRMJ7rYZt83bS41xhEP/K7o3xaZwIMhuaJfpjTx/mbhJ?=
 =?us-ascii?Q?Lc5J3Y+JtMQCZAG2++ALqjIgt1+o5kUGW7rHxO9aM+d09OtZHgPUhRXh3PwE?=
 =?us-ascii?Q?FjuZjZQqCwGeXIjjhaYUS3eHUd76GFmxPQJK7L1nKj+rfaxc/OpEIJGHI/5+?=
 =?us-ascii?Q?yGvRw1+rlotW2y8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:49:19.2468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ed5c5e-e72e-4d81-ea96-08dd60e693ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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

From: Ryan Seto <ryanseto@amd.com>

[WHY & HOW]
Fixed Overflow issue by clamping VStartup to max value of register.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 84a2de9a76d4..7ae9c0ba0c9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -32,6 +32,7 @@
 
 #define DML2_MAX_FMT_420_BUFFER_WIDTH 4096
 #define TB_BORROWED_MAX 400
+#define DML_MAX_VSTARTUP_START 1023
 
 // ---------------------------
 //  Declaration Begins
@@ -6210,6 +6211,7 @@ static dml_uint_t CalculateMaxVStartup(
 	dml_print("DML::%s: vblank_avail = %u\n", __func__, vblank_avail);
 	dml_print("DML::%s: max_vstartup_lines = %u\n", __func__, max_vstartup_lines);
 #endif
+	max_vstartup_lines = (dml_uint_t) dml_min(max_vstartup_lines, DML_MAX_VSTARTUP_START);
 	return max_vstartup_lines;
 }
 
-- 
2.43.0

