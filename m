Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB86EC02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1F910E83C;
	Tue, 14 Jan 2025 02:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xwYZRx7l";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE84710E83D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlXk7FhWEgAlUAsYpxY731VePp8TMeFfzZxEmErjMHpShXIAqEmn1vmoUpTBsSly+/38FbFgEOFKqE152oA8VfsYFfZTDUcTKQS5/G7xLmXXdQfrVX2oTaUucRtNEDyBOU9XL+8C4DZIpH3JoS7+BQQmHEpj4aKkFwrkpRr9qgnlA+fdwcPuJWd747E67jRMHrSeFByYzk4WGhJH/eeYGA+TSW4QNw6g3TNyBD8mim/pzY3/M8kmqqEGRRno1z01AAWlPhBxnLn+PDz10xcvyTbJB/T+MlNJVops0ZCjf35VzstqQw6Wst6pBecJmZjpUglSb9Fz47BLkQ/qbXpR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yJLWXJsmQiQTPB1T5UvGee/LMeI6ak8wpHnDWTmQnE=;
 b=nr6ubCRGQPFy6UFVIYpkElVjpaOjOw9tM0DO49bsLmkKnUw2AZvtAIeof+96f/yMkGDM+1t5DRLjUq5mcgSjq92liE6oB8okUkRs7QtuStH6hOWgduoTuHGYPwxHAshGXw2a4LcjbukFCk1gZEG5WL9kAMqnNPx9QKGUkE1hcp9S0bQa5yEHP1Ki4Ppx5EvpQCPpNOtV3OU8VEtBJvuDK71N0vmWIxnG7nXKI1J1jiN95yEv1irtPyg1Ne+wHh78xd9f62suefOvfI+8AQzs//fDkQ1QN1K8+hN9WOcZCn+ijYSdqSHzbeq74PdGQsg98hau0N3YhmPg4bPEgiCS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yJLWXJsmQiQTPB1T5UvGee/LMeI6ak8wpHnDWTmQnE=;
 b=xwYZRx7lqAvnroAMh7WCv35SG/HK732IULMdYi0VnQHHaBMq/pxr2oiyPGheFIapIPBMDMJkWjfcgAn9zGB2RCqjLKOUAsboAwVqcO0OfN+CdNO7TMVEkz+uKYQXEWgj1RoY1E4nEEeoXVHjWuOGD0RjhPi9thDAlPvrJE6fsh8=
Received: from MN2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:208:134::32)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:10:01 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::73) by MN2PR16CA0019.outlook.office365.com
 (2603:10b6:208:134::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:10:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:10:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:10:00 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:09:55 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 04/11] drm/amd/display: Populate register address for dentist
 for dcn401
