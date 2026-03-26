Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3C6109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF72210E93C;
	Thu, 26 Mar 2026 03:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VvALEdcO";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC3F10E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6qvdN/HgNKkJ0lK+Ba793ERtM9gkrCy2eWjYN5vMOLKbv7qDqCMziUF4U13cjHyusCnVt7AKYg8OQg7+CI1bOiOSBUoNNsfscUq/ElhIJshTmZWRK3yGGfagFWFE962HTtqSN410iEUbjKP2qVkjp1MB2ijEQqffKVHEr6/X3iDAiLqkboSYXcZjR8pUnalNkPEzqZnYAbaiurm4e8xFRDtlSDdcWerWCyc1TWdXLP4qHHmNNaqWPj2SpBBfoWsE35g2R0+NwZTcIcgEX3UxZfuo9AHo3cOuc5uma9v2Lxk1ci9rsT/cpFlTxCzrJcSH4yDsqYYGZyun+SNXOocwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erbs7EWD5cTf6c2V9bL8qPRN2FbUI14yWr4iq+uT9LE=;
 b=SfdQZfvXA5DUeMmBbfuhZizOTjf9/Gb98q+atpb9RXo/9avJ8siauHWAlTA9MIHS6xlNTfmy8jtdS5QW6XykXqv4TMO5N6MjOs0K+l77P6v5LBOndhLdMaXL7KtK8Qof4pD1ZjQ7XdQWm+GKHWl0oliTiiwkApwv03UUCn250xx+QaPKXC7NbDtlXh5R9oQ9UuseKIQV48NX/CRtKO3W9zfi34YEXD8vR/fne0yp+LsJ5nPFSX4NxLMTYBIf0Ivg7bJY/uq4Uu9uD/vsIGlbiFuA3E67pqNcIChfgkw04q4AZuFZl+J3h/vxHoqnyOZhld7Gb+TVDy918ugrKFBWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erbs7EWD5cTf6c2V9bL8qPRN2FbUI14yWr4iq+uT9LE=;
 b=VvALEdcOBI3U8ReJ0QmNo9nag4vIFr+bWLPfvN8MftJ61He1HGMALtwWS1+RlF8UyTKIR38lqn7pWN5pCv/SQAQ0WJmYeA18hCRPJ1L/Lxw6NBkPUgs73JdiuQq4RybcD6/r1uLl7Y5RhzzvAZuicBYKI+UYnWN3uc5fPn0kpKY=
Received: from BL1PR13CA0168.namprd13.prod.outlook.com (2603:10b6:208:2bd::23)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 03:01:43 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::e) by BL1PR13CA0168.outlook.office365.com
 (2603:10b6:208:2bd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:43 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:39 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 19/30] drm/amd/display: Remove invalid DPSTREAMCLK mask
 usage
