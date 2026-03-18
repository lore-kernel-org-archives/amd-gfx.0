Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEECFED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1DD10E5FB;
	Wed, 18 Mar 2026 01:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLFTEShJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE6010E5FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmT2x29K9m0dXbSmBz02I/lPv9brvI3HAzgMPm/tw68r4Vgvbu7A02kSrumcB6wqkLI81MCqM3nFGXp6gf68sJ0vyw4ysrzYegX+Q+CiXwNMBWnbaMLH4Diw3HgTsabQKFnTy2PayhUhMV7yGabIoEhuyIJ/Fim1uuCxseNrVHiDO7teEatrSTUCR/VxSDfWLM9ubnCJHk9IexW3lBC6c3OBdsIw5oInBVJm6cOebMS1/y1kgJqNAJXQpwnA6dwTXMM06JLV/L+MHs5bquN+iPhTtRmvhZIUaslL3mm8p8km2Fxwo0SnfytdLxbXZ5rUCzpdAGzeSzMFrNIVJ27N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYJx96SOlkie6AA9n36F8+LRMxJtLO0bGQlPY0k1lPo=;
 b=h5JpoIIU3ychzmPazbAmMwcG+uylqn49Cd2b4kcgP9Ye4MO4/j2JcFmebHE5iViphpBKpbDvVV7kXE8sXaDNHzRJGh80PBt6427c2oCvnSXdZZrJwIBFwvu1phno5N2toTpwsCQU1YRklA5+ogZM3IibFiAgSP0N4EWc5rUtbNQB13KtsrkMcafLlCytXgU/6OJsA3q7LW8/2fV8B/681eNNAQnRVVe7bdDMkxfIMP2cGcAzxYTc18tOJFkW0coFHYqfkrS346LDEvryeAmuwlTaGgYomQU/6iYjSYEBanHdqYwWhEEUfdAQJSvlO6ROMaHXXlk1590YGpHVNl7YZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYJx96SOlkie6AA9n36F8+LRMxJtLO0bGQlPY0k1lPo=;
 b=kLFTEShJAYtv1VxRPHW08Nki+u9IAtMpDltRtiMNruuhj8YUL7TIcyZPAtyT0aXr73PhmW5EGEuYqOk/Qxsx7/gyhxa74OggYBLPTtryux7sm/dAiKKnqjt1Wc3tovm4ht21vEh0jC/67xuXy39Cc0ZeD70aM5dvbL1eBHjZ1W4=
Received: from PH0PR07CA0074.namprd07.prod.outlook.com (2603:10b6:510:f::19)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 01:01:47 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::1d) by PH0PR07CA0074.outlook.office365.com
 (2603:10b6:510:f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:45 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:41 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 12/31] drm/amd/display: Add Extra SMU Log for dtbclk
Date: Wed, 18 Mar 2026 08:59:21 +0800
Message-ID: <20260318010224.513094-13-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1887da7a-5a26-472b-98f0-08de8489ecef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ntgizitrp2dYN2LRYlt/fCxQZpQgEjkmOkPYt53LL0WLfTlDVqDumLNKDwfajsIt0Xzf6zl334omqhzGJ1By3muyw0IGGVOYhEgXyZ5pjXeQlK0KI6aBIbDn2sBhEFVPuxxlgpjZYN1PPpT8Qbj1ONyhBhqycdn2C3vQKOq8XNKBLxLuhM/VHnY9bvWfTP666tIRS8B1LST0slkhseAZ4cDqF1L9oELmVcf9URPtqmQcjSsSCR4htYWrFy/7r0W/saA/i86MF4u0a0+344z/C/BQb4tyaXsLE+iDk134SQ86USdCa1yUtw7GFJMzMwMbxeJFiUCQh9JRFD0maTbPROPJ1rBbY+YFNIAzQs6GbV3Ls0CRjswabKjqdkIQ00+iLRRmA5zxpoKpvcqnuZiX1ZocVfMYbH8Zn3VZCr3BaRwPb6hURoz9f0MAPiODInoldpcbiQZOemtT1qhE3m/y6JJXKIUSjAn3aGq1N2n2vJg59RfGdiGlqgLpnmNA8S6kieCWwuOPYXd0hlEKKIGaBAVOhgDppCp1lGnr8HvH5sgPqMVafYIs0FHJ8ik5U/zjYgYUxWbTcydvzpKWQUUCZX9Amj4oleO1FVVcHJPHh5UzbDImjwD0MdXaPC3fW024x4u65sbnxFknfkUDbSETdGGyBobGZr4DXrJnsPaw9Kzd/sQwx1/HcjfziM/Sc779muwdNG7QCaQByk2UcFT3wKEy9Q6RD9pnU0dTceqOtzqdlCFyyb/8MZM9OZUsnszS7x9m+wmPoz8ol5iMTX2/4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R2DqaJKZadu88rL+Dew1yG+89OWgFtofOufMXHmmNZnfXoCxz5ls/1bms6aXJl7HS57JFzG3PzK0L8LjMrXhGVadiupJ8C2zbN27iKN9WzeqwETDjRc73EYOr3J8msbJqi32QG3DZSxarHbh+JiIe8v63PynR+TZIXhqEJDehknB8vX0Yqahl5FppKbi3j5k/8/B4+jh4g9YcW2jz5ROEde9Vuwwge9LVfwyOhzpBAVaIz6Sf43UbNIBgT6iDijarNPfMcrCzMaVCe6X7ri3yzpxIQHxdtMqKi1sn0xjzrZ4I0M0f9X6zmYBQnuZPB40eGAnsEAiaL1MpNYAlaGuL3j9Bn2VY/bsRcs5O9/7+LDJb2TZriop2TvsXQjdfJIY5opyHE2mJv18dfbpZ/L/fo0AXktKqjgfJ8yGHDBwIUqkVu1FvAwbJGLvGygilidU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:45.3309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1887da7a-5a26-472b-98f0-08de8489ecef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
need to check dtbclk in log for confirmation

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index bc11510b63a1..7134d8998efc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -474,6 +474,9 @@ static void dcn42_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 		DC_LOG_SMU("CLK1_CLK1_CURRENT_CNT,%d,dppclk\n",
 					internal.CLK8_CLK1_CURRENT_CNT);
 
+		DC_LOG_SMU("CLK1_CLK4_CURRENT_CNT,%d,dtbclk\n",
+					internal.CLK8_CLK4_CURRENT_CNT);
+
 		DC_LOG_SMU("CLK1_CLK3_BYPASS_CNTL,%d,dcfclk_bypass\n",
 					internal.CLK8_CLK3_BYPASS_CNTL);
 
-- 
2.43.0