Date: Tue, 14 Jan 2025 10:08:53 +0800
Message-ID: <20250114020900.3804152-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: f75cc508-b217-44b4-2a9f-08dd34408d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q/wmKi8GIyiio2H3ELaxviFHusmlSwhs1tJHEyYHCWiGzUTLo4AsOM7mGDwB?=
 =?us-ascii?Q?eOkuIooGo9cAFKLvyE86iYt+SrfWmK9Rt+P6EoqZC3Sj07ylFR0kWyv9t+6Q?=
 =?us-ascii?Q?XyAOinYhxTnQgH7r0UvsGAVk3oBD+5v6mhwO3UlbcqomB1GpDALhTF9ay4Rm?=
 =?us-ascii?Q?kyRuem6ts/qgYBMi89l2rbBK/TE3Viz9lJLkiAEt59uD4CUgldV6C5Iaiwo0?=
 =?us-ascii?Q?rx30CtYy28/EI6NzgLUnH14Zxvd8SU6A0rKviQkDHd5CTe4yNhPqHw3Khj+E?=
 =?us-ascii?Q?cPCXYjqrNws2CgZ91xQYUMuZFcw1RV8qBzsB7fqLfyvaAWsa51xBHDqpTRaZ?=
 =?us-ascii?Q?NIwRbyawyeNFy6ubRjXPkewvOLtNxSebo8vnkn0pxOll+RjKZmQt5fZYbiZd?=
 =?us-ascii?Q?+aBxFM4n6/TXSHGZB/10hTtBIKhLag519UytDC7xoimDrC5xVA8sVLs0mv/z?=
 =?us-ascii?Q?RNqoZfBW7gnbdQye+fWHEDyOTcJhqECmc6sf/yfXbw7aAfDxEJDPcCvTd6jF?=
 =?us-ascii?Q?uDt1KKdBiIluPCofz7+2/2+rw36uM+h5A3V9o0BNN96tijmRC3jCVy2zGf2o?=
 =?us-ascii?Q?9ifMwh7dxZsvPljP7OxU05BquqG4vFUzQzqxo/4EDLFmoVm3UMIEXSU5sfe+?=
 =?us-ascii?Q?m9Z2q+GGd9pNvmXvJs6R0fWTEvesnx95SHHu9cz7p7DOxW/DAn5aFVOe1N4Z?=
 =?us-ascii?Q?UbZ8qFZu6ENp8V9EQ6cGNWDH/eIK+N/4cI6MqSQidQUHZMAgg3y69OOuHsMZ?=
 =?us-ascii?Q?ECj47xvcNfrKpF94Ap7tYjVpYaQRF7zSfOwwgH9TNQCdwuITVSphJ3G1arIf?=
 =?us-ascii?Q?HPv132vsLC+F+DSSVuuSCzBEYxKvObUEIlO2OrBpGNQKhk5RY0GjleOfF/My?=
 =?us-ascii?Q?jMHRbR3vUAaJVsjdYehC9jrMeWMkxMxckKt1mSmBCJ+38CtCt+zrP9ExzWji?=
 =?us-ascii?Q?VIusmv50B6mkAeKotAYSy0xZNHi9Cx+2X/j+qK2E+8WpfzocsYh6RvyKgXtC?=
 =?us-ascii?Q?9N0VS+FNjApwHBwiQeC9nR4+GbH1Xo1nXVwmX/V6PNTCvL9WvrEWI5fHsASd?=
 =?us-ascii?Q?3iXLwaEy53xe50qRsQPoTXdsO9F+yeUlFL1MuR2XbL3qke6FmwTJhJ6gIuRx?=
 =?us-ascii?Q?QLhSBzoVblZ4ur66IHt4DOcyn2QkueG9HYDnOf/bfu1cQS3NNmbplWDTHuqf?=
 =?us-ascii?Q?MIjkbzhVSfQLE3fdNplHNN+WrdZs/t3FJ3LxctMHLSJ1dDVLvWDTeU0nIbih?=
 =?us-ascii?Q?NmN+2bC0MWVieMhdw2RKatUjjEsvuRah+40M+HM47BzQtTLT75/TQxIV///x?=
 =?us-ascii?Q?dDhxQ380DBuLTDBHq1PadYVM8KX9lpPW5ZO6fWs8XoWv+TXjojuGh6zftqW+?=
 =?us-ascii?Q?Q/YgyYr1kB2Wd5soCuIr+zWiBeNkmm4kCuNEo2goDWJwMXFUUnn8coBFEoug?=
 =?us-ascii?Q?2rnqmglwzPlV7VfiSPNtC0PuGbb90lG2nC1auj+XQ9YaUwtqkC71vrjoIhNg?=
 =?us-ascii?Q?v6e3G9Y46hIERVE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:10:01.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75cc508-b217-44b4-2a9f-08dd34408d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Address was not previously populated which can result in incorrect
clock frequencies being read on boot.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 8082bb877611..a3b8e3d4a429 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -24,6 +24,8 @@
 
 #include "dml/dcn401/dcn401_fpu.h"
 
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+
 #define mmCLK01_CLK0_CLK_PLL_REQ                        0x16E37
 #define mmCLK01_CLK0_CLK0_DFS_CNTL                      0x16E69
 #define mmCLK01_CLK0_CLK1_DFS_CNTL                      0x16E6C
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 7a1ca1e98059..221645c023b5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -221,6 +221,7 @@ enum dentist_divider_range {
 	CLK_SF(CLK0_CLK_PLL_REQ, FbMult_frac, mask_sh)
 
 #define CLK_REG_LIST_DCN401()	  \
+	SR(DENTIST_DISPCLK_CNTL), \
 	CLK_SR_DCN401(CLK0_CLK_PLL_REQ,   CLK01, 0), \
 	CLK_SR_DCN401(CLK0_CLK0_DFS_CNTL, CLK01, 0), \
 	CLK_SR_DCN401(CLK0_CLK1_DFS_CNTL,  CLK01, 0), \
-- 
2.37.3