Date: Thu, 26 Mar 2026 10:57:10 +0800
Message-ID: <20260326030153.406612-20-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 027b836b-242a-4963-1143-08de8ae40299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: usc/md+6SVLkXk3zJtjv2gUB0TVGm2g/dO6ur0E9hx5cLC6/zpJICoNRLgIXkdcReakP13Kn+/mxWQS1mBzIa8pjCAVeMAOYoypBqh11oWSC580v4OyzY73tkaixA/szGvFtxDwDM/u8dgtxSdJyQaZTrcppjkuV5dmjwEeCfbmnliJyN3Lx8fBI7cdWkVWZu2WJGq5/o3oKgiDs0N7sq4gm8HofjiBjtmnhVfEY0Fc9V6pjvQQIwAPPtLYrZpCTyfgoo7FOUx9JGiZsiReEKfUw3Fgdvlae065gXNgYlHUnuULupZZb1/6SBqr2b55jjdQwZctTo/xi5eszg+TxId6i6HNXa+vAUV56to41SI189gt/ZlBFfPF2wCmosU+OgpIkKdQ+hrM4a6e7lLwDM/OZ4r+dbnnCMraBmEO0opCm1QtyOUedAe8MqbuT5YJoYuz7llRDZl6wWd00vkSSAVzCwucdS16jSCccSSyypd2wdonTIdnRqiXgjDpSPvwKtHW+BD339nwzdPWLwNPJFtpAKsrDtLQilLV5sEIO/z2FunT0l1++aUack4Fgl64Bo2tEfa/uHHY5IzlA5+CES/RsyNL6zeqMREHKtz4rqqmC5619uQ1IP/g2NMkHLzCrAsCRqYuC2WJAvvVo14zZejRQjIQm/JTKekBUiuKea83pCjHk2eIVKkU9T+MgUFe5XCLPcXgPBE542bsivmZQ5Lnt5K7gh/dfMHDA5P2HWK4cXP8UodUeFueWkJ9P0j1eOdWarMdzK5t9p/wXwEdJPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +6L/RvobL5k1ErSmWcjYzG7d7jEVt/Y8s7pZOdyFstHQq5U9T4HV15Ct95Ww5jEiv7QU6x6u1T9ySJoH1LlIrfKvESsUgHf9jtNOgCaVrG3FX3EV3tx5Au9c7aUHsm1ALa8I+aQ7Oqq5gXGrXTA+VS2RuDH95iURa5bWm3c/77QtT7doOgBdF+IBbPCfXlmEb99a59MOz2FOjG0l8Hm1INqVMhLgKkmVo/HNuwWFPLLvA05w/zI+Nl8i6DEkRs7i/GNcAsoZtYABK/3MOl+uuw+Ypj5bgkJYAn23lSHU8xqVe8yENXojfCZP1KFB9QLF182/cyOTsGqLOiwEcTBypiKf0WSWgJClSw8HTzDf6ldY5D2R3cpw4838UN7cpiOuwjjZwRAnPmgSiMm9Iqe8vHwzeb1J13uBnVqfglengvNo04UI3qqKYjUHvxHrSdwE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:43.3570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027b836b-242a-4963-1143-08de8ae40299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The invalid register field access causes ASSERT(mask != 0) to fire
in set_reg_field_values() during display enable.

WARNING: at drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:100
set_reg_field_values.isra.0+0xcf/0xf0 [amdgpu]
Call Trace:
 <TASK>
generic_reg_update_ex+0x66/0x1d0 [amdgpu]
dccg401_set_dpstreamclk+0xed/0x350 [amdgpu]
dcn401_enable_stream+0x165/0x370 [amdgpu]
link_set_dpms_on+0x6e9/0xe90 [amdgpu]
dce110_apply_single_controller_ctx_to_hw+0x343/0x530 [amdgpu]
dce110_apply_ctx_to_hw+0x1f6/0x2d0 [amdgpu]
dc_commit_state_no_check+0x49a/0xe20 [amdgpu]
dc_commit_streams+0x354/0x570 [amdgpu]
amdgpu_dm_atomic_commit_tail+0x6f8/0x3fc0 [amdgpu]

DCN4.x hardware does not have DPSTREAMCLK_GATE_DISABLE and
DPSTREAMCLK_ROOT_GATE_DISABLE fields in DCCG_GATE_DISABLE_CNTL3.
These global fields only exist in DCN3.1.x hardware.

[How]
Remove the call that tries to update non-existent fields in CNTL3.
DCN4.x uses per-instance fields in CNTL5 instead,
which are already correctly programmed in the switch cases above.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 0cdf93c614b7..f4ead86c9a96 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -526,10 +526,6 @@ static void dccg401_enable_dpstreamclk(struct dccg *dccg, int otg_inst, int dp_h
 		BREAK_TO_DEBUGGER();
 		return;
 	}
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
-		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
-			DPSTREAMCLK_GATE_DISABLE, 1,
-			DPSTREAMCLK_ROOT_GATE_DISABLE, 1);
 }
 
 void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst)
-- 
2.43.0

